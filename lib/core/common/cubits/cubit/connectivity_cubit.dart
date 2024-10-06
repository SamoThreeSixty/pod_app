import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityResult> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityCubit(this._connectivity) : super(ConnectivityResult.none) {
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
