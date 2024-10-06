import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/core/service/file_service.dart';
import 'package:pod_app/core/service/supabase_storage.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_record/presentation/bloc/delivery_detail_bloc.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/image_thumbnail.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_controls.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_images.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_items.dart';
import 'package:pod_app/features/delivery_record/presentation/widgets/step_sign.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // Emits from items
  int deliveryState = -1;

  // Emits from images
  List<String> imagePaths = [];
  String signaturePath = '';

  List<String> errorMessages = [];

  final FileService _fileService = FileService();

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
                      : errorDialog(),
                  changeStep: (newStep) {
                    bool error = false;
                    String? errorMessage;
                    // Here we can check that we have all the information before
                    // moving onto the next step
                    switch (newStep) {
                      // If we have not selected a state, we will show an error
                      case 1:
                        error = deliveryState < 0 ? true : false;
                        errorMessage =
                            deliveryState < 0 ? 'Please select a state' : null;
                      case 2:
                        error = imagePaths.isEmpty ? true : false;
                        errorMessage = imagePaths.isEmpty
                            ? 'Please provide some images'
                            : null;
                    }

                    if (!error) {
                      setState(() {
                        currentStep = newStep;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage!),
                        ),
                      );
                    }
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
          content: StepItems(
            onStateSelect: (selectedState) {
              setState(
                () {
                  deliveryState = selectedState;
                },
              );
            },
            deliveryHeaderId: widget.deliveryHeader.id,
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Images'),
          content: StepImages(
            onDeleteImage: (deleteImagePath) {
              imagePaths.remove(deleteImagePath);
            },
            onSaveImage: (addImagePath) {
              imagePaths.add(addImagePath);
            },
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Sign'),
          content: StepSignature(
            onStringChanged: (String emittedSignaturePath) {
              setState(
                () {
                  signaturePath = emittedSignaturePath;
                },
              );
            },
          ),
        )
      ];

  bool _validateProcessSteps() {
    bool returnValue = true;
    errorMessages.clear();

    if (signaturePath.isEmpty) {
      errorMessages.add('Please provide a signature');
      returnValue = false;
    }

    if (imagePaths.isEmpty) {
      errorMessages.add('Please provide at lease one image');
      returnValue = false;
    }

    return returnValue;
  }

  void confirmDelivery() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: BlocBuilder<DeliveryDetailBloc, DeliveryDetailState>(
              builder: (context, state) {
                if (state is SaveSignatureAndImagesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is SaveSignatureAndImagesFailure) {
                  return Column(
                    children: [
                      const Text("Failure"),
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Try again'),
                      ),
                    ],
                  );
                }

                if (state is SaveSignatureAndImagesSuccess) {
                  return Column(
                    children: [
                      const Text("Success"),
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Return to list'),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    const Text(
                      'Images',
                      style: TextStyle(fontSize: 40),
                    ),
                    Wrap(
                      children: imagePaths.map(
                        (image) {
                          return ImageThumbnail(selectedImage: image);
                        },
                      ).toList(),
                    ),
                    const Text(
                      'Signature',
                      style: TextStyle(fontSize: 40),
                    ),
                    Image.file(
                      File(signaturePath),
                      fit: BoxFit.cover, // Adjust to fit the full image
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Change'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<DeliveryDetailBloc>(context).add(
                              SaveSignatureAndImages(
                                imagePaths: imagePaths,
                                signaturePath: signaturePath,
                                deliveryId: widget.deliveryHeader.id,
                              ),
                            );
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  void errorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            children: [
              const Text(
                "Errors:",
                style: TextStyle(fontSize: 30),
              ),
              Column(
                children: errorMessages.map(
                  (error) {
                    return Text(error);
                  },
                ).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
