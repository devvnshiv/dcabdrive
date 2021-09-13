/*
 * Copyright (c) 2020.  N v shivaprasad  30/07/1997
 */



import 'package:ekabbdriver/models/walletmodel.dart';
import 'package:ekabbdriver/utiles/colors.dart';
import 'package:ekabbdriver/utiles/resposive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class wallets extends StatefulWidget {
  @override
  _walletsState createState() => _walletsState();
}

class _walletsState extends State<wallets> {



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
        body: ListView(
          children: [

            Stack(
              children: [
                Container(
                  height: SizeConfig.screenheghit/3,
                  width: SizeConfig.screenwedith,
                  decoration:BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/sectiondrawer.png')
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,), onPressed:(){
                            Navigator.pop(context);

                          }),

                        ],
                      ),
                      Text("My Wallet,",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 25,color:Colors.white)),
                    ],
                  ),

                ),
                Container(
                  height:   (SizeConfig.screenheghit),

                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: (SizeConfig.screenheghit/4.5),),
                    Center(

                      child: Container(
                        height:SizeConfig.screenheghit/3 ,
                        width:SizeConfig.screenwedith/1.1 ,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12)
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: SizeConfig.screenheghit/7,
                              child: Image.asset('assets/Group9656.png'),

                            ),
                            Container(height: 1,color: Colors.black12,),
                            SizedBox(height: 10,),
                            Row(

                              children: [
                                SizedBox(width: 10,),
                                Text('BALANCE',style: GoogleFonts.openSans(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.bold),),
                                SizedBox(width:SizeConfig.screenwedith/1.9,),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(

                              children: [
                                SizedBox(width: 8,),
                                StreamBuilder< driverwalletmodel>(
                                    stream:  driverwalletmodel(driverphone:userphone).getwalletin(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text('\$${snapshot.data.blances}',
                                          style: GoogleFonts.openSans(
                                              fontSize: 20,
                                              color: maincolor,
                                              fontWeight: FontWeight.bold),);
                                      } return Center(child: CircularProgressIndicator());
                                    }
                                ),
                                SizedBox(width:SizeConfig.screenwedith/1.9,),

                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(height: 30,
                              width:SizeConfig.screenwedith/1.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: maincolor
                              ),
                              child: Center(child: Text('Request',style: GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.bold),)),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Card(
                      child: ListTile(
                        title: Text('requested  Amount:0.00'),
                        
                      ),
                    )

                  ],
                )




              ],
            ),


          ],
        ),
      ),
    );
  }
}