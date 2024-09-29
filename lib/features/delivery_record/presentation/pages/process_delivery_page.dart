import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pod_app/core/service/file_service.dart';
import 'package:pod_app/core/service/supabase_storage.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/icon_buttons.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/image_thumbnail.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_controls.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_images.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_items.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_sign.dart';
import 'package:signature/signature.dart';

class ProcessDeliveryPage extends StatefulWidget {
  const ProcessDeliveryPage({super.key});

  @override
  State<ProcessDeliveryPage> createState() => _ProcessDeliveryPageState();
}

class Product {
  bool isAvailable;
  final int quantity;
  final String name;

  Product({
    required this.isAvailable,
    required this.quantity,
    required this.name,
  });
}

class _ProcessDeliveryPageState extends State<ProcessDeliveryPage> {
  int currentStep = 0;

  FileService fileService = FileService();

  List<Product> products = [
    Product(isAvailable: false, quantity: 0, name: 'Smartphone'),
    Product(isAvailable: false, quantity: 10, name: 'Laptop'),
    Product(isAvailable: false, quantity: 5, name: 'Headphones'),
    Product(isAvailable: false, quantity: 2, name: 'Keyboard'),
    Product(isAvailable: false, quantity: 0, name: 'Smartphone'),
    Product(isAvailable: false, quantity: 5, name: 'Headphones'),
    Product(isAvailable: false, quantity: 2, name: 'Keyboard'),
    Product(isAvailable: false, quantity: 0, name: 'Smartphone'),
    Product(isAvailable: false, quantity: 5, name: 'Headphones'),
    Product(isAvailable: false, quantity: 2, name: 'Keyboard'),
    Product(isAvailable: false, quantity: 0, name: 'Smartphone'),
    Product(isAvailable: false, quantity: 5, name: 'Headphones'),
    Product(isAvailable: false, quantity: 2, name: 'Keyboard'),
  ];

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
          )),
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
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) return;

                setState(() => currentStep += 1);
              },
              onStepCancel: () {
                Navigator.pop(context);
              },
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
                  completeSteps: () => print("completed it mate"),
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

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Items'),
          content: const StepItems(),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Images'),
          content: const StepImages(),
        ),
        Step(
          // TODO: finalise signing
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Sign'),
          content: const StepSignature(),
        )
      ];

  // This is an optional useage
  Column CheckDeliveries() {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const Text('Confirm your delivery'),
              ...products.map(
                (product) => ListTile(
                  title: Text(product.name),
                  leading: Checkbox(
                    value: product.isAvailable,
                    onChanged: (bool? newValue) {
                      setState(
                        () {
                          product.isAvailable = newValue ?? false;
                        },
                      );
                    },
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        print("Pressed");
                      },
                      icon: const Icon(Icons.edit)),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
