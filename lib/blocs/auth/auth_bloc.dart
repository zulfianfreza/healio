import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healio/services/user_service.dart';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthSignUp) {
        try {
          emit(AuthLoading());

          UserModel user = await AuthService().signUp(
            email: event.email,
            password: event.password,
            name: event.name,
            gender: event.gender,
            dateOfBirth: event.dateOfBirth,
          );

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if (event is AuthSignIn) {
        try {
          emit(AuthLoading());

          UserModel user = await AuthService().signIn(
            email: event.email,
            password: event.password,
          );

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthSignOut) {
        try {
          emit(AuthLoading());

          await AuthService().signOut();

          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          UserModel user = await UserService().getUserById(event.id);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
