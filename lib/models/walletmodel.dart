/*
 * Copyright (c) 2020.  N v shivaprasad  30/07/1997
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class driverwalletmodel{

 final  String blances;
 final  String requestedblance;
 final String creditedonbank;
final String driverphone;
  driverwalletmodel({this.driverphone, this.blances, this.requestedblance, this.creditedonbank});

 Firestore driverwallet = Firestore.instance;

 updateblance(String blance,String phone)async{
  await driverwallet.collection('driverwallets').document(phone).setData(
     {
       'blances':blance

     }
   );
 }
requestedblancedata(String blance,String phone)async{

   
  await driverwallet.collection('driverwalletrequest').document(phone).setData(
      {
        'blances':blance

      }
  );

}

totalblancecredited(String blance,String phone)async{
  await driverwallet.collection('blancecredited').document(phone).setData(
      {
        'blances':blance

      }
  );

}

driverwalletmodel walletin(DocumentSnapshot snapshot){
   return driverwalletmodel(
     blances:  snapshot.data['blances']
   );

}
Stream<driverwalletmodel> getwalletin(){
   return driverwallet.collection('driverwallets').document(driverphone).snapshots().map(walletin);
}

}