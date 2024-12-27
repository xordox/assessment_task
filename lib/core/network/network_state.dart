import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity _connection = Connectivity();
  bool networkState = false;
  bool get isConnected => networkState;

  void listenNetwork() async {
    _connection.onConnectivityChanged.listen(
      (result) {
        log(result.toString());
        if (result.contains(ConnectivityResult.none)) {
          networkState = false;
        } else {
          networkState = true;
        }
      },
    );
  }
}