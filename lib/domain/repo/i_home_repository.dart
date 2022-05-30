import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/model/weather.dart';
import 'package:fpdart/fpdart.dart';

abstract class IHomeRepository{
  Future<Either<Unit,Weather>> getDataWeather(); 
  Future<Either<Unit,User>> getDataUser(); 
}