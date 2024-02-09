import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/chatroomslist/entities/chatrooms_list_entity.dart';
import 'package:new_chatify/domain/chatroomslist/usecases/chatrooms_list_usecase.dart';

part 'chatrooms_list_event.dart';
part 'chatrooms_list_state.dart';

class ChatRoomsListBloc extends Bloc<ChatRoomsListEvent, ChatRoomsListState> {
  final ChatRoomsListUseCase chatRoomsListUseCase;
  ChatRoomsListBloc({required this.chatRoomsListUseCase})
      : super(ChatRoomsListInitial()) {
    on<ChatRoomsListLoadRequested>(
      (event, emit) async {
        emit(ChatRoomsListLoadingState());
        Either<Failure, List<ChatRoomsListEntity>> chatRoomsList =
            await chatRoomsListUseCase.call(NoParams());
        chatRoomsList.fold(
          (l) => emit(
            ChatRoomsListLoadFailedState(errorMessage: l.errorMessage),
          ),
          (r) => emit(
            ChatRoomsListLoadSucceedState(chatRoomsList: r),
          ),
        );
      },
    );
  }
}
