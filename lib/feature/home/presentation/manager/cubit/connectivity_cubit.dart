import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/home/presentation/manager/cubit/connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial()) {
    checkConnectivity();
    _setupPeriodicConnectivityCheck();
  }

  bool _hasShownSnackbar = false;
  Timer? _connectivityTimer;

  bool get hasShownSnackbar => _hasShownSnackbar;

  void setSnackbarShown(bool shown) {
    _hasShownSnackbar = shown;
  }

  Future<void> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      if (isConnected) {
        emit(ConnectivityAvailable());
      } else {
        emit(ConnectivityUnavailable());
      }
    } on SocketException catch (_) {
      emit(ConnectivityUnavailable());
    }
  }

  void _setupPeriodicConnectivityCheck() {
    _connectivityTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => checkConnectivity(),
    );
  }

  @override
  Future<void> close() {
    _connectivityTimer?.cancel();
    return super.close();
  }
}
