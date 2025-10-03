import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _result;

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _processImage(File(pickedFile.path));
    }
  }

  // Function to capture image from camera
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _processImage(File(pickedFile.path));
    }
  }

  // Function to handle image processing and model inference
  void _processImage(File image) {
    setState(() {
      _image = image;
      _isLoading = true; // Show loading indicator
      _result = null; // Clear previous results
    });

    // --- SIMULATE AI MODEL ANALYSIS ---
    // In a real app, you would run your TFLite model here.
    // Use an Isolate or compute function for heavy processing to avoid UI lag.
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        // This is a placeholder result
        _result = 'Potential Cavity Detected (Confidence: 89%)';
        _isLoading = false; // Hide loading indicator
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cavity Detection'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- TOP SECTION (INPUT) ---
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: Center(
                child: _image == null
                    ? const Text('No image selected.', style: TextStyle(fontSize: 16))
                    : Container(
                  padding: const EdgeInsets.all(16),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // --- BOTTOM SECTION (OUTPUT & ACTIONS) ---
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
            ),
            child: Column(
              children: [
                // --- RESULT DISPLAY ---
                SizedBox(
                  height: 60,
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                      _result ?? 'Results will appear here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // Use color to provide quick visual feedback
                        color: _result != null ? Colors.red.shade700 : Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // --- ACTION BUTTONS ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_library_outlined, size: 32),
                      onPressed: _pickImageFromGallery,
                      tooltip: 'Upload from Gallery',
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, size: 32),
                      onPressed: _pickImageFromCamera,
                      tooltip: 'Open Camera',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
