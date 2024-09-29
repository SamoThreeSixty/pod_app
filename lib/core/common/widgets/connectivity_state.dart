import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityState extends StatefulWidget {
  const ConnectivityState({super.key});

  @override
  State<ConnectivityState> createState() => _ConnectivityStateState();
}

class _ConnectivityStateState extends State<ConnectivityState> {
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
    super.initState();
  }

  Future<void> _initConnectivity() async {
    List<ConnectivityResult> result = [];

    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result.add(ConnectivityResult.none);
    }

    _updateConnectivityStatus(result);
  }

  void _updateConnectivityStatus(List<ConnectivityResult> result) {
    setState(() {
      _connectivityStatus = result.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) {
          switch (_connectivityStatus) {
            case ConnectivityResult.none:
              return circleIcon(
                  Colors.red, Icons.wifi_off, _connectivityStatus);
            case ConnectivityResult.mobile || ConnectivityResult.wifi:
              return circleIcon(Colors.green, Icons.wifi, _connectivityStatus);
            default:
              return circleIcon(
                  Colors.amber, Icons.abc_sharp, _connectivityStatus);
          }
        },
      ),
    );
  }

  GestureDetector circleIcon(
      Color color, IconData icon, ConnectivityResult status) {
    return GestureDetector(
      onTap: () {
        switch (status) {
          case ConnectivityResult.none:
            _showDetailsDialog(
                context, 'You are not connected to the internet.');

          case ConnectivityResult.mobile || ConnectivityResult.wifi:
            _showDetailsDialog(context, 'You are connected to the internet.');

          default:
            _showDetailsDialog(context, 'Unsure of this connection.');
        }
      },
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
        ), // Use an icon to make it more button-like
      ),
    );
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
