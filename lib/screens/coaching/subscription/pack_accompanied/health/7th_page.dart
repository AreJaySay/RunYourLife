import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step3_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Health7thPage extends StatefulWidget {
  @override
  _Health7thPageState createState() => _Health7thPageState();
}

class _Health7thPageState extends State<Health7thPage> {
  final TextEditingController _gynaecological = new TextEditingController()..text=step3subs.gynaecological_condition == "None" ? "" : step3subs.gynaecological_condition;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _gynaecological.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("As-tu une condition gynécologique spécifique (Syndrôme des ovaires polykistiques, endométriose préménopause, ménopause, ...)".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _gynaecological,
          maxLines: 4,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Syndrome prémenstruel",
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
              step3subs.gynaecological_condition = text;
            });
          },
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
