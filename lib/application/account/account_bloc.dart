import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'account_event.dart';
part 'account_state.dart';
part 'account_bloc.freezed.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountState.initial()) {
    on<AccountEvent>((event, emit) {
      event.when(
        started:() {},
        showpass:(){ emit(state.copyWith(showpass: !state.showpass));}
        );
    });
  }
}
