import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserUpdate) {
        try {
          emit(UserLoading());

          UserModel user = await UserService().updateUser(
              label: event.label, value: event.value, userId: event.userId);

          emit(UserSuccess(user));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }
    });
  }
}
