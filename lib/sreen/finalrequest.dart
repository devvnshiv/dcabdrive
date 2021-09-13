import 'package:ekabbdriver/models/requestmodel.dart';
import 'package:ekabbdriver/models/triphistorymodel.dart';
import 'package:ekabbdriver/sreen/accpetlayout.dart';
import 'package:ekabbdriver/sreen/pickupscreen.dart';
import 'package:ekabbdriver/utiles/colors.dart';
import 'package:ekabbdriver/utiles/resposive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class finalrequest extends StatefulWidget {
  final  String cost;
  final String discount;
  final String phone;
  final LatLng s;
  final LatLng d;
  final String name;

  const finalrequest({ this.cost, this.discount, this.phone, this.s, this.d, this.name});
  @override
  _finalrequestState createState() => _finalrequestState();
}

class _finalrequestState extends State<finalrequest> {

var driverphone ='';

  void initState(){
    super.initState();
    loadSharedPref();
  }
  Future<void> loadSharedPref() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {

       driverphone = prefs.getString('phone') ?? 'jon';


    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(

                child: Column(
                    children: [
                      Container(height: SizeConfig.screenheghit / 3.8,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Backgroundback.png',),
                              fit: BoxFit.fill
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: SizeConfig.screenheghit / 5,
                              child: Container(
                                  height: 50,
                                  width: SizeConfig.screenwedith,
                                  child: Image.asset(
                                    'assets/backimg.png', fit: BoxFit.fill,)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                IconButton(icon: Icon(
                                  Icons.arrow_back_ios, color: Colors.white,),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                SizedBox(height: 10,),
                                SizedBox(width: 10,),
                                Center(child: Text(
                                  'Accept Coustmer', style: GoogleFonts
                                    .openSans(fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white),)),
                                SizedBox(height: 10,),

                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 50,),
    Container(
      height: SizeConfig.screenheghit/1.8,
      width: SizeConfig.screenwedith/1.4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12)
      ),
      child: Column(
        children: [
          Container(
          height: 30,
          width: SizeConfig.screenwedith/1.4,
          color: Colors.black12,
          child: Center(child: Text("User Details")),

          ),

          Container(height:SizeConfig.screenheghit/8,
              width: SizeConfig.screenwedith/1.4,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(-4,4),
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(4,-4),
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      widget.name,
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold)
                  ),
                  Text(
                      '\$${widget.cost}',
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold)
                  )
                ],
              )


          ),
SizedBox(height: 10,),
Container(
  height: 50,
  width: SizeConfig.screenwedith/1.4,
  child: Column(
    children: [
      Text("Info"),
    ],
  ),
),
          Container(height: 1,width:SizeConfig.screenwedith/1.5, color: Colors.black12,),
          SizedBox(height: 10,),
          Text("Trip Fare",style: TextStyle(color: Colors.black54),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Price',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontWeight: FontWeight
                          .bold)
              ),
              Text(
                  '\$${widget.cost}',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontWeight: FontWeight
                          .bold)
              )
            ],
          ),  SizedBox(height: 10,),Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Discount',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontWeight: FontWeight
                          .bold)
              ),
              Text(
                  '\$ ${widget.discount}',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontWeight: FontWeight
                          .bold)
              )
            ],
          ), SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Paid',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontWeight: FontWeight
                          .bold)
              ),
              Text(
                  '\$${(double.parse(widget.cost)-(double.parse(widget.discount)/100)*double.parse(widget.cost)).toStringAsFixed(2)}',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontWeight: FontWeight
                          .bold)
              )
            ],
          ),
          SizedBox(height: 10,),
      Row(
        children: [
          GestureDetector(
            onTap:(){
              requestmodel().deletequerys(driverphone);
      },
            child: Container(height: 30,
                width: SizeConfig.screenwedith /
                    4.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius
                        .circular(6),
                    color: maincolor
                ),
                child: Center(child: Text(
                    'Decline',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight
                            .bold)
                )
                )
            ),
          ),
          SizedBox(width: 30,), GestureDetector(
            onTap: () async{
requestmodel().useronride(widget.phone, driverphone);
requestmodel().driveronride(driverphone, widget.phone );
driverhistory(phone: driverphone). updatestat('enroute');


Navigator.push(context, MaterialPageRoute(builder: (context)=>Pickupscreen(phone: widget.phone,)));
            },
            child: Container(height: 30,
                width: SizeConfig.screenwedith /
                    4.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius
                        .circular(6),
                    color: maincolor
                ),
                child: Center(child: Text(
                    'Accept',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight
                            .bold)
                )
                )
            ),
          ),
        ],
      ),

        ],
      ),
    ),

                      ])))



    );
  }
}