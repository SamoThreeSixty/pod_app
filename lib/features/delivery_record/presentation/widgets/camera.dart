import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/service/file_service.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController? _controller;
  late List<CameraDescription> _cameras;
  late Future<void> _initialiseCameraFuture;

  bool imageSelected = false;
  XFile? selectedImage;

  final FileService _fileService = FileService();

  Future<void> _initCamera() async {
    _cameras = await availableCameras(); // Fetch available cameras
    _controller = CameraController(_cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
  }

  // This wont be needed / used here, but will leave for now as a reference
  Future<void> _saveImage(XFile image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir == null) {
        print('External storage not available');
        return;
      }

      final imagePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await image.saveTo(imagePath);

      String externalPath = externalDir.path;

      await _fileService.moveFileToExternalStorage(imagePath, externalPath, 1);

      print('Image saved to: $imagePath');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> onSelectImage(XFile image) async {
    // Here we will provide the function for viewing selected image before confirming

    setState(() {
      imageSelected = true;
      selectedImage = image;
    });
  }

  @override
  void initState() {
    _initialiseCameraFuture = _initCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _initialiseCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: imageSelected && selectedImage != null
                      ? Image(
                          image: FileImage(
                            File(selectedImage!.path),
                          ),
                        )
                      : CameraPreview(_controller!),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final image = await _controller!.takePicture();

                          onSelectImage(image);
                        },
                        icon: const Icon(Icons.camera),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            imageSelected = false;
                            selectedImage = null;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                      imageSelected
                          ? IconButton(
                              onPressed: () {
                                Navigator.pop(context, selectedImage);
                              },
                              icon: const Icon(Icons.check),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
