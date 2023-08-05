import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step5_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../../../../../widgets/textfields.dart';

class Pregnant1stPage extends StatefulWidget {
  @override
  _Pregnant1stPageState createState() => _Pregnant1stPageState();
}

class _Pregnant1stPageState extends State<Pregnant1stPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(step5subs.sports[0].text.isEmpty){
    step5subs.sports.clear();
    step5subs.duration.clear();
    step5subs.sports.add(TextEditingController());
    step5subs.duration.add(TextEditingController());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Si tu pratiques un ou plusieurs sport(s), lequel pratiques-tu ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        for(var x = 0; x < step5subs.sports.length; x++)...{
          Container(
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: TextFields(step5subs.sports[x],hintText: "Nom du sport",),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  child: TextFields(step5subs.duration[x],hintText: "min/sem",),
                )
              ],
            ),
          ),
        },
        SizedBox(
          height: 20,
        ),
        InkWell(
          child: Container(
            height: 45,
            width: double.infinity,
            child: Center(
                child: Icon(Icons.add,color: Colors.white,)
            ),
            decoration: BoxDecoration(
                color: AppColors.pinkColor,
                borderRadius: BorderRadius.circular(1000)
            ),
          ),
          onTap: (){
            setState(() {
              step5subs.sports.add(TextEditingController());
              step5subs.duration.add(TextEditingController());
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
