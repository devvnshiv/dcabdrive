/*
 * Copyright (c) 2021.  N v shivaprasad  30/07/1997
 */
import 'package:ekabbdriver/refactor2/0/logic/authlogic/authlogic.dart';
import 'package:ekabbdriver/refactor2/0/utils/resposive.dart';
import 'package:ekabbdriver/utiles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permission_handler/permission_handler.dart';
class LoginPage extends StatefulWidget {




  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  Future<void> initState() {
    super.initState();
    _handleCameraAndMic();

  }
  String  phone = "";
  final formKey = GlobalKey<FormState>();
  Future<void> _handleCameraAndMic() async {
    await Permission.location.request();
  }



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [

            Stack(
              children: [



                Container(
                  decoration: BoxDecoration(
                    color: maincolor,
                    borderRadius: BorderRadius.only(bottomRight:Radius.circular(50),bottomLeft: Radius.circular(50)),
                  ),
                  height:45* AppSizeConfig.heightMultiplier,
                  width:100*AppSizeConfig.widthMultiplier ,
                  child: Column(

                    children: [
                      SizedBox(height:   5*AppSizeConfig.heightMultiplier ,),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10
                        ),
                        child: Container(
                            height: 15*AppSizeConfig.heightMultiplier,
                            width: 25*AppSizeConfig.widthMultiplier,

                            child: Image.asset('assets/logo.png',fit:BoxFit.cover)),
                      ),

                      SizedBox(height:1.1*AppSizeConfig.heightMultiplier,),
                      Container(
                          height: 15*AppSizeConfig.heightMultiplier,
                          width: 100*AppSizeConfig.widthMultiplier,
                          child: Image.asset('assets/ssd.png',fit: BoxFit.fill,)),

                    ],
                  ),

                ),


                Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(height: 39*AppSizeConfig.heightMultiplier,),

                    Center(child: logincontaner()),
                  ],
                ),


              ],
            ),


          ],
        ),
      ),
    );
  }
  Widget  logincontaner(){
    return  Container(
      decoration: BoxDecoration(
          border: Border.all(color:Colors.black12),
          color: Colors.white
      ),
      height:  50*AppSizeConfig.heightMultiplier,
      width: 95*AppSizeConfig.widthMultiplier,

      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Row(

              children: [
                SizedBox(width: 40*AppSizeConfig.widthMultiplier,),
                Text("Sign In",style: GoogleFonts.openSans(color: Color(0xef030303),fontWeight: FontWeight.bold,fontSize: 3.0*AppSizeConfig.textMultiplier),),

              ],
            ),
            SizedBox(height: 6,),
            Row(

              children: [
                SizedBox(width: 30*AppSizeConfig.widthMultiplier,),
                Container(height: 1.1*AppSizeConfig.heightMultiplier,width:35*AppSizeConfig.widthMultiplier,decoration: BoxDecoration(
                    color: maincolor,
                    borderRadius: BorderRadius.circular(10,))
                  ,),
                Container(height: 4,width:48,color: Colors.white,)
              ],
            ),
            SizedBox(height: 30,),
            Container(height: 1,color: Colors.grey.shade300,),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 30*AppSizeConfig.widthMultiplier,),
                Text("Login or SignUp with phone",style: GoogleFonts.roboto(color: Color(0xef010101),fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 30,),
            Form(
              key: formKey,
              child: Container(
                  height: 10*AppSizeConfig.heightMultiplier,
                  width: 90*AppSizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xefEBEBEB)),
                    borderRadius: BorderRadius.circular(6),

                  ),
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      hintText: '      Enter Your Mobile Number',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,

                    ),
                    initialCountryCode: 'IN',
                    onChanged: (value){
                      phone =value.completeNumber;
                    },
                    validator: (value){
                      if (value.isEmpty)
                        return 'enter Phone nuber';

                    },
                  )





                /*TextFormField(
                   cursorColor: Colors.black,
keyboardType: TextInputType.phone,
                   decoration: InputDecoration(
                     hintText: '      Enter Your Mobile Number',
                     prefixText: '+91',
                     border: InputBorder.none,
                     focusedBorder: InputBorder.none,
                     enabledBorder: InputBorder.none,
                     errorBorder: InputBorder.none,
                     disabledBorder: InputBorder.none,
                   ),
                 ),*/
              ),
            ),
            SizedBox(height: 35,),
            GestureDetector(
              onTap: () async{
                if(formKey.currentState.validate()) {
                  print('On tap');
                  AuthLogic().authwork(context,phone);

                }

              }        ,
              child: Container(
                  height: 40,
                  width: 280,
                  decoration: BoxDecoration(
                    color: maincolor,
                    borderRadius: BorderRadius.circular(6),

                  ),
                  child:  Center(child: Text('Login',style: TextStyle(color: Colors.white),))
              ),
            )
          ],
        ),
      ),

    );


  }


}
