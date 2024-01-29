import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain-on-working/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain-on-working/userlist/usecases/userlist_usecase.dart';

part 'userlist_event.dart';
part 'userlist_state.dart';

class UserlistBloc extends Bloc<UserlistEvent, UserlistState> {
  final UserListUseCase userListUseCase;
  UserlistBloc({required this.userListUseCase}) : super(UserlistInitial()) {
    on<UsersListLoadRequested>(
      (event, emit) async {
        emit(UserlistLoadingState());
        Either<Failure, List<UserAppEntity>> result =
            await userListUseCase.call(NoParams());
        result.fold(
            (l) => emit(UserlistLoadFailedState(errorMessage: l.errorMessage)),
            (r) => emit(UserlistLoadSucceedState(users: r)));
      },
    );
  }
}
