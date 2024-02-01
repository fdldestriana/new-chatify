import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/userlist/entities/userlist_item_entity.dart';
import 'package:new_chatify/domain/userlist/usecases/userlist_usecase.dart';

part 'userlist_event.dart';
part 'userlist_state.dart';

class UserlistBloc extends Bloc<UserlistEvent, UserlistState> {
  final UserListUseCase userListUseCase;
  UserlistBloc({required this.userListUseCase}) : super(UserlistInitial()) {
    on<UsersListItemLoadRequested>(
      (event, emit) async {
        emit(UserlistItemLoadingState());
        Either<Failure, UserListItemEntity> userlistItems =
            await userListUseCase.call(NoParams());
        userlistItems.fold(
          (l) => emit(
            UserlistItemLoadFailedState(errorMessage: l.errorMessage),
          ),
          (r) => emit(
            UserlistItemLoadSucceedState(userlistItemEntity: r),
          ),
        );
      },
    );
  }
}
