import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';

class StepSignature extends StatefulWidget {
  final Function(String) onStringChanged;

  const StepSignature({super.key, required this.onStringChanged});

  @override
  State<StepSignature> createState() => _StepSignatureState();
}

class _StepSignatureState extends State<StepSignature> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: const Color.fromARGB(255, 0, 0, 0),
    exportBackgroundColor: Colors.blue,
  );

  Future<void> saveImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final imagePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Uint8List? image =
          await _signatureController.toPngBytes(height: 1000, width: 1000);

      if (image != null) {
        final File file = File(imagePath);
        await file.writeAsBytes(image);
        widget.onStringChanged(imagePath);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Signature(
          controller: _signatureController,
          height: 200,
          backgroundColor: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  _signatureController.disabled
                      ? setState(() {
                          _signatureController.clear();
                          _signatureController.disabled = false;
                        })
                      : setState(() => _signatureController.undo());
                },
                child: Text(
                  _signatureController.disabled ? 'Clear' : 'Undo',
                )),
            _signatureController.disabled
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      setState(
                        () {
                          _signatureController.disabled =
                              !_signatureController.disabled;
                        },
                      );
                      if (_signatureController.disabled) {
                        saveImage();
                      }
                    },
                    child: const Text('Confirm'),
                  ),
          ],
        ),
      ],
    );
  }
}
