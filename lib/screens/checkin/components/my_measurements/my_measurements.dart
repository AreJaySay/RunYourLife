import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/checkin/measures.dart';
import 'package:run_your_life/screens/checkin/components/my_measurements/measurement_guides.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/textfields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../services/stream_services/screens/checkin.dart';

class MyMeasurements extends StatefulWidget {
  @override
  _MyMeasurementsState createState() => _MyMeasurementsState();
}

class _MyMeasurementsState extends State<MyMeasurements> {
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final CheckinServices _checkinServices = new CheckinServices();
  final Materialbutton _materialbutton = new Materialbutton();
  bool _isLoading = false;
  List _bodyparts = ["Cou","Epaules","Poitrine","Haut du bras","Taille","Hanches","Haut de cuisse","Mollet"];
  List<TextEditingController> _controllers = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    _checkinServices.getUpdated().then((value){
      if(value != null){
        setState(() {
          if(value["last_measure"] != null){
            _controllers[0].text = value["last_measure"]["neck"].toString() == "null" ? "" : value["last_measure"]["neck"].toString();
            _controllers[1].text = value["last_measure"]["shoulder"].toString() == "null" ? "" : value["last_measure"]["shoulder"].toString();
            _controllers[2].text = value["last_measure"]["chest"].toString() == "null" ? "" : value["last_measure"]["chest"].toString();
            _controllers[3].text = value["last_measure"]["upper_arm"].toString() == "null" ? "" : value["last_measure"]["upper_arm"].toString();
            _controllers[4].text = value["last_measure"]["waist"].toString() == "null" ? "" : value["last_measure"]["waist"].toString();
            _controllers[5].text = value["last_measure"]["hips"].toString() == "null" ? "" : value["last_measure"]["hips"].toString();
            _controllers[6].text = value["last_measure"]["upper_thigh"].toString() == "null" ? "" : value["last_measure"]["upper_thigh"].toString();
            _controllers[7].text = value["last_measure"]["calf"].toString() == "null" ? "" : value["last_measure"]["calf"].toString();
            measures.neck =  value["last_measure"]["neck"].toString() == "null" ? "" : value["last_measure"]["neck"].toString();;
            measures.shoulder = value["last_measure"]["shoulder"].toString() == "null" ? "" : value["last_measure"]["shoulder"].toString();
            measures.chest = value["last_measure"]["chest"].toString() == "null" ? "" : value["last_measure"]["chest"].toString();
            measures.upper_arm = value["last_measure"]["upper_arm"].toString() == "null" ? "" : value["last_measure"]["upper_arm"].toString();
            measures.waist = value["last_measure"]["waist"].toString() == "null" ? "" : value["last_measure"]["waist"].toString();
            measures.hips = value["last_measure"]["hips"].toString() == "null" ? "" : value["last_measure"]["hips"].toString();
            measures.upper_thigh = value["last_measure"]["upper_thigh"].toString() == "null" ? "" : value["last_measure"]["upper_thigh"].toString();
            measures.calf = value["last_measure"]["calf"].toString() == "null" ? "" : value["last_measure"]["calf"].toString();
          }else{
            _controllers[0].text = "";
            _controllers[1].text = "";
            _controllers[2].text = "";
            _controllers[3].text = "";
            _controllers[4].text = "";
            _controllers[5].text = "";
            _controllers[6].text = "";
            _controllers[7].text = "";
          }
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: _appBars.whiteappbar(context, title: "MES MESURES"),
        body: Stack(
          children: [
            Image(
              width: double.infinity,
              fit: BoxFit.cover,
              image: AssetImage("assets/important_assets/heart_icon.png"),
            ),
            _isLoading?
            Center(child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(color: AppColors.appmaincolor,),
            )) :
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              children: [
                Text("CONSEIL DU COACH",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                SizedBox(
                  height: 5,
                ),
                Text("Regarde bien ce schema pour être régulier dans la manière dont tu prends tes mesures. Prends des repères sur ton corps afin de le répéter toutes les semaines de la même manière.",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                SizedBox(
                  height: 15,
                ),
                ZoomTapAnimation(
                  end: 0.99,
                  onTap: (){
                    _routes.navigator_push(context, MeasurementGuides());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        border: Border.all(color: AppColors.pinkColor),
                        borderRadius: BorderRadius.circular(1000)
                    ),
                    child: Center(child: Text("SCHÉMA",style: TextStyle(color: AppColors.pinkColor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                for(var x = 0; x < _bodyparts.length; x++)...{
                  Text(_bodyparts[x],style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: AppColors.appmaincolor),),
                  SizedBox(
                    height: 5,
                  ),
                  TextFields(_controllers[x],hintText: _bodyparts[x],onChanged: (text){
                    setState((){
                      if(x == 0){
                        measures.neck = text;
                      }else if(x == 1){
                        measures.shoulder = text;
                      }else if(x == 2){
                        measures.chest = text;
                      }else if(x == 3){
                        measures.upper_arm = text;
                      }else if(x == 4){
                        measures.waist = text;
                      }else if(x == 5){
                        measures.hips = text;
                      }else if(x == 6){
                        measures.upper_thigh = text;
                      }else{
                        measures.calf = text;
                      }
                    });
                  },inputType: TextInputType.numberWithOptions(decimal: true)),
                  SizedBox(
                    height: 15,
                  )
                },
                SizedBox(
                  height: 120,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 110,
                color: Colors.white,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsets.only(top: 20),
                  child: _materialbutton.materialButton("VALIDER", (){
                    if(_controllers[0].text.isEmpty || _controllers[1].text.isEmpty || _controllers[2].text.isEmpty || _controllers[3].text.isEmpty || _controllers[4].text.isEmpty || _controllers[5].text.isEmpty || _controllers[6].text.isEmpty || _controllers[7].text.isEmpty){
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                          context: context, builder: (context){
                        return _confirmation();
                      });
                    }else{
                      _screenLoaders.functionLoader(context);
                      _checkinServices.submit_measures(context).then((res){
                        if(res != null){
                          _checkinServices.getUpdated().then((value)async{
                            if(value != null){
                              setState(() {
                                if(!CheckinServices.checkinSelected.toString().contains("MES MESURES")){
                                  CheckinServices.checkinSelected.add("MES MESURES");
                                }
                                if(value["last_measure"] != null){
                                  _controllers[0].text = value["last_measure"]["neck"].toString();
                                  _controllers[1].text = value["last_measure"]["shoulder"].toString();
                                  _controllers[2].text = value["last_measure"]["chest"].toString();
                                  _controllers[3].text = value["last_measure"]["upper_arm"].toString();
                                  _controllers[4].text = value["last_measure"]["waist"].toString();
                                  _controllers[5].text = value["last_measure"]["hips"].toString();
                                  _controllers[6].text = value["last_measure"]["upper_thigh"].toString();
                                  _controllers[7].text = value["last_measure"]["calf"].toString();
                                }else{
                                  _controllers[0].text = "";
                                  _controllers[1].text = "";
                                  _controllers[2].text = "";
                                  _controllers[3].text = "";
                                  _controllers[4].text = "";
                                  _controllers[5].text = "";
                                  _controllers[6].text = "";
                                  _controllers[7].text = "";
                                }
                              });
                            }
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("other_date", DateTime.now().toUtc().add(Duration(hours: 2)).toString());
                            prefs.setStringList("checkin", CheckinServices.checkinSelected.cast<String>());
                            Navigator.of(context).pop(null);
                            Navigator.of(context).pop(null);
                            print("MEASURES ${value.toString()}");
                            _snackbarMessage.snackbarMessage(context, message: "Mise à jour effectuée.");
                          });
                        }else{
                          Navigator.of(context).pop(null);
                          _snackbarMessage.snackbarMessage(context, message: "Impossible de soumettre messurements. Veuillez réessayer !");
                        }
                      });
                    }
                  },bckgrndColor: AppColors.appmaincolor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _confirmation(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      width: double.infinity,
      height: 270,
      child: Column(
        children: [
          Text("Toutes les informations n’ont pas été remplies, êtes-vous sûr de vouloir valider ? Vous ne pourrez plus les modifier ensuite",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontFamily: "AppFontStyle"),),
          Spacer(),
          _materialbutton.materialButton("Continuer", () {
            if(checkInStreamServices.currentlastUpdated["last_measure"] == null){
              _screenLoaders.functionLoader(context);
              _checkinServices.submit_measures(context).then((value){
                if(value != null){
                  _checkinServices.getUpdated().whenComplete(()async{
                    setState(() {
                      print("SELECTED"+CheckinServices.checkinSelected.toString());
                      if(!CheckinServices.checkinSelected.toString().contains("MES MESURES")){
                        CheckinServices.checkinSelected.add("MES MESURES");
                      }
                      if(value["last_measure"] != null){
                        _controllers[0].text = value["last_measure"]["neck"].toString();
                        _controllers[1].text = value["last_measure"]["shoulder"].toString();
                        _controllers[2].text = value["last_measure"]["chest"].toString();
                        _controllers[3].text = value["last_measure"]["upper_arm"].toString();
                        _controllers[4].text = value["last_measure"]["waist"].toString();
                        _controllers[5].text = value["last_measure"]["hips"].toString();
                        _controllers[6].text = value["last_measure"]["upper_thigh"].toString();
                        _controllers[7].text = value["last_measure"]["calf"].toString();
                      }else{
                        _controllers[0].text = "";
                        _controllers[1].text = "";
                        _controllers[2].text = "";
                        _controllers[3].text = "";
                        _controllers[4].text = "";
                        _controllers[5].text = "";
                        _controllers[6].text = "";
                        _controllers[7].text = "";
                      }
                    });
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("other_date", DateTime.now().toUtc().add(Duration(hours: 2)).toString());
                    prefs.setStringList("checkin", CheckinServices.checkinSelected.cast<String>());
                    Navigator.of(context).pop(null);
                    Navigator.of(context).pop(null);
                    print("MEASURES ${value.toString()}");
                    _snackbarMessage.snackbarMessage(context, message: "Mise à jour effectuée.");
                  });
                }else{
                  Navigator.of(context).pop(null);
                  _snackbarMessage.snackbarMessage(context, message: "Impossible de soumettre messurements. Veuillez réessayer !");
                }
              });
            }
          },bckgrndColor: AppColors.appmaincolor),
          SizedBox(
            height: 10,
          ),
          _materialbutton.materialButton("Annuler", () {
            Navigator.of(context).pop(null);
          },bckgrndColor: Colors.white,textColor: Colors.black),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
