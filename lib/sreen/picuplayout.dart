import 'package:ekabbdriver/models/provider.dart';
import 'package:ekabbdriver/models/requestmodel.dart';
import 'package:ekabbdriver/sreen/accpetlayout.dart';
import 'package:ekabbdriver/sreen/finalrequest.dart';
import 'package:ekabbdriver/sreen/pickupscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pickuplayout extends StatefulWidget {
  final Widget scaffold;

  const pickuplayout({@required this.scaffold});
  @override
  _pickuplayoutState createState() => _pickuplayoutState();
}

class _pickuplayoutState extends State<pickuplayout> {
  String driverphone = '';

  void initState(){
    super.initState();
    loadSharedPref();
  }
  Future<void> loadSharedPref() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      driverphone = prefs.getString('phone') ;


    });
  }

  @override
  Widget build(BuildContext context) {
    final listrequest req = Provider.of<listrequest>(context);

   return StreamBuilder<List<requestmodel>>(
        stream: requestmodel(driverphone: driverphone).streamgetrequest(),
        builder: (context,sanpshots) {
          print(sanpshots.data.length);

          if (sanpshots.data.length != 0) {
       return     Scaffold(body: listRequest());
          }
          return  StreamBuilder<requestmodel>(
                stream: requestmodel(driverphone: driverphone).finalcust(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                  return   finalrequest(
                      cost: snapshot.data.cost,
                      discount: snapshot.data.discount,
                      name: snapshot.data.name,
                      phone: snapshot.data.Customerphonenuber,);
                  } else {
                    return widget.scaffold;
                  }


                }



            );


          return  CircularProgressIndicator();
          }




   );

  }
}
