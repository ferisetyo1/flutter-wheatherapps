import 'package:boilerplate/domain/model/weather.dart';
import 'package:fpdart/fpdart.dart';

abstract class ICariKotaRepository {
  Future<Either<Unit, Weather>> getDataWeather({required String query});
}
