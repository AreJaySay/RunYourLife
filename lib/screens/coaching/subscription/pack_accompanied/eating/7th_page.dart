import 'package:flutter/material.dart';
import 'package:run_your_life/models/subscription_models/step2_subs.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Eating7thPage extends StatefulWidget {
  @override
  _Eating7thPageState createState() => _Eating7thPageState();
}

class _Eating7thPageState extends State<Eating7thPage> {
  TextEditingController _hydration = new TextEditingController()..text=step2subs.water_per_day;
  TextEditingController _other = new TextEditingController()..text=step2subs.drink_other_than_water == "Non" ? "" : step2subs.drink_other_than_water;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hydration.dispose();
    _other.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("QUELLE QUANTITÉ D’EAU BOIS-TU PAR JOUR ?",style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _hydration,
          maxLines: 5,
          style: TextStyle(fontFamily: "AppFontStyle"),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Quantité d'eau bu par jour",
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
              step2subs.water_per_day = text;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        Text("Bois-tu d'autres boissons que de l'eau pour rester hydraté(e) ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: _other,
          maxLines: 5,
          style: TextStyle(fontFamily: "AppFontStyle"),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Autres boissons bues",
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
              step2subs.drink_other_than_water = text;
            });
          },
        ),
        // SizedBox(
        //   height: 30,
        // ),
        // ZoomTapAnimation(end: 0.99,child: Container(
        //     width: 130,
        //     padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(color: step2subs.drink_other_than_water == "Non" ? AppColors.appmaincolor : Colors.transparent,)
        //     ),
        //     child: Row(
        //       children: [
        //         SizedBox(
        //           width: 30,
        //           height: 30,
        //           child: Transform.scale(
        //             scale: 1.4,
        //             child: Radio(
        //               activeColor: AppColors.appmaincolor,
        //               value: 2,
        //               groupValue: step2subs.drink_other_than_water == "Non" ? 2 : 1,
        //               onChanged: (val) {
        //                 setState(() {
        //                   _other.text = "";
        //                   step2subs.drink_other_than_water = "Non";
        //                 });
        //               },
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 15,
        //         ),
        //         Text("Non",style: new TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
        //       ],
        //     ),
        //   ),
        //   onTap: (){
        //     setState(() {
        //       _other.text = "";
        //       step2subs.drink_other_than_water = "Non";
        //     });
        //   },
        // ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}