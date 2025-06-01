import 'package:flutter/material.dart';

class ChipInfoWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  const ChipInfoWidget({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      backgroundColor: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    );
  }
}