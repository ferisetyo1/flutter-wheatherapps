part of 'carikota_bloc.dart';

@freezed
class CarikotaState with _$CarikotaState {
  const factory CarikotaState({ required String query,required String? errorMsg, required Weather? weather})=_CarikotaState;
  factory CarikotaState.initial() => CarikotaState(query: "",weather: null,errorMsg: null);
}
