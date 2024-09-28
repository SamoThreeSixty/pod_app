import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/features/delivery_list/domain/entity/delivery_header.dart';
import 'package:pod_app/features/delivery_list/presentation/bloc/delivery_list_bloc.dart';
import 'package:pod_app/features/delivery_list/presentation/widgets/delivery_record.dart';

class DeliveryList extends StatefulWidget {
  const DeliveryList({super.key});

  @override
  State<DeliveryList> createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
  @override
  void initState() {
    context.read<DeliveryListBloc>().add(
          GetAllDeliveryList(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery List'),
      ),
      body: BlocBuilder<DeliveryListBloc, DeliveryListState>(
        builder: (context, state) {
          if (state is DeliveryListSuccess) {
            debugger();
            // Going to get a array containing a list of 2 deliveries
            final deliveryPairs = <List<DeliveryHeader>>[];

            for (var i = 0; i < state.deliveryHeader.length; i += 2) {
              // Stepping in two so we can display side by side
              deliveryPairs.add(state.deliveryHeader.sublist(
                  i,
                  i + 2 > state.deliveryHeader.length
                      ? state.deliveryHeader.length
                      : i + 2));
            }

            return ListView.builder(
              itemCount: deliveryPairs.length,
              itemBuilder: (context, index) {
                final deliveries = deliveryPairs[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: deliveries.map((delivery) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DeliveryRecord(delivery: delivery),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          } else if (state is DeliveryListFailure) {
            return const Text("big fails");
          }
          return Container();
        },
      ),
    );
  }
}
