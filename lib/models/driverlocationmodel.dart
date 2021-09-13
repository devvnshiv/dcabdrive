import 'package:cloud_firestore/cloud_firestore.dart';

class driverlocation {

  final String phone;
  final double lat;
  final double long;

  driverlocation({this.phone, this.lat, this.long});

  CollectionReference driverlocationupdate = Firestore.instance.collection('driverlocationupdate');


     updatelocation(String phone,double lat,double long,bool status)async{
       print(status);
       if (status == false){
      await driverlocationupdate.document(phone).delete();
       }
       else {
         await driverlocationupdate.document(phone).setData({
           'phone': phone,
           'lat': lat,
           'long': long
         }

         );
         print('yess done');


       }
     }


}