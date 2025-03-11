import 'package:aban_tether_challenge/core/storage/secure_storage.dart';
import 'package:aban_tether_challenge/core/utils/app_router.dart';
import 'package:aban_tether_challenge/injection_container.dart' as sl;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  final secureStorage = SecureStorage();
  // secureStorage.deleteToken();
  final token = await secureStorage.getToken();
  runApp(MaterialApp.router(
    routerConfig: AppRouter.getRouter(token != null),
  ));
}
