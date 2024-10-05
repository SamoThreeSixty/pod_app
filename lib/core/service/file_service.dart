import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileService {
  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      // Permission granted
      print('Storage permission granted');
    } else {
      // Handle the case when permission is denied
      print('Storage permission denied');
    }
  }

  Future<String?> _getExternalStorageDirectory() async {
    Directory? externalDir = await getExternalStorageDirectory();
    return externalDir?.path;
  }

  Future<String> getPublicDownloadsDirectory() async {
    Directory downloadsDir = (await getExternalStorageDirectory())!;
    return downloadsDir.path;
  }

  Future<void> moveFileToExternalStorage(
      String sourcePath, String destinationDirectory, int imageNumber) async {
    try {
      await Gal.hasAccess();

      File sourceFile = File(sourcePath);

      List<int> fileBytes = await sourceFile.readAsBytes();
      Uint8List uint8List =
          Uint8List.fromList(fileBytes); // Convert to Uint8List

      if (sourcePath.endsWith('.jpg') || sourcePath.endsWith('.png')) {
        await Gal.putImageBytes(uint8List);
      }
    } catch (e) {
      print('Error moving file: $e');
    }
  }

  Future<void> saveImageToGallery(String sourcePath) async {
    try {
      await Gal.hasAccess();

      File sourceFile = File(sourcePath);

      List<int> fileBytes = await sourceFile.readAsBytes();
      Uint8List uint8List =
          Uint8List.fromList(fileBytes); // Convert to Uint8List

      if (sourcePath.endsWith('.jpg') || sourcePath.endsWith('.png')) {
        await Gal.putImageBytes(uint8List);
      }
    } catch (e) {
      print('Error moving file: $e');
    }
  }
}
