/*
 * Copyright (c) 2020.  N v shivaprasad  30/07/1997
 */
import 'package:ekabbdriver/models/authmodels.dart';
import 'package:ekabbdriver/models/requestmodel.dart';
import 'package:ekabbdriver/models/triphistorymodel.dart';
import 'package:ekabbdriver/utiles/colors.dart';
import 'package:ekabbdriver/utiles/resposive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class endtrip extends StatefulWidget {
  @override
  _endtripState createState() => _endtripState();
}

class _endtripState extends State<endtrip> {


  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPref();

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
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<requestmodel>(
          stream:requestmodel(driverphone: phone).getdriverride(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: StreamBuilder<driverhistory>(
                stream: driverhistory(userno: snapshot.data.Customerphonenuber).tripdetailes(),
                builder: (context, snapshot2) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Text("Trip has ended",
                          style: GoogleFonts
                              .openSans(
                              fontWeight: FontWeight
                                  .bold,
                              color: Colors.black,
                              fontSize: 20),),
                        SizedBox(height: 10,),

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
                            child: Column(
                              children: [
                                Text("Total Amount to be paid in cash",
                                  style: GoogleFonts
                                      .openSans(
                                      fontWeight: FontWeight
                                          .bold,
                                      color: Colors.black,
                                      fontSize: 12),),
                              snapshot2.data.paymentmode=="Cash"?  Text("\$${(double.parse(snapshot2.data.Cost)-(double.parse(snapshot2.data.Cost)*double.parse(snapshot2.data.discount)/100)).toStringAsFixed(2)}",
                                  style: GoogleFonts
                                      .openSans(
                                      fontWeight: FontWeight
                                          .bold,
                                      color: Colors.green,
                                      fontSize: 18)): Text("0.00",
                                style: GoogleFonts
                                    .openSans(
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors.black,
                                    fontSize: 12),),
                              ],
                            ),
                          ),


                    Container(
                      height: 200,
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
                      child: Column(
                        children: [
                          Text("Info",
                            style: GoogleFonts
                                .openSans(
                                fontWeight: FontWeight
                                    .bold,
                                color: Colors.black,
                                fontSize: 22),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cost Offered",
                                style: GoogleFonts
                                    .openSans(
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors.black,
                                    fontSize: 12),),
                              Text("\$${snapshot2.data.Cost}",
                                style: GoogleFonts
                                    .openSans(
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors.green,
                                    fontSize: 12),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discount",
                                style: GoogleFonts
                                    .openSans(
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors.black,
                                    fontSize: 12),),
                              Text(snapshot2.data.discount,
                                style: GoogleFonts
                                    .openSans(
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors.green,
                                    fontSize: 12),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Commission",
                                style: GoogleFonts
                                    .openSans(
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors.black,
                                    fontSize: 12),),
                              StreamBuilder<driveruser>(
                                stream: driveruser(phone: phone).sp(),
                                builder: (context, snapshot3) {
                                  return Text(snapshot3.data.commission,
                                    style: GoogleFonts
                                        .openSans(
                                        fontWeight: FontWeight
                                            .bold,
                                        color: Colors.green,
                                        fontSize: 12),);
                                }
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                        SizedBox(height: 10,),
                        Container(
                          height: 30,
                          width: 250,
                          color: maincolor,
                          child: Center(
                              child: Text(
                                "payment Accepted",
                                style: GoogleFonts
                                    .openSans(
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors
                                        .white),)),
                        ),
                      ],
                    ),
                  );
                }
              ),
            );
          }
        ),
      ),
    );
  }
}

