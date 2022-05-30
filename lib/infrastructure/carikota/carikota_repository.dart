import 'package:boilerplate/domain/model/weather.dart';
import 'package:boilerplate/domain/repo/i_carikota_repository.dart';
import 'package:code_id_network/code_id_network.dart';
import 'package:fpdart/src/unit.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICariKotaRepository)
class CariKotaRepository implements ICariKotaRepository{
  final INetworkService _networkService;
  const CariKotaRepository(this._networkService);
  @override
  Future<Either<Unit, Weather>> getDataWeather({required String query}) async{
    try {
      var resp =
          await _networkService.getHttp(path: "weather", queryParameter: {
        "q": query,
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
                print(e.toString());
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
  
}