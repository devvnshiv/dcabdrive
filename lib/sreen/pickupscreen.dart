import 'package:ekabbdriver/models/requestmodel.dart';
import 'package:ekabbdriver/sreen/mainpage.dart';
import 'package:ekabbdriver/utiles/colors.dart';
import 'package:ekabbdriver/utiles/resposive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class listRequest extends StatefulWidget {

  @override
  _listRequestState createState() => _listRequestState();
}

class _listRequestState extends State<listRequest> {
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPref();
  }
  String phone = '';
  String carname = '';
  Future<void> loadSharedPref() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      phone = prefs.getString('phone') ;
      carname = prefs.getString('carname');


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
              Container(height: SizeConfig.screenheghit/3.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Backgroundback.png',),
                      fit: BoxFit.fill
                  ),
                ),
                child:Stack(
                  children: [
                    Positioned(
                      top:SizeConfig.screenheghit/5,
                      child: Container(
                          height: 50,
                          width: SizeConfig.screenwedith,
                          child: Image.asset('assets/backimg.png',fit: BoxFit.fill,)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: (){
                          Navigator.pop(context);
                        }),
                        SizedBox(height: 10,),
                        SizedBox(width: 10,),
                        Center(child: Text('List of Costumer',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ],
                ) ,
              ),

                  SizedBox(height: 50,),
StreamBuilder<List<requestmodel>>(
  stream:   requestmodel(driverphone:phone).streamgetrequest(),
  builder: (context, snapshot) {

    if (snapshot.hasData) {
      return
        ListView.builder(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (_, iex) {
              return Card(
                elevation: 7,
                child: Container(
                  height: 100,

                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //Text(snapshot.data[iex].driverphone,style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.black54),),
                          SizedBox(width: 50,),
                          Text("\$ ${snapshot.data[iex].cost.trim()}",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),),
                          SizedBox(width: 50,),
                          Text('${snapshot.data[iex].finallocationlong} KM',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              requestmodel().deletequery(
                                  phone, snapshot.data[iex].Customerphonenuber);
                              print(snapshot.data[iex].Customerphonenuber);
                            },
                            child: Card(
                              child: Container(
                                height: 30,
                                width: 100,
                                color: Colors.black12,
                                child: Center(child: Text('Ignore',
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),)),
                              ),
                            ),
                          ),

                          SizedBox(width: 60,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      onaccept(cphone: snapshot.data[iex]
                                          .Customerphonenuber,
                                          driverphone: phone,
                                          cost: snapshot.data[iex].cost,
                                          km: snapshot.data[iex]
                                              .finallocationlong,carname: carname,)))
                              ;
                            },
                            child: Card(
                              child: Container(
                                height: 30,
                                width: 100,
                                color: maincolor,
                                child: Center(child: Text('Accept',
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }


        );
    }
    return CircularProgressIndicator();
  }
),



                

            ],
          ),
        ),
      ),
    );


  }



}


class onaccept extends StatefulWidget {
  final String cphone;
  final String driverphone;
  final String cost;
  final String km;
  final String carname;

  const onaccept({ this.cphone, this.driverphone, this.cost, this.km, this.carname}) ;
  @override
  _onacceptState createState() => _onacceptState();
}

class _onacceptState extends State<onaccept> {

  int count=0;

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
                                  'Discount', style: GoogleFonts
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
                        height: 200,
                        width: SizeConfig.screenwedith/1.1,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)
                        ),
                        child: Column(
                          children: [
                            Text("Offer Discount",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text(widget.cost,style: TextStyle(),),
                            SizedBox(height: 10,),
                            Text(widget.km.toString(),style: TextStyle(),),
                            SizedBox(height: 10,),
                            Center(
                              child: Row(
                                children: [
                                  SizedBox(width: 50,),
                                  OutlineButton(onPressed:(){
                                    setState(() {
                                      if(count>=1) {
                                        count = count - 1;
                                      }
                                    });
                                  },child: Icon(Icons.minimize_sharp)),
                                  SizedBox(width: 10,),

                                  Text(count.toString()),
                                  SizedBox(width: 10,),
                                  OutlineButton(onPressed:(){
                                    setState(() {
                                      if(count<= 19) {
                                        count = count + 1;
                                      }
                                    });},child: Icon(Icons.add)),
                                ],
                              ),
                            ),
                            SizedBox(width: 50,),
                            Row(
                              children: [
                                SizedBox(width: 50,),
                                OutlineButton(onPressed: ()=>Navigator.pop(context), color:Colors.black12,child: Text("back",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black12),)),
                                SizedBox(width: 20,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  onaccept()))
                                    ;
                                  },
                                  child: Card(
                                    child: GestureDetector(
                                      onTap: ()async{
                                        print(count);
                                        await requestmodel().accept(widget.driverphone, widget.cphone, count.toString(), widget.cost,widget.carname);
                                        await requestmodel().deletequery(widget.driverphone,widget.cphone);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        color: maincolor,
                                        child: Center(child: Text('Accept',style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: Colors.white),)),
                                      ),
                                    ),
                                  ),
                                )
                              ],

                            )
                          ],
                        )
                      )







                    ]
                )
            )));
  }
}