import 'package:bloc/bloc.dart';
import 'package:new_chatify/data/model/user_app.dart';
import 'package:new_chatify/service/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService chatService = UserService();

  UserBloc() : super(UserLoadingState()) {
    on<UsersLoadRequested>((event, emit) async {
      try {
        var users = await chatService.getUsers();
        emit(UserLoadSuccedState(users: users));
      } catch (e) {
        emit(UserLoadFailedState(errorMessage: e.toString()));
      }
    });
  }
}
