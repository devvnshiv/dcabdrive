import 'dart:async';

import 'package:ekabbdriver/models/requestmodel.dart';
import 'package:ekabbdriver/models/triphistorymodel.dart';
import 'package:ekabbdriver/models/walletmodel.dart';
import 'package:ekabbdriver/sreen/endtrip.dart';
import 'package:ekabbdriver/utiles/colors.dart';
import 'package:ekabbdriver/utiles/resposive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:url_launcher/url_launcher.dart';

class Pickupscreen extends StatefulWidget {
  final String phone;
  final String cost;

  const Pickupscreen({ this.phone, this.cost}) ;


  @override
  _PickupscreenState createState() => _PickupscreenState();
}

class _PickupscreenState extends State<Pickupscreen> {
  BitmapDescriptor pinLocationIcon;
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapcontroll;
  final Geolocator geolocator = Geolocator();
  Position _currentlocation;
  String _currentaddress;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline>polylines = {};
  List<LatLng> polycodinetes = [];
  Timer timer;
  String address = '';
  bool isSwitched = false;
  String d = "go to pickup";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPref();

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String phone = "";
  Future<void> loadSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      phone = prefs.getString('phone');
      // String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return

      SafeArea(
          child: Scaffold(

            body: StreamBuilder<requestmodel>(
              stream:requestmodel(driverphone: phone). getdriverride(),
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      
                    children: [

                      StreamBuilder<driverhistory>(
                        stream: driverhistory(userno:snapshot.data.Customerphonenuber).tripdetailes(),
                        builder: (context, snapshots) {
                          return Align(
                            alignment: Alignment.topRight,

                              child: Row(
                                children: [
                                  Text("Pickup Location"),
                                  InkWell(
                                    onTap: () {

print(snapshots.data.paymentmode);
launch('https://www.google.com/maps/search/?api=1&query=${snapshots.data.slat},${snapshots.data.slong}');
                                    },


                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      child: Image.asset('assets/map.png') ,
                                    ),
                                  ),
                                  Text("Drop Location"),
                                  InkWell(
                                    onTap: () {

                                      print('hello');
                                      launch('https://www.google.com/maps/search/?api=1&query=${snapshots.data.dlat},${snapshots.data.dong}');
                                    },


                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      child: Image.asset('assets/map.png') ,
                                    ),
                                  ),
                                ],
                              ),

                          );
                        }
                      ),

                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

                            Container(

                                height: SizeConfig.screenheghit/3.0,
                                width: SizeConfig.screenwedith,
                                decoration: BoxDecoration(
                                    color: Colors.white,

                                    borderRadius: BorderRadius.only(topRight: Radius
                                        .circular(40),
                                        topLeft: Radius.circular(40))
                                ),
                                child: StreamBuilder<requestmodel>(
                                  stream: requestmodel(driverphone:snapshot.data.Customerphonenuber).getdeal(),
                                  builder: (context, snapshotd) {
                                    if (snapshotd.hasData) {
                                      return


                                        Column(
                                            children: [
                                              SizedBox(height: 30,),
                                              Text("Your are on Trip",
                                                style: GoogleFonts
                                                    .openSans(
                                                    fontWeight: FontWeight
                                                        .bold,
                                                    color: Colors.black,
                                                    fontSize: 12),),
                                              SizedBox(height: 30,),
                                              Container(
                                                height: SizeConfig.screenheghit / 8,
                                                width: SizeConfig.screenwedith / 1.09,

                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(8),
                                                    border: Border.all(
                                                        color: Colors.black12),
                                                    color: Colors.white,
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 5,
                                                        offset: Offset(-4, 4),
                                                      ),
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 5,
                                                        offset: Offset(4, -4),
                                                      )
                                                    ]
                                                ),
                                                child: Row(
                                                  children: [

                                                    SizedBox(width: 10,),
                                                    Column(
                                                      children: [
                                                        SizedBox(height: SizeConfig
                                                            .screenheghit / 32,),
                                                        Text(snapshotd.data.name,
                                                          style: GoogleFonts.openSans(
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Colors.black87,
                                                              fontSize: 12),),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.star,
                                                              color: Colors.amber,),
                                                            Text(snapshot.data.Customerphonenuber,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Colors.black,
                                                                  fontSize: 12),),
                                                          ],
                                                        ),
                                                      ],

                                                    ),
                                                    SizedBox(
                                                      width: SizeConfig.screenwedith /
                                                          3.0,),
                                                    Column(
                                                      children: [
                                                        SizedBox(height: SizeConfig
                                                            .screenheghit / 32,),
                                                        GestureDetector(
                                                          onTap: (){
                                                            launch("tel:${snapshot.data.Customerphonenuber}");
                                                          },
                                                          child: Text("Call",
                                                            style: GoogleFonts.openSans(
                                                              fontWeight: FontWeight
                                                                  .bold,),),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Container(
                                                          height: 15,
                                                          width: 60,
                                                          decoration: BoxDecoration(
                                                              color: maincolor,
                                                              borderRadius: BorderRadius
                                                                  .circular(30)

                                                          ),
                                                          child: Center(child: Text(
                                                            "tap",
                                                            style: GoogleFonts
                                                                .openSans(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),)),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              StreamBuilder<driverhistory>(
                                                stream: driverhistory(phone: phone).getstatstrea(),
                                                builder: (context, snapshot3) {
                                                  if (snapshot3.hasData) {
                                                    return SwipeTo(
                                                      child: Container(
                                                        height: 30,
                                                        width: 250,
                                                        color: maincolor,
                                                        child: Center(
                                                            child: Text(
                                                              d,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .white),)),
                                                      ),
                                                      onRightSwipe: () {
                                                        if (snapshot3.data
                                                            .Status == 'enroute') {
                                                          setState(() {
                                                            d =
                                                            'Reached pickup location';
                                                            driverhistory(
                                                                phone: phone)
                                                                .updatestat("Reached");
                                                          });
                                                        } else
                                                        if (snapshot3.data
                                                            .Status ==
                                                            'Reached') {
                                                          setState(() {
                                                            d =
                                                            'Start the Trip';
                                                            driverhistory(
                                                                phone: phone)
                                                                .updatestat(
                                                                "Trip");
                                                          });
                                                        }
                                                        if (snapshot3.data
                                                            .Status == 'Trip') {
                                                          setState(() {
                                                            d =
                                                            'End';
                                                            driverhistory(
                                                                phone: phone)
                                                                .updatestat(
                                                                "onTrip");
                                                          });
                                                        } else
                                                        if (snapshot3.data.Status== 'onTrip') {
                                                          setState(() {
                                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>endtrip()));
                                                          });
                                                        }
                                                      } );
                                                  }
                                                  return Center(
                                                      child: CircularProgressIndicator());
                                                }
                                              ),

                                            ]);
                                    }
                                    return Center(child: CircularProgressIndicator());
                                  }

                                )

                      ) ])]
                ),
                  )
          );
              }
            )
          )
      );



  }
}
