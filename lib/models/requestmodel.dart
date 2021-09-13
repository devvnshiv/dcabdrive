import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekabbdriver/sreen/finalrequest.dart';
import 'package:flutter/material.dart';

class requestmodel {
  final String Customerphonenuber;
  final String driverphone;
  final String initiallocationlat;
  final String mode;
  final String finallong;
  final String initiallocationlong;
  final String finallocationlat;
  final String finallocationlong;
  final String cost;
  final String discount;
  final String name;

  requestmodel(
      {this.mode, this.finallong, this.name, this.discount, this.driverphone,
        this.Customerphonenuber, this.initiallocationlat, this.initiallocationlong, this.finallocationlat, this.finallocationlong, this.cost });

  Firestore request = Firestore.instance;

  List<requestmodel> getrequest(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return requestmodel(
          Customerphonenuber: doc.data['phone'],
          driverphone: doc.data['name'],
          initiallocationlat: doc.data['initiallocationlat'],
          initiallocationlong: doc.data['initiallocationlong'],
          finallocationlat: doc.data['finallocationlat'],
          finallocationlong: doc.data['km'],
          cost: doc.data['cost']
      );
    }

    ).toList();
  }

  Stream<List<requestmodel>> streamgetrequest() {
    return request.collection(driverphone).snapshots().map(getrequest);
  }

  deletequery(String driverphone, String userphone) async {
    await Firestore.instance.collection(driverphone)
        .document(userphone)
        .delete();
  }

  deletequerys(String driverphone) async {
    await Firestore.instance.collection('request')
        .document(driverphone)
        .delete();
  }

  accept(String driverphone, String userphone, String discount, String cost,
      String carname) async {
    return request.collection(userphone).document(driverphone).setData(
        {
          'driverphone': driverphone,
          'cost': cost,
          'discount': discount,
          'carname': carname
        }


    );
  }

  requestmodel finalrequest(DocumentSnapshot snapshot) {
    return requestmodel(

      Customerphonenuber: snapshot.data['phone'],
      cost: snapshot.data['cost'],
      discount: snapshot.data['discount'],
      name: snapshot.data['name'],
    );
  }

  Stream<requestmodel> finalcust() {
    return request.collection('request').document(driverphone).snapshots().map(
        finalrequest);
  }

  useronride(String userphone, String driverphone) async {
    await request.collection('useronride').document(userphone).setData({

      'driverphone': driverphone,

    });
  }

  requestmodel getuserdetails(DocumentSnapshot snapshot) {
    return requestmodel(
        name: snapshot.data['name']
    );
  }

  Stream<requestmodel> getdeal() {
    return request.collection('Users').document(driverphone).snapshots().map(
        getuserdetails);
  }

  driveronride(String driverphone, String userphone) async {
    await request.collection('driveronride').document(driverphone).setData({

      'userphone': userphone,

    });
  }

  requestmodel getdriveronride(DocumentSnapshot snapshot) {
    return requestmodel(
        Customerphonenuber: snapshot.data['userphone']
    );
  }

  Stream<requestmodel> getdriverride() {
    return request.collection('driveronride').document(driverphone)
        .snapshots()
        .map(
        getdriveronride);
  }


  requestmodel gettripdetails(DocumentSnapshot snapshot) {
    return requestmodel(
      cost: snapshot.data['cost'],
      discount: snapshot.data['finalprice'],
      mode: snapshot.data['mode'],
      Customerphonenuber: snapshot.data['phone'],
      initiallocationlat: snapshot.data['lat'],
      initiallocationlong: snapshot.data['long'],
      finallocationlat: snapshot.data['dlat'],
      finallocationlong: snapshot.data['dlong'],
    );
  }
  
  Stream<requestmodel> tripdetailes(){
    return request.collection('tripdetailes').document(Customerphonenuber).snapshots().map(gettripdetails);
  }
}