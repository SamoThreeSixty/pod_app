import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class StepControls extends StatelessWidget {
  final void Function(int result) changeStep;
  final VoidCallback? cancelSteps;
  final VoidCallback? completeSteps;

  final int currentStep;
  final String action; // this can only be next / prev

  const StepControls({
    super.key,
    required this.changeStep,
    required this.currentStep,
    required this.action,
    this.cancelSteps,
    this.completeSteps,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 55),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        switch (action) {
          case 'Next':
            _onNextAction();
            break;
          case 'Back':
            _onPrevAction();
            break;
        }
      },
      child: Text(currentStep == 0 && action == 'Back' ? 'Cancel' : action),
    );
  }

  void _onNextAction() {
    switch (currentStep) {
      case 0:
        changeStep(currentStep + 1);
        break;
      case 1:
        changeStep(currentStep + 1);
        break;
      case 2:
        completeSteps!();
        break;
    }
  }

  void _onPrevAction() {
    switch (currentStep) {
      case 0:
        cancelSteps!();
        break;
      case 1:
        changeStep(currentStep + -1);
        break;
      case 2:
        changeStep(currentStep - 1);
        break;
    }
  }
}
