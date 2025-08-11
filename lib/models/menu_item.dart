import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;

  // Make constructor const so it can be used in const contexts
  const MenuItem(this.title, this.icon);
}
