import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_app/core/common/cubits/connectivity/connectivity_cubit.dart';

class ConnectivityState extends StatefulWidget {
  const ConnectivityState({super.key});

  @override
  State<ConnectivityState> createState() => _ConnectivityStateState();
}

class _ConnectivityStateState extends State<ConnectivityState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityResult>(
        builder: (context, connectivityStatus) {
      Color color;
      IconData icon;
      String message;

      switch (connectivityStatus) {
        case ConnectivityResult.none:
          color = Colors.red;
          icon = Icons.wifi_off;
          message = 'You are not connected to the internet.';
          break;
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          color = Colors.green;
          icon = Icons.wifi;
          message = 'You are connected to the internet.';
          break;
        default:
          color = Colors.amber;
          icon = Icons.abc_sharp;
          message = 'Unsure of this connection.';
          break;
      }

      return GestureDetector(
        onTap: () => _showDetailsDialog(context, message),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: Offset(0, 5), // Shadow position
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  void _showDetailsDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
        );
      },
    );
  }
}
