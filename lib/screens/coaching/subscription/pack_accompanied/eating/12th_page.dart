import 'package:flutter/material.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Eating12thPage extends StatefulWidget {
  @override
  State<Eating12thPage> createState() => _Eating12thPageState();
}

class _Eating12thPageState extends State<Eating12thPage> {
  bool _weighFood = false;
  bool _contraints = false;
  bool _desires = false;
  bool _trouble = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("AS-TU L’HABITUDE DE PESER TES ALIMENTS ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  _weighFood = !_weighFood;
                });
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _weighFood ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: _weighFood,
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                _weighFood = !_weighFood;
                              });
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border:   Border.all(color: _weighFood ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Oui",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  _weighFood = !_weighFood;
                });
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: !_weighFood ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: !_weighFood,
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                _weighFood = !_weighFood;
                              });
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: !_weighFood ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Non",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
        !_weighFood ? Container() : Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text("EST-CE QUE CELA REPRÉSENTE UNE CONTRAINTE (MATÉRIEL OU PSYCHOLOGIQUE) ?".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _contraints = !_contraints;
                    });
                  },
                  child: ZoomTapAnimation(end: 0.99,child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: _contraints ? AppColors.appmaincolor : Colors.transparent),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Transform.scale(
                            scale: 0.9,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Checkbox(
                                checkColor: Colors.transparent,
                                activeColor: AppColors.appmaincolor,
                                value: _contraints,
                                shape: CircleBorder(),
                                splashRadius: 20,
                                side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _contraints = !_contraints;
                                  });
                                },
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border:   Border.all(color: _contraints ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Oui",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                      ],
                    ),
                  ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _contraints = !_contraints;
                    });
                  },
                  child: ZoomTapAnimation(end: 0.99,child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: !_contraints ? AppColors.appmaincolor : Colors.transparent),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Transform.scale(
                            scale: 0.9,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Checkbox(
                                checkColor: Colors.transparent,
                                activeColor: AppColors.appmaincolor,
                                value: !_contraints,
                                shape: CircleBorder(),
                                splashRadius: 20,
                                side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _contraints = !_contraints;
                                  });
                                },
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: !_contraints ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Non",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                      ],
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text("DÉSIRES-TU PESER TES ALIMENTS DANS UN BUT DE PERFORMER LORS D’ÉCHÉANCES SPORTIVES OU PROFESSIONNELLES ? (CELA SIGNIFIE QUE D’ARRÊTER DE PESER TES ALIMENTS À TOUT MOMENT NE TE POSERAIT AUCUNE GÊNE OU ANGOISSE)".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  _desires = !_desires;
                });
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _desires ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: _desires,
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                _desires = !_desires;
                              });
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border:   Border.all(color: _desires ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Oui",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  _desires = !_desires;
                });
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: !_desires ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: !_desires,
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                _desires = !_desires;
                              });
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: !_desires ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Non",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text("DÉSIRES-TU TESTER UNE AUTRE MÉTHODE MOINS FASTIDIEUSE POUR TRACKER TES MACROS ? CHEZ RUNYOURLIFE NOUS UTILISONS UNE MÉTHODE QUI PERMET DE CONNAÎTRE SA QUANTITÉ DE MACROS GRÂCE À DES RÉFÉRENTIELS FACILES QUI TE SERONT EXPLIQUÉS DANS L’APPLICATION : C’EST UN SYSTÈME FIABLE QUE TU PEUX EMMENER AVEC DES AMIS AU RESTAU ! (RECOMMANDÉ)".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15,fontFamily: "AppFontStyle"),),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  _trouble = !_trouble;
                });
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: _trouble ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: _trouble,
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                _trouble = !_trouble;
                              });
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border:   Border.all(color: _trouble ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Oui",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  _trouble = !_trouble;
                });
              },
              child: ZoomTapAnimation(end: 0.99,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: !_trouble ? AppColors.appmaincolor : Colors.transparent),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Row(
                  children: [
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            checkColor: Colors.transparent,
                            activeColor: AppColors.appmaincolor,
                            value: !_trouble,
                            shape: CircleBorder(),
                            splashRadius: 20,
                            side: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                _trouble = !_trouble;
                              });
                            },
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: !_trouble ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Non",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
