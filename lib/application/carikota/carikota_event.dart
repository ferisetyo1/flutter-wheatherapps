part of 'carikota_bloc.dart';

@freezed
class CarikotaEvent with _$CarikotaEvent {
  const factory CarikotaEvent.started() = _Started;
  const factory CarikotaEvent.onSearch() = _OnSearch;
  const factory CarikotaEvent.onQueryChange({required String value}) = _OnQueryChanged;
}