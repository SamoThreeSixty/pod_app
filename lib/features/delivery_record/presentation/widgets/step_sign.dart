import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class StepSignature extends StatefulWidget {
  const StepSignature({super.key});

  @override
  State<StepSignature> createState() => _StepSignatureState();
}

class _StepSignatureState extends State<StepSignature> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: const Color.fromARGB(255, 0, 0, 0),
    exportBackgroundColor: Colors.blue,
  );

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
                      setState(() => _signatureController.disabled =
                          !_signatureController.disabled);
                    },
                    child: const Text('Confirm'),
                  ),
          ],
        ),
      ],
    );
  }
}
