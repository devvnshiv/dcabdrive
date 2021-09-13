import 'package:ekabbdriver/models/authmodels.dart';
import 'package:ekabbdriver/models/provider.dart';
import 'package:ekabbdriver/refactor2/0/ui/login/loginpage.dart';
import 'package:ekabbdriver/refactor2/0/utils/resposive.dart';
import 'package:ekabbdriver/sreen/LoginScreen.dart';
import 'package:ekabbdriver/sreen/finalrequest.dart';
import 'package:ekabbdriver/sreen/mainpage.dart';
import 'package:ekabbdriver/sreen/pickupscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, oriantion) {
        AppSizeConfig().init(constraints, oriantion);
        return
          MaterialApp(
            title: 'Ekabb',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.green,
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LoginPage(),
          );
      }
      );
    }
    );
  }
}