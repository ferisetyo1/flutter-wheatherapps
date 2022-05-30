// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:boilerplate/application/carikota/carikota_bloc.dart';
import 'package:boilerplate/application/profile/profile_bloc.dart';
import 'package:boilerplate/injection.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';
import 'package:boilerplate/presentation/utils/datetime_extension.dart';
import 'package:boilerplate/presentation/utils/double_extension.dart';
import 'package:boilerplate/presentation/utils/string_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CariKotaPage extends StatelessWidget {
  const CariKotaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CarikotaBloc>()..add(CarikotaEvent.started()),
      child: BlocBuilder<CarikotaBloc, CarikotaState>(
        builder: (context, state) {
          final CarikotaBloc bloc = context.read<CarikotaBloc>();
          return Scaffold(
            appBar: AppBar(
              title: Text("Cari Cuaca Kota"),
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text("Cari cuaca kota"),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) =>
                        bloc.add(CarikotaEvent.onQueryChange(value: value)),
                  ),
                  ElevatedButton(
                      onPressed: () => bloc.add(CarikotaEvent.onSearch()),
                      child: Text("Cari")),
                  state.weather != null && state.query != ""
                      ? Card(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateTime.now().toFormatedDate("dd/MM/yyyy"),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                                Text(
                                  "Informasi cuaca Kota ${state.weather?.name ?? ""} hari ini",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          (state.weather?.weather?.first
                                                      .description ??
                                                  "")
                                              .toTitleCase(),
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                        flex: 3,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://openweathermap.org/img/w/${state.weather?.weather?.first.icon ?? "04d"}.png",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.fill,
                                        ),
                                        flex: 1,
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.navigation_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${(state.weather?.wind?.speed ?? 0).prettify()}m/s S",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.thermostat_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${((state.weather?.main?.temp ?? 273.15) - 273.15).prettify()}°C",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.opacity_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${state.weather?.main?.humidity ?? 0}hPA",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.cloud_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${state.weather?.clouds?.all ?? 0} Awan terlihat",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : state.query != ""
                          ? Text(state.errorMsg ?? "")
                          : Text("")
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
