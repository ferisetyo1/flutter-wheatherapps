import 'package:bloc/bloc.dart';
import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/model/weather.dart';
import 'package:boilerplate/domain/repo/i_home_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository _repo;
  HomeBloc(this._repo) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(started: () async {
        final userResp = await _repo.getDataUser();
        emit(userResp.fold((l) => state, (r) => state.copyWith(user: r)));
        final weatherResp = await _repo.getDataWeather();
        emit(weatherResp.fold((l) => state, (r) => state.copyWith(weather: r)));
      });
    });
  }
}
