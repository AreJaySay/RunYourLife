import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../verify_code.dart';

class EmailSent extends StatefulWidget {
  @override
  _EmailSentState createState() => _EmailSentState();
}

class _EmailSentState extends State<EmailSent> {
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  final Materialbutton _materialbutton = new Materialbutton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.preferredSize(height: 70,logowidth: 90),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Image(
                width: double.infinity,
                fit: BoxFit.cover,
                color: Colors.grey[100],
                image: AssetImage("assets/icons/logo_icon.png"),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("MAIL ENVOYÉ !",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Un e-mail vous a été envoyé avec un code de vérification à",style: TextStyle(fontFamily: "AppFontStyle"),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("l'adresse",style: TextStyle(fontFamily: "AppFontStyle"),),
                        Text(" john.doe@gmail.com",style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                      ],
                    ),
                    Text("pour changer de mot de passe !",style: TextStyle(fontFamily: "AppFontStyle"),)
                  ],
                ),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: AppGradientColors.gradient,
                    borderRadius: BorderRadius.circular(1000)
                  ),
                  child: Center(
                    child: Icon(Icons.email_outlined,size: 70,color: Colors.white,),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: _materialbutton.materialButton("ENTREZ LE CODE DE VÉRIFICATION", () {
                    _routes.navigator_pushreplacement(context, EnterVerificationCode());
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
