part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String gender;
  final String dateOfBirth;
  const AuthSignUp(
      this.email, this.password, this.name, this.gender, this.dateOfBirth);

  @override
  List<Object> get props => [email, password, name, gender, dateOfBirth];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  const AuthSignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthSignOut extends AuthEvent {}

class AuthGetCurrentUser extends AuthEvent {
  final String id;
  const AuthGetCurrentUser(this.id);

  @override
  List<Object> get props => [id];
}
