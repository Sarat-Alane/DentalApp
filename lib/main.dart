import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental Disease Detection',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DetectionScreen(),
    );
  }
}

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  Uint8List? _imageBytes;
  List<Map<String, dynamic>> _detections = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = pickedFile;
        _imageBytes = bytes;
        _detections.clear();
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("Choose from gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _detectDiseases() async {
    if (_imageFile == null) return;

    final uri = Uri.parse("https://dentaldetection.onrender.com/predict");
    final request = http.MultipartRequest("POST", uri);
    request.files.add(await http.MultipartFile.fromPath("file", _imageFile!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      setState(() {
        _detections = List<Map<String, dynamic>>.from(jsonResponse["predictions"]);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Detection failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = _imageBytes != null
        ? Stack(
      children: [
        Image.memory(_imageBytes!),
        if (_detections.isNotEmpty)
          Positioned.fill(
            child: CustomPaint(
              painter: BoundingBoxPainter(_detections),
            ),
          ),
      ],
    )
        : const Text("No image selected.");

    return Scaffold(
      appBar: AppBar(title: const Text("Dental Disease Detection")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            child: Center(child: imageWidget),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.upload_file),
            label: const Text("Upload Image"),
            onPressed: _showImageSourceDialog,
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.search),
            label: const Text("Detect Diseases"),
            onPressed: _detectDiseases,
          ),
        ]),
      ),
    );
  }
}

class BoundingBoxPainter extends CustomPainter {
  final List<Map<String, dynamic>> detections;

  BoundingBoxPainter(this.detections);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (var detection in detections) {
      final bbox = detection["bbox"];
      final label = detection["label"];
      final confidence = detection["confidence"];

      final rect = Rect.fromLTRB(
        bbox[0].toDouble(),
        bbox[1].toDouble(),
        bbox[2].toDouble(),
        bbox[3].toDouble(),
      );

      paint.color = Colors.red;
      canvas.drawRect(rect, paint);

      final text = "$label (${(confidence * 100).toStringAsFixed(1)}%)";
      textPainter.text = TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(rect.left, rect.top - 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
