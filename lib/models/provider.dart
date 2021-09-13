/*
 * Copyright (c) 2020.  N v shivaprasad  30/07/1997
 */

import 'package:ekabbdriver/models/requestmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class listrequest extends ChangeNotifier {

requestmodel request ;


requestmodel get getrequest => request;

Future refresh() async {
  final prefs = await SharedPreferences.getInstance();
  String phone;
  phone = prefs.getString('phone');

  request= requestmodel(driverphone: phone).finalcust() as requestmodel;
  notifyListeners();
}



}