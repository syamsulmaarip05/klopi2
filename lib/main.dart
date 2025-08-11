import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const KlopiApp());
}

class KlopiApp extends StatelessWidget {
  const KlopiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLOPI - Coffee Bean Quality Detection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
