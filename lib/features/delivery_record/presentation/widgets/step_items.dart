import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/features/delivery_record/domain/entity/delivery_detail.dart';
import 'package:pod_app/features/delivery_record/presentation/bloc/delivery_detail_bloc.dart';

class StepItems extends StatefulWidget {
  final int deliveryHeaderId;

  const StepItems({super.key, required this.deliveryHeaderId});

  @override
  State<StepItems> createState() => _StepItemsState();
}

class _StepItemsState extends State<StepItems> {
  int selectedButton = -1;
  final bool _showTooltip = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        selectedButton == 0 ? lineItems(false) : Container(),
        selectedButton == 1 ? lineItems(true) : Container(),
      ],
    );
  }

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
          //TODO: make enum
          if (selectedButton == 0 || selectedButton == 1) {
            context.read<DeliveryDetailBloc>().add(
                  DeliveryGetDetails(widget.deliveryHeaderId),
                );
          }
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
  BlocBuilder<DeliveryDetailBloc, DeliveryDetailState> lineItems(bool edit) {
    return BlocBuilder<DeliveryDetailBloc, DeliveryDetailState>(
      builder: (context, state) {
        if (state is DeliveryDetailSuccess) {
          List<DeliveryDetail> products = state.deliveryDetail;

          return products.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text('Confirm your delivery'),
                      ...products.map(
                        (product) => ListTile(
                          title: Text(product.stock_ref),
                          leading: Checkbox(
                            value: product.loaded,
                            onChanged: (bool? newValue) {
                              setState(
                                () {
                                  product.loaded = newValue ?? false;
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
              : const Text("No data found");
        } else {
          return const Text("There was an error");
        }
      },
    );
  }
}
