import 'package:flutter/material.dart';

class StatusPill extends StatelessWidget {
  final int status;

  const StatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String displayText;

    switch (status) {
      case 0:
        color = Colors.blue;
        displayText = 'Active';
        break;
      case 1:
        color = Colors.red;
        displayText = 'Failed';
        break;
      case 2:
        color = Colors.green;
        displayText = 'Complete';
        break;
      case 3:
        color = Colors.orange;
        displayText = 'Part Done';
        break;
      default:
        color = Colors.grey;
        displayText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        displayText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 8,
        ),
      ),
    );
  }
}
