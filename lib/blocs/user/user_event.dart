part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserUpdate extends UserEvent {
  final String label;
  final String value;
  final String userId;

  const UserUpdate(this.label, this.value, this.userId);

  @override
  List<Object> get props => [label, value, userId];
}
