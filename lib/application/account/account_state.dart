part of 'account_bloc.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState({ required bool showpass}) = _AccountState;
  factory AccountState.initial()=>AccountState(showpass: false);
}
