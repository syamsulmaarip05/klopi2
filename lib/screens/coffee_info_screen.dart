import 'package:flutter/material.dart';

class CoffeeInfoScreen extends StatelessWidget {
  const CoffeeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Kopi'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.coffee_outlined, size: 80, color: Colors.brown[300]),
            const SizedBox(height: 20),
            Text(
              'Halaman Info Kopi',
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
