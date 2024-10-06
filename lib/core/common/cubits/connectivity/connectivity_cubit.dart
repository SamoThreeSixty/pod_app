import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

class ConnectivityCubit extends Cubit<ConnectivityResult> {
  static final ConnectivityCubit _instance = ConnectivityCubit._internal();
  factory ConnectivityCubit(Connectivity connectivity) => _instance;

  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityCubit._internal()
      : _connectivity = Connectivity(),
        super(ConnectivityResult.none) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    List<ConnectivityResult> result = [];

    try {
      await _connectivity.checkConnectivity();
    } catch (e) {}

    _updateConnectivityStatus(result);
  }

  Future<void> _updateConnectivityStatus(
      List<ConnectivityResult> result) async {
    emit(result.first);
  }
}
