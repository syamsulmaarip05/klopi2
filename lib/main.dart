import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'dart:async';

void main() {
  runApp(const KlopiApp());
}

class KlopiApp extends StatelessWidget {
  const KlopiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DetectCoffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(), // Mengubah HomeScreen menjadi SplashScreen
    );
  }
}

// Tambahkan class SplashScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Menggunakan super parameter untuk key

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState(); // Mengubah return type menjadi State<SplashScreen>
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer untuk berpindah ke halaman utama setelah 3 detik
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo aplikasi Anda
            Image.asset(
              'assets/icon.png', // Pastikan logo sudah ditambahkan di pubspec.yaml
              width: 150,
              height: 150,
            ),

            // Opsional: tambahkan teks atau widget lain di bawah logo
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.brown), // Sesuaikan dengan warna tema Anda
            ),
          ],
        ),
      ),
    );
  }
}
