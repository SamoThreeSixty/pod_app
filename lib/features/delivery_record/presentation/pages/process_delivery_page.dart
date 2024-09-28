import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pod_app/core/service/file_service.dart';
import 'package:pod_app/core/service/supabase_storage.dart';
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
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: const Color.fromARGB(255, 0, 0, 0),
    exportBackgroundColor: Colors.blue,
  );

  List<XFile> selectedImages = [];

  int currentStep = 0;

  int selectedButton = -1;

  bool _showTooltip = false;

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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 55),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    switch (currentStep) {
                      case 0:
                        Navigator.pop(context);
                        break;
                      case 1:
                        setState(() => currentStep -= 1);
                        break;
                      case 2:
                        setState(() => currentStep -= 1);
                        break;
                    }
                  },
                  child: const Text('Back'),
                ),
                Tooltip(
                  message: 'Select an input',
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 55),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () async {
                      switch (currentStep) {
                        case 0:
                          // TODO: make this have a tooltip message for the user
                          if (selectedButton == -1) {
                            setState(() => _showTooltip = true);
                            Future.delayed(const Duration(seconds: 3), () {
                              setState(() => _showTooltip = false);
                            });
                          } else {
                            setState(() => currentStep += 1);
                          }
                          break;
                        case 1:
                          setState(() => currentStep += 1);
                          break;
                        case 2:
                          fileService.requestStoragePermission();
                          String destination =
                              await fileService.getPublicDownloadsDirectory();

                          selectedImages.asMap().forEach((index, image) async {
                            await fileService.moveFileToExternalStorage(
                                image.path, destination, index);
                            await SupabaseStorageService()
                                .uploadPodImage(File(image.path), 204, index);
                          });

                          break;
                      }
                    },
                    child: currentStep == 2
                        ? const Text('Review')
                        : const Text('Continue'),
                  ),
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
            content: Column(
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
            )),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Images'),
          content: Column(
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
                  children: selectedImages.map((image) {
                    return ImageThumbnail(selectedImage: image);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Step(
          // TODO: finalise signing
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Sign'),
          content: Container(
            child: Signature(
              controller: _signatureController,
              height: 200,
              backgroundColor: Colors.blue,
            ),
          ),
        )
      ];

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
