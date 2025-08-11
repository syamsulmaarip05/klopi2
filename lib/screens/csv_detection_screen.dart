import 'package:flutter/material.dart';

class CsvDetectionScreen extends StatelessWidget {
  const CsvDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deteksi CSV'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_file, size: 80, color: Colors.brown[300]),
            const SizedBox(height: 20),
            Text(
              'Halaman Deteksi CSV',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Konten akan ditambahkan di sini',
              style: TextStyle(fontSize: 16, color: Colors.brown[600]),
            ),
          ],
        ),
      ),
    );
  }
}
