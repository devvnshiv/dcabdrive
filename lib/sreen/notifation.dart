/*
 * Copyright (c) 2020.  N v shivaprasad  30/07/1997
 */

import 'package:ekabbdriver/utiles/resposive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class notifcation extends StatefulWidget {
  @override
  _notifcationState createState() => _notifcationState();
}

class _notifcationState extends State<notifcation> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Scaffold(
      body: ListView(
        children: [
          Column(
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
                child: Center(child: Text('Notification',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.white),)),
              )
            ],
          ),
          SizedBox(height: 30,),
          Card(
            child: ListTile(
              title: Text('WellCome to Ekabb'),
              subtitle:Text('Finish your target') ,
            ),
          )
        ],
      ),
    );
  }
}

