// ignore_for_file: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang,",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Feri Setyo Efendi",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {
                  context.pushRoute(const ProfileRoute());
                },
                child: Text(
                  "(Tekan untuk melihat profil)",
                  style: TextStyle(fontSize: 10.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Cari cuaca kotamu",
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "10/12/2021",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        "Informasi cuaca hari ini",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Sedikit Berawan",
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
                                    "http://openweathermap.org/img/w/04d.png",
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
                          SizedBox(width: 8,),
                          Text(
                            "1.55m/s S",
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
                          SizedBox(width: 8,),
                          Text(
                            "29.04°C",
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
                          SizedBox(width: 8,),
                          Text(
                            "70hPA",
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
                          SizedBox(width: 8,),
                          Text(
                            "99 Awan terlihat",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
