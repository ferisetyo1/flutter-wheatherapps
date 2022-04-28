// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:boilerplate/presentation/routers/app_routes.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("Nama Depan"),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("Nama Belakang"),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("Email"), border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text("Alamat"), border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      // obscureText: state.showpass,
                      decoration: InputDecoration(
                          label: Text("Password"),
                          border: OutlineInputBorder(),
                          suffix: InkWell(
                            // onTap: () => bloc.add(ProfileEvent.showpass()),
                            // child: Icon(state.showpass
                            //     ? Icons.visibility
                            //     : Icons.visibility_off),
                            onTap: () {},
                            child: Icon(Icons.visibility),
                          )),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Simpan"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40)),
                    ),
                    OutlinedButton(
                        onPressed: () {
                          // context.popRoute();
                          // context.popRoute();
                          context.pushRoute(LoginRoute());
                        },
                        child: Text("Keluar"),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor),
                            minimumSize: Size.fromHeight(40))),
                  ],
                ),
              ),
            ),
          );
  }
}