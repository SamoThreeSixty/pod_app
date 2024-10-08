import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageThumbnail extends StatelessWidget {
  final String selectedImage;

  const ImageThumbnail({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _showFullImage(context, selectedImage);
        },
        child: Image.file(
          File(selectedImage),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

void _showFullImage(BuildContext context, String image) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Image.file(
            File(image),
            fit: BoxFit.cover, // Adjust to fit the full image
          ),
        ),
      );
    },
  );
}
