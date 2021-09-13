/*
 * Copyright (c) 2021.  N v shivaprasad  30/07/1997
 */


import 'package:ekabbdriver/refactor2/0/utils/resposive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Preload(BuildContext context){
  return  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body:Padding(
            padding: EdgeInsets.symmetric(
                vertical: 25*AppSizeConfig.heightMultiplier,
                horizontal: 28*AppSizeConfig.widthMultiplier

            ),
            child: Container(
              height: 65*AppSizeConfig.heightMultiplier,
              width: 75*AppSizeConfig.widthMultiplier,
              child: Image.asset("assets/car.gif",fit:BoxFit.fitWidth,),
            ),
          ),
        );
      }
  );
}

