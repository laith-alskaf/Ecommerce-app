import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:simple_e_commerce/core/enums/connectivity_status.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectivityStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    final Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((events) {
      if(events.isEmpty) {
        connectivityStatusController.add(ConnectivityStatus.OFFLINE);
        return;
      }
      for (var result in events) {
        connectivityStatusController.add(getStatus(result));
      }
    });
  }

  ConnectivityStatus getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.ethernet:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.none:
        return ConnectivityStatus.OFFLINE;
      case ConnectivityResult.vpn:
        return ConnectivityStatus.ONLINE;
      default:
        return ConnectivityStatus.OFFLINE;
    }
  }
}
