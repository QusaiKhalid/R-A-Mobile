import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RowContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDarkModeEnabled;
  final double height;

  const RowContainer({
    required this.icon,
    required this.text,
    required this.isDarkModeEnabled,
    this.height = 60, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // Set the height dynamically
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: isDarkModeEnabled ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: isDarkModeEnabled ? Colors.black54 : Colors.grey[300]!,
            offset: const Offset(2, 2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: isDarkModeEnabled ? Colors.grey[700]! : Colors.white,
            offset: const Offset(-2, -2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: isDarkModeEnabled ? Colors.white : Colors.black),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isDarkModeEnabled ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

