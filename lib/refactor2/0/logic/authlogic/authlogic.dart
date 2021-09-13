/*
 * Copyright (c) 2021.  N v shivaprasad  30/07/1997
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekabbdriver/models/authmodels.dart';
import 'package:ekabbdriver/refactor2/0/ui/landingpage/landingpage.dart';
import 'package:ekabbdriver/refactor2/0/utils/preload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLogic {



   authwork(BuildContext context, String phone)async{
         Preload(context);
         bool check = await driveruser().checkuserpresent(phone);
         print(check);
         if(check){
            print(check);
         } else {
            print(check);
            await driveruser().getdetailes(phone);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_)=> LandingPage(phone: phone,) ));
         }

      }

   }

