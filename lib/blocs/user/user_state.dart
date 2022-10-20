part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFailed extends UserState {
  final String e;
  const UserFailed(this.e);

  @override
  List<Object> get props => [e];
}

class UserSuccess extends UserState {
  final UserModel user;
  const UserSuccess(this.user);

  @override
  List<Object> get props => [user];
}
