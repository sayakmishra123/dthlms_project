// import 'package:get/get.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityService extends GetxService {
//   final Connectivity _connectivity = Connectivity();
//   final RxBool isConnected = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//     _checkInitialConnection();
//   }

//   void _updateConnectionStatus(ConnectivityResult result) {
//     isConnected.value = result != ConnectivityResult.none;
//   }

//   Future<void> _checkInitialConnection() async {
//     final result = await _connectivity.checkConnectivity();
//     _updateConnectionStatus(result);
//   }
// }
