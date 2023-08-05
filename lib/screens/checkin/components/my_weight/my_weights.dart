import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/screens/checkin.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:run_your_life/widgets/textfields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWeights extends StatefulWidget {
  @override
  _MyWeightsState createState() => _MyWeightsState();
}

class _MyWeightsState extends State<MyWeights> {
  final TextEditingController _weight = new TextEditingController();
  final Materialbutton _materialbutton = new Materialbutton();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final CheckinServices _checkinServices = new CheckinServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final AppBars _appBars = new AppBars();
  bool _keyboardVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KeyboardVisibilityController().onChange.listen((event) {
      Future.delayed(Duration(milliseconds:  100), () {
        setState(() {
          _keyboardVisible = event;
        });
      });
    });
    _checkinServices.getUpdated().then((value){
      if(value != null){
        setState(() {
          _weight.text = value["last_weight"] == "" || value["last_weight"].toString() == "null" ? "" :value["last_weight"]["weight"].toString();
        });
      }else{
        _weight.text = "";
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
        appBar: _appBars.whiteappbar(context, title: "MON POIDS"),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Image(
                width: double.infinity,
                fit: BoxFit.cover,
                image: AssetImage("assets/important_assets/heart_icon.png"),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
                child: Column(
                    children: [
                      TextFields(_weight, hintText: "Entrer le poids", inputType: TextInputType.numberWithOptions(decimal: true)),
                      SizedBox(
                        height: 50,
                      ),
                      _keyboardVisible ? Container() :
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CONSEIL DU COACH",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("L'idéal est de se peser toujours au même moment de la journée, à jeun le matin par exemple. ",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),)
                          ],
                        ),
                      ),
                      Spacer(),
                      _materialbutton.materialButton("VALIDER", (){
                        print(_weight.text);
                        if(_weight.text.isEmpty){
                          _snackbarMessage.snackbarMessage(context, message: "Veuillez entrer votre poids.", is_error: true);
                        }else{
                          _screenLoaders.functionLoader(context);
                          _checkinServices.submit_weight(context, weight: _weight.text).then((value){
                            if(value != null){
                              _checkinServices.getUpdated().whenComplete(()async{
                                setState(() {
                                  if(!CheckinServices.checkinSelected.toString().contains("MON POIDS")){
                                    CheckinServices.checkinSelected.add('MON POIDS');
                                  }
                                });
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("poid_date", DateTime.now().toUtc().add(Duration(hours: 2)).next(DateTime.monday).toString());
                                prefs.setStringList("checkin", CheckinServices.checkinSelected.cast<String>());
                                Navigator.of(context).pop(null);
                                Navigator.of(context).pop(null);
                              });
                            }
                          });
                        }
                      },bckgrndColor: AppColors.appmaincolor),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return this.add(
      Duration(
        days: (day - this.weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}