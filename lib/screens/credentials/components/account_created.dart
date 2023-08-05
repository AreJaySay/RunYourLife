import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../../../widgets/appbar.dart';
import '../login.dart';

class AccountCreated extends StatefulWidget {
  @override
  _AccountCreatedState createState() => _AccountCreatedState();
}

class _AccountCreatedState extends State<AccountCreated> with TickerProviderStateMixin {
  final Materialbutton _materialbutton = new Materialbutton();
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  late AnimationController scaleController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> scaleAnimation = CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> checkAnimation = CurvedAnimation(parent: checkController, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double circleSize = 120;
    double iconSize = 90;
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
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("FÉLICITATIONS !",textAlign: TextAlign.center,style: TextStyle(color: AppColors.appmaincolor,fontSize: 33,fontWeight: FontWeight.w700,fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Ton compte a été créé.",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 145,
                          width: 145,
                          decoration: BoxDecoration(
                            color: AppColors.appmaincolor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: ScaleTransition(
                                  scale: scaleAnimation,
                                  child: Container(
                                    height: circleSize,
                                    width: circleSize,
                                    decoration: BoxDecoration(
                                        color: AppColors.appmaincolor,
                                        shape: BoxShape.circle,
                                        gradient: AppGradientColors.gradient
                                    ),
                                  ),
                                ),
                              ),
                              SizeTransition(
                                sizeFactor: checkAnimation,
                                axis: Axis.horizontal,
                                axisAlignment: -1,
                                child: Center(
                                  child: Container(
                                    height: circleSize,
                                    width: circleSize,
                                    child: Center(
                                      child: Icon(Icons.check, color: Colors.white, size: iconSize),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: _materialbutton.materialButton("COMMENCER", () {
                      _routes.navigator_pushreplacement(context, Login(), transitionType: PageTransitionType.leftToRightWithFade);
                    }),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
