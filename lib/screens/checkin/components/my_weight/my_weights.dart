import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:run_your_life/widgets/textfields.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkinServices.getUpdated().then((value){
      if(value != null){
        setState(() {
          _weight.text = value["last_weight"]["weight"].toString();
        });
      }else{
        _weight.text = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    TextFields(_weight, hintText: "Entrer le poids", inputType: TextInputType.number,),
                    SizedBox(
                      height: 50,
                    ),
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
                    _materialbutton.materialButton("VALIDER", () {
                      if(_weight.text.isEmpty){
                        _snackbarMessage.snackbarMessage(context, message: "Veuillez entrer votre poids.", is_error: true);
                      }else{
                        _screenLoaders.functionLoader(context);
                        _checkinServices.submit_weight(context, weight: _weight.text).then((value){
                          if(value != null){
                            _checkinServices.getUpdated().whenComplete((){
                              Navigator.of(context).pop(null);
                              Navigator.of(context).pop(null);
                            });
                          }
                        });
                      }
                    }),
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
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
