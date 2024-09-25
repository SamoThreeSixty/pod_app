import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/features/delivery_list/presentation/bloc/delivery_list_bloc.dart';

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
    return BlocBuilder<DeliveryListBloc, DeliveryListState>(
      builder: (context, state) {
        debugger();
        if (state is DeliveryListSuccess) {
          return const Text("success");
        } else if (state is DeliveryListFailure) {
          return const Text("big fails");
        }
        return Container();
      },
    );
  }
}
