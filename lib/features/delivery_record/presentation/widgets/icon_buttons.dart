import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/camera.dart';

class CameraButton extends StatelessWidget {
  final Color color;
  final Icon icon;

  final ImagePicker _picker = ImagePicker();

  // To emit to parent
  final Function(XFile) onImageCaptured;

  CameraButton({
    super.key,
    required this.color,
    required this.icon,
    required this.onImageCaptured,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final XFile? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CameraWidget();
            },
          ),
        );

        if (result != null) {
          onImageCaptured(result);
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [icon, const Text(' Take a picture')],
          ),
        ),
      ),
    );
  }
}

class GalleryButton extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  final Function(XFile?) onImageSelected;

  final Color color;
  final Icon icon;

  GalleryButton({
    super.key,
    required this.color,
    required this.icon,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [icon, const Text(' Search gallery')],
          ),
        ),
      ),
    );
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    onImageSelected(image);
  }
}
