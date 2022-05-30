import 'package:bloc/bloc.dart';
import 'package:boilerplate/application/profile/profile_bloc.dart';
import 'package:boilerplate/domain/model/weather.dart';
import 'package:boilerplate/domain/repo/i_carikota_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'carikota_event.dart';
part 'carikota_state.dart';
part 'carikota_bloc.freezed.dart';

@injectable
class CarikotaBloc extends Bloc<CarikotaEvent, CarikotaState> {
  ICariKotaRepository _repo;

  CarikotaBloc(this._repo) : super(CarikotaState.initial()) {
    on<CarikotaEvent>((event, emit) async {
      await event.when(
          started: () {},
          onSearch: () async {
            final weather = await _repo.getDataWeather(query: state.query);
            emit(weather.fold((l) => state.copyWith(weather: null,errorMsg:"Kota tidak ditemukan"),
                (r) => state.copyWith(weather: r,errorMsg: null)));
          },
          onQueryChange: (value) {
            emit(state.copyWith(query: value,errorMsg: null));
          });
    });
  }
}
