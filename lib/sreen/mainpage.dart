import 'dart:async';

import 'package:ekabbdriver/models/driverlocationmodel.dart';
import 'package:ekabbdriver/models/walletmodel.dart';
import 'package:ekabbdriver/sreen/accpetlayout.dart';
import 'package:ekabbdriver/sreen/notifation.dart';
import 'package:ekabbdriver/sreen/picuplayout.dart';
import 'package:ekabbdriver/sreen/walletsceen.dart';
import 'package:ekabbdriver/utiles/colors.dart';
import 'package:ekabbdriver/utiles/resposive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';



class mainpage extends StatefulWidget {
  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPref();
    _getcurrentlocation();
    timer = Timer.periodic(Duration(seconds: 15),(Timer t)async{
   await   _getcurrentlocation();
await driverlocation().updatelocation(phone, _currentlocation.latitude, _currentlocation.longitude,isSwitched);
    });
    _getcurrentlocation();

  }

String carname = '';
String carnumber = '';
String phone = "";
  Future<void> loadSharedPref() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
phone = prefs.getString('phone');
      carname = prefs.getString('carname') ?? 'jon';
      carnumber = prefs.getString('carno') ?? 'jon';

    });
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  _getcurrentlocation() async {
    await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,)
        .
    then((Position position) async {
      setState(() {
        _currentlocation = position;
        print('CURRENT POS: $_currentlocation');
        mapcontroll.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.0,


            ))

        );
      });
    });
  }



  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);
    return pickuplayout(

      scaffold:SafeArea(
        child: Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon:  Icon( Icons.menu_rounded,color: Colors.black,),
              onPressed: (){Navigator.push(
                 context, MaterialPageRoute(builder: (context) => Drawerd()));},
            ),
            centerTitle: true,
            title: isSwitched == false ?   Text("Offline",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 16),):  Text("Online",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 16),),
            actions: [
            Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
              inactiveTrackColor: Colors.red,

          ),

        ],
          ),
          body: Stack(
            children: [
              GoogleMap(
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                initialCameraPosition: _initialLocation,
                trafficEnabled: true,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {

                  mapcontroll = controller;



                },

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StreamBuilder<driverwalletmodel>(

                    stream: driverwalletmodel(driverphone: phone).getwalletin(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(

                            height: SizeConfig.screenheghit / 3.0,
                            width: SizeConfig.screenwedith,
                            decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.only(topRight: Radius
                                    .circular(40),
                                    topLeft: Radius.circular(40))
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Container(height: SizeConfig.screenheghit / 8,
                                  width: SizeConfig.screenwedith / 1.09,

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black12),
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
                                      CircleAvatar(
                                        radius: 26,
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: SizeConfig.screenheghit /
                                                32,),
                                          Text(carname,
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                                fontSize: 12),),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                color: Colors.amber,),
                                              Text(carnumber,
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 12),),
                                            ],
                                          ),
                                        ],

                                      ),
                                      SizedBox(
                                        width: SizeConfig.screenwedith / 3.0,),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: SizeConfig.screenheghit /
                                                32,),
                                          Text("\$${snapshot.data.blances}",
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,),),
                                          SizedBox(height: 5,),
                                          Container(
                                            height: 15,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: maincolor,
                                                borderRadius: BorderRadius
                                                    .circular(30)

                                            ),
                                            child: Center(child: Text("Balance",
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Colors.white),)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Container(height: SizeConfig.screenheghit / 7,
                                  width: SizeConfig.screenwedith / 1.09,

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black12),
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
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [

                                      Column(

                                        children: [
                                          SizedBox(height: 20,),
                                          Icon(Icons.star_border,
                                            color: Colors.amber, size: 26,),
                                          Text("0.00",
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),),

                                        ],
                                      ),

                                      Container(
                                          height: SizeConfig.screenheghit / 16,
                                          child: VerticalDivider(
                                            color: Colors.black12,
                                            thickness: 1,)),
                                      Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Icon(Icons.speed_rounded,
                                            color: maincolor, size: 26,),
                                          Text("0.00",
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),),
                                        ],
                                      ),
                                      Container(
                                          height: SizeConfig.screenheghit / 16,
                                          child: VerticalDivider(
                                            color: Colors.black12,
                                            thickness: 1,)),
                                      Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Icon(Icons.local_taxi_sharp,
                                            color: maincolor, size: 26,),
                                          Text("0.00",
                                            style: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 12),),
                                        ],
                                      ),

                                    ],

                                  ),
                                ),


                              ],
                            )
                        );
                      }
                      return CircularProgressIndicator();
                    }
                  )
                ])

                      ],
                    ),
                  )
      ),
    );


  }
}

class Drawerd extends StatefulWidget {
  final String phone;

  const Drawerd({ this.phone});
  @override
  _DrawerdState createState() => _DrawerdState();
}

class _DrawerdState extends State<Drawerd> {

  String userphone = "";
  String name= '';


  void initState(){
    super.initState();
    loadSharedPref();
  }

  Future<void> loadSharedPref() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      userphone = prefs.getString('phone') ?? 'jon';
      name = prefs.getString('name') ?? 'jon';

    });
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: SizeConfig.screenheghit/4,
              width: SizeConfig.screenwedith,

              decoration: BoxDecoration(
                  image:DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(

                          'assets/sectiondrawer.png'
                      )
                  )
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,), onPressed:(){
                            Navigator.pop(context);
                          }),
                          SizedBox(width:SizeConfig.screenwedith/3.5,),
                          Center(
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: maincolor,
                              backgroundImage:AssetImage('assets/logo.png'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(name,style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.white),),
                      Text(userphone,style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.white),)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => mainpage()));
                },
                leading: Icon(Icons.home,color: maincolor,),
                title: Text("Home",style:GoogleFonts.openSans(fontWeight: FontWeight.bold,) ,),

              ),

            ),
            Card(
              child: ListTile(
                onTap: (){
                 Navigator.push(
                   context, MaterialPageRoute(builder: (context) => wallets()));
                },
                leading: Icon(Icons.account_balance_wallet_sharp,color: maincolor,),
                title: Text("Wallet",style:GoogleFonts.openSans(fontWeight: FontWeight.bold,) ,),

              ),

            ),


            Card(
              child: ListTile(
                leading: Icon(Icons.history,color: maincolor,),
                title: Text("History",style:GoogleFonts.openSans(fontWeight: FontWeight.bold,) ,),

              ),

            ),
            Card(
              child: ListTile(
                onTap: (){
                Navigator.push(
                   context, MaterialPageRoute(builder: (context) => notifcation()));
                },
                leading: Icon(Icons.notifications,color: maincolor,),
                title: Text("Notifications",style:GoogleFonts.openSans(fontWeight: FontWeight.bold,) ,),

              ),

            ),
            Card(
              child: ListTile(
                onTap: (){
                 Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Pickupscreen()));
                },
                leading: Icon(Icons.logout,color: maincolor,),
                title: Text("On ride",style:GoogleFonts.openSans(fontWeight: FontWeight.bold,) ,),

              ),

            ),
            Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => loginscreen()));
                },
                leading: Icon(Icons.logout,color: maincolor,),
                title: Text("Logout",style:GoogleFonts.openSans(fontWeight: FontWeight.bold,) ,),

              ),

            ),
          ],
        ),
      ),
    );
  }
}