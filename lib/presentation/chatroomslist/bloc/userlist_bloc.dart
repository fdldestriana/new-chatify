import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/chatroomslist/usecases/userlist_usecase.dart';

part 'userlist_event.dart';
part 'userlist_state.dart';

class UserlistBloc extends Bloc<UserlistEvent, UserListState> {
  final UserListUseCase userListUseCase;
  UserlistBloc({required this.userListUseCase}) : super(UserListInitial()) {
    on<UsersListItemLoadRequested>(
      (event, emit) async {
        emit(UserListLoadingState());
        Either<Failure, List<UserAppEntity>> userList =
            await userListUseCase.call(NoParams());
        userList.fold(
          (l) => emit(
            UserListLoadFailedState(errorMessage: l.errorMessage),
          ),
          (r) => emit(
            UserListLoadSucceedState(userList: r),
          ),
        );
      },
    );
  }
}
