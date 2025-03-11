import 'package:aban_tether_challenge/core/utils/app_router.dart';
import 'package:aban_tether_challenge/injection_container.dart' as sl;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  runApp(MaterialApp.router(
    routerConfig: AppRouter.getRouter(),
  ));
}
