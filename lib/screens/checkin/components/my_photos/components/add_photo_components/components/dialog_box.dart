import 'package:flutter/material.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import 'package:run_your_life/utils/palettes/app_colors.dart';

class AddPhotoDialogBox extends StatefulWidget {
  @override
  _AddPhotoDialogBoxState createState() => _AddPhotoDialogBoxState();
}

class _AddPhotoDialogBoxState extends State<AddPhotoDialogBox> with SingleTickerProviderStateMixin {
  final Materialbutton _materialbutton = new Materialbutton();
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.ease);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 280,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation!,
            child: Container(
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("ÊTES-VOUS",style: TextStyle(fontSize: 22,fontFamily: "AppFontStyle",color: AppColors.appmaincolor),),
                      Text(" SÛRS",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                  Text("DE VOULOIR QUITTER ?",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 50,
                    child:_materialbutton.materialButton("CONTINUER", () {
                      Navigator.of(context).pop(null);
                      Navigator.of(context).pop(null);
                      Navigator.of(context).pop(null);
                    },radius: 1000,bckgrndColor: AppColors.appmaincolor),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      child: Center(
                        child: Text("ANNULER",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600),),
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pop(null);
                    },
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}