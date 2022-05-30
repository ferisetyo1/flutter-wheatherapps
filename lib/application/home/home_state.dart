part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {

  const factory HomeState({
    required Weather? weather,
    required User? user
  })=_HomeState;

  factory HomeState.initial() => HomeState(weather: null, user: null);
}
