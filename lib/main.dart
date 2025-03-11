import 'package:aban_tether_challenge/core/storage/secure_storage.dart';
import 'package:aban_tether_challenge/core/utils/app_router.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aban_tether_challenge/features/coin/presentation/bloc/coin_bloc.dart';
import 'package:aban_tether_challenge/injection_container.dart' as sl;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  final secureStorage = SecureStorage();
  final token = await secureStorage.getToken();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (_) => sl.serviceLocator<AuthBloc>(),
      ),
      BlocProvider<CoinBloc>(
        create: (_) => sl.serviceLocator<CoinBloc>(),
      ),
    ],
    child: MaterialApp.router(
      routerConfig: AppRouter.getRouter(token != null),
    ),
  ));
}
