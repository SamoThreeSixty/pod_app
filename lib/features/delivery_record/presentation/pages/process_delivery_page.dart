import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_controls.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_images.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_items.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_sign.dart';

class ProcessDeliveryPage extends StatefulWidget {
  final DeliveryHeader deliveryHeader;

  const ProcessDeliveryPage({
    super.key,
    required this.deliveryHeader,
  });

  @override
  State<ProcessDeliveryPage> createState() => _ProcessDeliveryPageState();
}

class _ProcessDeliveryPageState extends State<ProcessDeliveryPage> {
  int currentStep = 0;

  List<String> signaturePaths = [];
  String signaturePath = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Text('Process Delivery'),
            Container(
              width: 20,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return const SizedBox.shrink(); // Hide the default buttons
              },
              currentStep: currentStep,
              elevation: null,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StepControls(
                  cancelSteps: () {
                    Navigator.pop(context);
                  },
                  changeStep: (newStep) {
                    setState(() {
                      currentStep = newStep;
                    });
                  },
                  currentStep: currentStep,
                  action: 'Back',
                ),
                StepControls(
                  completeSteps: () => _validateProcessSteps()
                      ? confirmDelivery()
                      : print(
                          "more to do"), // TODO: Show an alert that information is missing
                  changeStep: (newStep) {
                    setState(() {
                      currentStep = newStep;
                    });
                  },
                  currentStep: currentStep,
                  action: 'Next',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void confirmDelivery() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            children: [
              Image.file(
                File(signaturePath),
                fit: BoxFit.cover, // Adjust to fit the full image
              ),
            ],
          ),
        );
      },
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Items'),
          content: StepItems(
            deliveryHeaderId: widget.deliveryHeader.id,
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Images'),
          content: const StepImages(),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Sign'),
          content: StepSignature(
            onStringChanged: (String emittedSignaturePath) {
              setState(
                () {
                  debugger();
                  signaturePath = emittedSignaturePath;
                },
              );
            },
          ),
        )
      ];

  bool _validateProcessSteps() {
    return true;
  }
}
