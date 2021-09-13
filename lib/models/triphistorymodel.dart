import 'package:cloud_firestore/cloud_firestore.dart';

class  driverhistory {

  final String phone;
  final  String slat;
  final String slong;
  final String dlat;
  final String dong;
  final  String  paymentmode;
  final String name;
  final String ratings;
  final String   userno;
  final String Cost;
  final String discount;
  final String Status;
  driverhistory({this.Status, this.Cost, this.discount, this.phone, this.slat, this.slong, this.dlat, this.dong, this.paymentmode, this.name, this.ratings, this.userno});







  driverhistory gethistory(QuerySnapshot snapshot){

  }

driverhistory getontrip(DocumentSnapshot snapshot){
    return driverhistory(
      phone:  snapshot.data['phone'],
      slat: snapshot.data['lat'],
      slong: snapshot.data['long']
    );
}

Stream<driverhistory> gettripdetails(){
    return  Firestore.instance.collection('tripdetailes').document(userno).snapshots().map(getontrip);
}
  driverhistory gettripdetail(DocumentSnapshot snapshot) {
    return driverhistory(
      Cost: snapshot.data['cost'],
      discount: snapshot.data['finalprice'],
      paymentmode: snapshot.data['mode'],
      userno: snapshot.data['phone'],
      slat: snapshot.data['lat'],
      slong: snapshot.data['long'],
      dlat: snapshot.data['dlat'],
      dong: snapshot.data['dlong'],
    );
  }

  Stream<driverhistory> tripdetailes(){
    return  Firestore.instance.collection('tripdetailes').document(userno).snapshots().map(gettripdetail);
  }

  updatestat(String stat){
    Firestore.instance.collection('satus').document(phone).setData(
      {
        'satus':stat
      }
    );
  }

 driverhistory  getstat(DocumentSnapshot snapshot){
    return driverhistory(
      Status: snapshot.data['satus']
    );
 }
  Stream<driverhistory> getstatstrea(){
    return Firestore.instance.collection('satus').document(phone).snapshots().map(getstat);
  }

  driverhistory driveronride(String phone,String custom) {
      Firestore.instance.collection('driveronride').document(phone).setData({
'userphone':custom,
      });
  }
}



