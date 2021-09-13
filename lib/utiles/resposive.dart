import 'package:flutter/cupertino.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenheghit;
  static double screenwedith;


  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenheghit  = _mediaQueryData.size.height;
    screenwedith = _mediaQueryData.size.width;


  }

}