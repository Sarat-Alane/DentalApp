import 'package:flutter/material.dart';
import 'detection_page.dart'; // Import the detection page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main headline card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/dental.png', // The path to your image
                      width: 100, // You can control the size with width and height
                      height: 100,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'AI-Powered Cavity Screening',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Get an instant preliminary check of your dental health.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // "How it Works" section
            const Text(
              'How It Works',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const InfoTile(
              icon: Icons.camera_alt_outlined,
              title: '1. Snap a Photo',
              subtitle: 'Take a clear, well-lit photo of the tooth.',
            ),
            const InfoTile(
              icon: Icons.memory_outlined,
              title: '2. AI Analysis',
              subtitle: 'Our algorithm analyzes the image for potential issues.',
            ),
            const InfoTile(
              icon: Icons.bar_chart_outlined,
              title: '3. Get Instant Results',
              subtitle: 'View the analysis and recommendations instantly.',
            ),
            const Spacer(),

            // Call-to-action button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DetectionPage()),
                );
              },
              child: const Text('Start Detection'),
            ),
            const SizedBox(height: 16),

            // Disclaimer
            const Text(
              'Disclaimer: This is not a substitute for professional dental diagnosis. Always consult a certified dentist for proper results and medications.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// A helper widget for the "How it Works" list tiles
class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 30, color: Colors.blue.shade600),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}
