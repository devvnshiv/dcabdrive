/*
 * Copyright (c) 2021.  N v shivaprasad  30/07/1997
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class driveruser {

  final String name;
  final String phone;
  final String vehicalname;
  final String vechicalnuber;
  final String commission;

  driveruser(
      {this.commission, this.name, this.phone, this.vehicalname, this.vechicalnuber});

  CollectionReference driverdata = Firestore.instance.collection('driveruser');

  Future<bool> checkuserpresent(String phones) async {
    print(phones);
    final sanpshot = await driverdata.document(phones).get();

    if (sanpshot.exists) {
      return false;
    }
    return true;
  }

  driveruser getdriver(DocumentSnapshot snapshot) {
    return driveruser(
      vechicalnuber: snapshot.data['carno'],
      vehicalname: snapshot.data['carname'],
      commission: snapshot.data['comisson'],
      name: snapshot.data['name'],
      phone: snapshot.data['phone'],
    );
  }

  Stream<driveruser> sp() {
    return driverdata.document(phone).snapshots().map(getdriver);
  }

  Future<void> getdetailes(String phones) async {
    var doc = await driverdata.document(phones).get();
    var check = doc.data;

    if (check == null)
      return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', doc.data['name']);
    await prefs.setString('phone', doc.data['phone']);
    await prefs.setString('carno', doc.data['carno']);
    await prefs.setString('carname', doc.data['carname']);
    await prefs.setString('comisson', doc.data['comisson']);
    print(doc.data['carno']);
  }
}



