import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/icon_buttons.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/image_thumbnail.dart';

class StepImages extends StatefulWidget {
  final Function(String) onSaveImage;
  final Function(String) onDeleteImage; //tba later

  const StepImages(
      {super.key, required this.onSaveImage, required this.onDeleteImage});

  @override
  State<StepImages> createState() => _StepImagesState();
}

class _StepImagesState extends State<StepImages> {
  List<XFile> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CameraButton(
              color: Colors.blue,
              icon: const Icon(Icons.camera_alt),
              onImageCaptured: (XFile image) {
                setState(() {
                  selectedImages.add(image);
                });
                widget.onSaveImage(image.path);
              },
            ),
            GalleryButton(
              color: Colors.blue,
              icon: const Icon(Icons.image_search_rounded),
              onImageSelected: (image) {
                setState(() {
                  selectedImages.add(image!);
                });
              },
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 8.0,
            runSpacing: 8.0,
            children: selectedImages.map(
              (image) {
                return ImageThumbnail(selectedImage: image.path);
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
