import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/checkin/measures.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/textfields.dart';

class MyMeasurements extends StatefulWidget {
  @override
  _MyMeasurementsState createState() => _MyMeasurementsState();
}

class _MyMeasurementsState extends State<MyMeasurements> {
  final AppBars _appBars = new AppBars();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final CheckinServices _checkinServices = new CheckinServices();
  final Materialbutton _materialbutton = new Materialbutton();
  List _bodyparts = ["Cou","Epaules","Poitrine","Haut du bras","Taille","Hanches","Haut de cuisse","Mollet"];
  List<TextEditingController> _controllers = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: _appBars.whiteappbar(context, title: "MES MESURES"),
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
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                children: [
                  for(var x = 0; x < _bodyparts.length; x++)...{
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
                    },inputType: TextInputType.number,),
                    SizedBox(
                      height: 15,
                    )
                  },
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CONSEIL DU COACH",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Regardez bien ce schéma pour être régulier sur la manière de prendre vos mesures.",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                         width: double.infinity,
                         height: 50,
                         decoration: BoxDecoration(
                           border: Border.all(color: AppColors.pinkColor),
                           borderRadius: BorderRadius.circular(1000)
                         ),
                         child: Center(child: Text("SCHÉMA",style: TextStyle(color: AppColors.pinkColor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  _materialbutton.materialButton("VALIDER", () {
                    if(_controllers[0].text.isEmpty && _controllers[1].text.isEmpty && _controllers[2].text.isEmpty && _controllers[3].text.isEmpty && _controllers[4].text.isEmpty && _controllers[5].text.isEmpty && _controllers[6].text.isEmpty && _controllers[7].text.isEmpty){
                      _snackbarMessage.snackbarMessage(context, message: "Effectuez d'abord quelques modifications pour continue !", is_error: true);
                    }else{
                      _screenLoaders.functionLoader(context);
                      _checkinServices.submit_measures(context).then((value){
                        if(value != null){
                          _checkinServices.getUpdated().whenComplete((){
                            Navigator.of(context).pop(null);
                            Navigator.of(context).pop(null);
                            print("MEASURES ${value.toString()}");
                            _snackbarMessage.snackbarMessage(context, message: "De nouvelles mesures ont été soumises !");
                          });
                        }else{
                          Navigator.of(context).pop(null);
                          _snackbarMessage.snackbarMessage(context, message: "Impossible de soumettre messurements. Veuillez réessayer !");
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
