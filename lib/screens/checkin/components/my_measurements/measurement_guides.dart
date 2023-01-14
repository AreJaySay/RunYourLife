import 'package:flutter/material.dart';

import '../../../../widgets/appbar.dart';

class MeasurementGuides extends StatefulWidget {
  @override
  State<MeasurementGuides> createState() => _MeasurementGuidesState();
}

class _MeasurementGuidesState extends State<MeasurementGuides> {
  List<String> _title = ["","Tour de cou (cm) :","Tour d’épaules (cm) :","Tour de poitrine (cm) :","Haut de bras (cm) :","Tour de taille (cm) :","Tour de hanches (cm) :","Tour de cuisse (cm) :","Tour de mollet"];
  final AppBars _appBars = AppBars();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBars.bluegradient(context,
            Row(
              children: [
                BackButton(),
                Spacer(),
                Image(
                  color: Colors.black,
                  width: 85,
                  image: AssetImage("assets/important_assets/logo_new_white.png",),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),isMeasure: true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          children: [
            Text("Prise de mesures : mode \nd’emploi ",style: TextStyle(fontSize: 16,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black,width: 1.5)
                    )
                  ),
                  child: Text("Pour les femmes",style: TextStyle(fontSize: 15,fontFamily: "AppFontStyle"),),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black,width: 1.5)
                      )
                  ),
                  child: Text("Pour les hommes",style: TextStyle(fontSize: 15,fontFamily: "AppFontStyle"),),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            for(int x = 1; x < 9;x++)...{
              Row(
                children: [
                  Text(_title[x],style: TextStyle(fontSize: 13.5,fontFamily: "AppFontStyle"),),
                  Spacer(),
                  Text(_title[x],style: TextStyle(fontSize: 13.5,fontFamily: "AppFontStyle"),),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image(
                    width: 120,
                    image: AssetImage("assets/measures/women_${x}.png"),
                  ),
                  Spacer(),
                  Image(
                    width: 120,
                    image: AssetImage("assets/measures/men_${x}.png"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            }
          ],
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text("Pour les femmes",style: TextStyle(fontFamily: "AppFontStyle",color: Colors.black,fontSize: 15),),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         for(int x = 1; x < 9;x++)...{
        //           Text(_title[x],style: TextStyle(fontFamily: "AppFontStyle",fontSize: 13.5),),
        //           SizedBox(
        //             height: 3,
        //           ),
        //           Image(
        //             width: 110,
        //             image: AssetImage("assets/measures/women_${x}.png"),
        //           ),
        //           SizedBox(
        //             height: 5,
        //           ),
        //         }
        //       ],
        //     ),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         for(int x = 1; x < 9;x++)...{
        //           Image(
        //             width: 130,
        //             image: AssetImage("assets/measures/women_${x}.png"),
        //           )
        //         }
        //       ],
        //     ),
        //   ],
        // ),
      )
    );
  }
}
