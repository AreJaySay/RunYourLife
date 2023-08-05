import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../../../widgets/appbar.dart';
import '../../../../../../../widgets/materialbutton.dart';

class Health6thPage extends StatefulWidget {
  @override
  _Health6thPageState createState() => _Health6thPageState();
}

class _Health6thPageState extends State<Health6thPage> {
  final TextEditingController _syndrome = new TextEditingController()..text=step3subs.premenstrual_syndrome == "Non" ||  step3subs.premenstrual_syndrome == "none" || step3subs.premenstrual_syndrome == "" ? "" : step3subs.premenstrual_syndrome;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _syndrome.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("As-tu un syndrôme prémenstruel (mal à la poitrine, bouffée de chaleur, changement d'humeur, douleurs bas du ventre, ou bas du dos, constipation gazs, ballonements, rétention d'eau ?)".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _syndrome,
          maxLines: 4,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Syndrôme prémenstruel",
              hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appmaincolor),
                  borderRadius: BorderRadius.circular(10)
              ),
          ),
          onChanged: (text){
            setState(() {
              step3subs.premenstrual_syndrome = text;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        ZoomTapAnimation(
          end: 0.99,
          child: Container(
            width: 130,
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: step3subs.premenstrual_syndrome == "Non" ? AppColors.appmaincolor : Colors.transparent,)
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Transform.scale(
                    scale: 1.4,
                    child: Radio(
                      activeColor: AppColors.appmaincolor,
                      value: 2,
                      groupValue: step3subs.premenstrual_syndrome == "Non" ? 2 : 1,
                      onChanged: (val) {
                        setState(() {
                          _syndrome.text = "";
                          step3subs.premenstrual_syndrome = "Non";
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('Non',style: new TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
              ],
            ),
          ),
          onTap: (){
            setState(() {
              _syndrome.text = "";
              step3subs.premenstrual_syndrome = "Non";
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
