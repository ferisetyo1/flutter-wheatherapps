import 'dart:developer';

import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/model/weather.dart';
import 'package:boilerplate/domain/repo/i_home_repository.dart';
import 'package:code_id_network/code_id_network.dart';
import 'package:code_id_storage/code_id_storage.dart';
import 'package:code_id_storage/code_interfaces/storage/i_storage.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:injectable/injectable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';

@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final INetworkService _networkService;
  const HomeRepository(this._networkService);

  @override
  Future<Either<Unit, Weather>> getDataWeather() async {
    try {
      var geo = await Geolocator.getCurrentPosition(
          timeLimit: Duration(seconds: 10),
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true);
      print("geo: ${geo.latitude} ${geo.longitude}");
      var resp =
          await _networkService.getHttp(path: "weather", queryParameter: {
        "lat": geo.latitude,
        "lon": geo.longitude,
        "appid": "0012a18b367daf42bcb21b702e0fcc3c",
        "lang": "id"
      });

      return resp.fold(
          (l) => l.when(noInternet: () {
                print("no internet");
                return left(unit);
              }, serverError: (e) {
                print("no internet");
                return left(unit);
              }, timeout: () {
                print("no internet");
                return left(unit);
              }, other: (e) {
                debugPrint(e.toString());
                return left(unit);
              }), (r) {
        Map<String, dynamic> json = r as Map<String, dynamic>;
        print(r);
        return right(Weather.fromJson(json));
      });
    } catch (e) {
      print("error bro");
      print(e);
      return left(unit);
    }
  }

  @override
  Future<Either<Unit, User>> getDataUser() async {
    try {
      IStorage userStorage = Storage;
      IStorage authStorage = Storage;
      await authStorage.openBox('Auth');
      await userStorage.openBox('User');
      String email = await authStorage.getData(key: "userSigned") as String;
      final userJson = await userStorage.getData(key: email);
      return right(User.fromJson(Map<String, dynamic>.from(userJson)));
    } catch (e) {
      print(e);
      return left(unit);
    }
  }
}
