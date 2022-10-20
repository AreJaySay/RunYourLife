import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/screens/credentials/create_account.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/delayed.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import 'credentials/login.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final DelayedWidgets _delayedWidgets = new DelayedWidgets();
  final Routes _routes = new Routes();
  final Materialbutton _materialbutton = new Materialbutton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset("assets/important_assets/new_background.png",width: double.infinity,filterQuality: FilterQuality.high,fit: BoxFit.fitWidth,),
            Image.asset("assets/important_assets/new_background.png",width: double.infinity,filterQuality: FilterQuality.high,fit: BoxFit.contain,),
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: _delayedWidgets.delayedWidget(
                delayDuration: 200,
                delayedAnimations: DelayedAnimations.SLIDE_FROM_BOTTOM,
                animationDuration: 200,
                widget: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          for(var x = 0; x < 2; x++)...{
                            _materialbutton.materialButton("SE CONNECTER", () {
                              _routes.navigator_push(context, Login());
                            }),
                          }
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          child: Center(
                            child: Text("CRÉER UN COMPTE",style: TextStyle(fontSize: 16,fontFamily: "AppFontStyle",color: Colors.white),),
                          ),
                        ),
                        onTap: (){
                          _routes.navigator_push(context, CreateAccount());
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
