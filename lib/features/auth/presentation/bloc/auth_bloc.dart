import 'package:aban_tether_challenge/core/utils/usecase_utils.dart';
import 'package:aban_tether_challenge/features/auth/domain/usecases/add_user_phone.dart';
import 'package:aban_tether_challenge/features/auth/domain/usecases/fetch_token.dart';
import 'package:aban_tether_challenge/features/auth/domain/usecases/fetch_user_info.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_event.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.fetchToken,
    required this.addUserPhone,
    required this.fetchUserInfo,
  }) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          await _onLoginEvent(event, emit);
        } else if (event is GetUserInfoEvent) {
          await _onGetUserInfoEvent(event, emit);
        } else if (event is AddUserPhoneEvent) {
          await _onAddUserPhoneEvent(event, emit);
        }
      },
    );
  }
  final FetchToken fetchToken;
  final FetchUserInfo fetchUserInfo;
  final AddUserPhone addUserPhone;

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

  Future<void> _onGetUserInfoEvent(
    GetUserInfoEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await fetchUserInfo(NoParams());

    emit(
      result.fold(
        (error) => AuthError(message: error.message),
        (user) => GetUserState(user: user),
      ),
    );
  }

  Future<void> _onAddUserPhoneEvent(
    AddUserPhoneEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await addUserPhone(AddUserPhoneParams(phone: event.phone));

    emit(
      result.fold(
        (error) => AuthError(message: error.message),
        (user) => GetUserState(user: user),
      ),
    );
  }
}
