import 'package:bloc/bloc.dart';
import 'package:new_chatify/data/model/user.dart';
import 'package:new_chatify/service/chat_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ChatService chatService = ChatService();

  UserBloc() : super(UserLoadingState()) {
    on<UsersLoadRequested>((event, emit) async {
      try {
        var users = await chatService.getUser();
        emit(UserLoadSuccedState(users: users));
      } catch (e) {
        emit(UserLoadFailedState(errorMessage: e.toString()));
      }
    });
  }
}
