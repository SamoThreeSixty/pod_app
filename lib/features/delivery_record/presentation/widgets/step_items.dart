import 'package:flutter/material.dart';

class StepItems extends StatefulWidget {
  const StepItems({super.key});

  @override
  State<StepItems> createState() => _StepItemsState();
}

class _StepItemsState extends State<StepItems> {
  int selectedButton = -1;
  final bool _showTooltip = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8,
          ),
          child: buttons('Fully Delivered', Colors.green, 0),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8,
          ),
          child: buttons('Part Delivered', Colors.amber, 1),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8,
          ),
          child: buttons('Failed', Colors.red, 2),
        ),
        _showTooltip
            ? const Tooltip(
                message: 'Select an input',
                child: Text(
                  'Please select an input!',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget buttons(String text, Color color, int index) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          setState(() {
            selectedButton = index;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            if (selectedButton == index) ...[
              const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
