import 'package:aban_tether_challenge/features/auth/domain/usecases/fetch_token.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.fetchToken}) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          await _onLoginEvent(event, emit);
        }
      },
    );
  }
  final FetchToken fetchToken;

  Future<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await fetchToken(FethTokenParams(
      email: event.email,
      password: event.password,
    ));

    emit(
      result.fold(
        (error) => AuthError(message: error.message),
        (token) => GetTokenState(token: token),
      ),
    );
  }
}
