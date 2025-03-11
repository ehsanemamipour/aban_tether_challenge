import 'package:aban_tether_challenge/features/auth/domain/usecases/fetch_token.dart';
import 'package:aban_tether_challenge/features/coin/presentation/bloc/coin_event.dart';
import 'package:aban_tether_challenge/features/coin/presentation/bloc/coin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  CoinBloc({required this.fetchToken}) : super(CoinInitial()) {
    on<CoinEvent>(
      (event, emit) async {
        // if (event is LoginEvent) {
        //   await _onLoginEvent(event, emit);
        // }
      },
    );
  }
  final FetchToken fetchToken;

  // Future<void> _onLoginEvent(
  //   LoginEvent event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthLoading());
  //   final result = await fetchToken(FethTokenParams(
  //     email: event.email,
  //     password: event.password,
  //   ));

  //   emit(
  //     result.fold(
  //       (error) => AuthError(message: error.message),
  //       (token) => GetTokenState(token: token),
  //     ),
  //   );
  // }
}
