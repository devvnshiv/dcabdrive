
/*
 * Copyright (c) 2020.  N v shivaprasad  30/07/1997
 */

import 'package:ekabbdriver/models/authmodels.dart';
import 'package:ekabbdriver/sreen/mainpage.dart';
import 'package:ekabbdriver/utiles/colors.dart';
import 'package:ekabbdriver/utiles/resposive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';



class loginscreen extends StatefulWidget {
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String phone = '';
  int _Stwich = 0;
  String phoneNumber;
  String phoneIsoCode;
  String smsCode;
  String verificationCode;
  int userd = 0;
  int load = 0;

  Future<void> initState() {
    super.initState();
    _handleCameraAndMic();

  }


  Future<void> _submit() async {
    final PhoneVerificationCompleted verificationSuccess = (AuthCredential credential) {
      setState(() {
        print("Verification");
        print(credential);

      });
    };

    final PhoneVerificationFailed phoneVerificationFailed = (
        AuthException exception) {
      print("${exception.message}");
    };
    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) => print("Signed In"));
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {

      this.verificationCode = verId;
    };


    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationSuccess,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout
    );
  }
  Future<bool> smsCodeDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Enter Code",
              style: TextStyle(
                color: Colors.green[900],
              ),
            ),
            content: TextField(
              onChanged: (Value){
                smsCode=Value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text("Verify",
                  style: TextStyle(
                    color: Colors.green[900],
                  ),
                ),
                onPressed: ()async{
                  FirebaseAuth.instance.currentUser().then((user) async {
                    if(user!=null){

                      if(userd ==1){
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => null ),
                        ); } else {
                        Navigator.of(context).pop();
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('login', true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  null),
                        );
                      }

                    }
                    else{
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        }
    );
  }
  signIn() {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationCode, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(phoneAuthCredential)
        .then((user) async{if (userd ==1){
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  null),
      ); } else {
      Navigator.of(context).pop();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('login', true);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => null),
      );
    }
    }



    );

  }











  final formKey = GlobalKey<FormState>();
  Future<void> _handleCameraAndMic() async {
    await Permission.location.request();
  }
  String   confirmedNumber ;

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phone = number;
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
                  decoration: BoxDecoration(
                    color: maincolor,
                    borderRadius: BorderRadius.only(bottomRight:Radius.circular(50),bottomLeft: Radius.circular(50)),
                  ),
                  height: (SizeConfig.screenheghit)/1.9,
                  width:SizeConfig.screenwedith ,
                  child: Column(

                    children: [
                      SizedBox(height:(SizeConfig.screenheghit)/8 ,),
                      Center(
                        child: Container(
                            height: 100,
                            width: 100,

                            child: Image.asset('assets/logo.png')),
                      ),
                      SizedBox(height:(SizeConfig.screenheghit)/25 ,),
                      Container(
                          height: 100,
                          width: SizeConfig.screenwedith,
                          child: Image.asset('assets/ssd.png',fit: BoxFit.fill,)),

                    ],
                  ),

                ),
                Container(
                  height:   (SizeConfig.screenheghit),

                ),

                Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(height: (SizeConfig.screenheghit/2.5),),

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
      height: ( SizeConfig.screenheghit)/2.2,
      width: ( SizeConfig.screenwedith)/1.1,

      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Row(

              children: [
                SizedBox(width: SizeConfig.screenheghit/5.5,),
                Text("Sign In",style: GoogleFonts.openSans(color: Color(0xef030303),fontWeight: FontWeight.bold),),

              ],
            ),
            SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 4,width:100,decoration: BoxDecoration(
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
                SizedBox(width: 20,),
                Text("Login or SignUp with phone",style: GoogleFonts.roboto(color: Color(0xef010101),fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 30,),
            Form(
              key: formKey,
              child: Container(
                  height: 50,
                  width: 300,
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
                await _handleCameraAndMic();
                if(formKey.currentState.validate()) {
                  setState(() {
                    load =1;
                  });
                  var  result = await driveruser().checkuserpresent(phone);

                  if (result== true){
                    setState(() {
                      userd =1;
                      print('no');
                      print(userd);

                    });
                  } else {
                    print(userd);

                  }

                  print(phone);
                  driveruser ().   getdetailes(phone);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>mainpage()));
                }          },
              child: Container(
                height: 40,
                width: 280,
                decoration: BoxDecoration(
                  color: maincolor,
                  borderRadius: BorderRadius.circular(6),

                ),
                child: load == 0 ? Center(child: Text('Next',style: TextStyle(color: Colors.white),)):Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)),
              ),
            )
          ],
        ),
      ),

    );


  }


}