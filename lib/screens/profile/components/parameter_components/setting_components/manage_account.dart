import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/setting_components/upload_profile_pict.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/image_picker.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/textfields.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:intl/intl.dart';

class EditInformation extends StatefulWidget {

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  final AppBars _appBars = new AppBars();
  final List<String> _fields = ["Nom","Prénom","Numéro de téléphone","Adresse","Adresse mail"];
  final List<String> _myinfos = [Auth.loggedUser!["first_name"].toString(),Auth.loggedUser!["last_name"].toString(),Auth.loggedUser!["phone_1"].toString(),Auth.loggedUser!["address_1"].toString(),Auth.loggedUser!["email"].toString(), Auth.pass!];
  final Materialbutton _materialbutton = new Materialbutton();
  final CredentialsServices _credentialsServices = new CredentialsServices();
  final Routes _routes = new Routes();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  String _selected = "";
  final List<TextEditingController> _controllers = [
    TextEditingController()..text=Auth.loggedUser!["first_name"].toString() == "null" ? "" : Auth.loggedUser!["first_name"].toString(),
    TextEditingController()..text=Auth.loggedUser!["last_name"].toString() == "null" ? "" : Auth.loggedUser!["last_name"].toString(),
    TextEditingController()..text=Auth.loggedUser!["phone_1"].toString() == "null" ? "" : Auth.loggedUser!["phone_1"].toString(),
    TextEditingController()..text=Auth.loggedUser!["address_1"].toString() == "null" ? "" : Auth.loggedUser!["address_1"].toString(),
    TextEditingController()..text=Auth.loggedUser!["email"].toString() == "null" ? "" : Auth.loggedUser!["email"].toString(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.first_name = Auth.loggedUser!["first_name"].toString();
    auth.last_name = Auth.loggedUser!["last_name"].toString();
    auth.phone_1 = Auth.loggedUser!["phone_1"].toString();
    auth.address_1 = Auth.loggedUser!["address_1"].toString();
    auth.email2 = Auth.loggedUser!["email"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: _appBars.whiteappbar(context, title: "Paramètres".toUpperCase(),isprofile: true),
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          children: [
            Text("Informations personnelles",style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontSize: 17,fontWeight: FontWeight.bold)),
            SizedBox(
              height: 30,
            ),
            ZoomTapAnimation(
              end: 0.99,
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Photo de profil".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle")),
                ),
              ),
              onTap: ()async{
               await showModalBottomSheet(
                    context: context, builder: (context){
                  return ImagePicker();
                }).then((value)async{
                  setState((){
                    Uint8List bytes = File(value.path).readAsBytesSync();
                    auth.base64Image = "data:image/jpeg;base64,"+base64Encode(bytes);
                  });
                  _routes.navigator_push(context, UploadPhoto(photo: value));
               });
              },
            ),
            SizedBox(
              height: 25,
            ),
            for(int x = 0;x < _fields.length;x++)...{
              TextFields(_controllers[x],hintText: _fields[x],onChanged: (text){
                if(x == 0){
                  auth.first_name = text;
                }else if(x == 1){
                  auth.last_name = text;
                }else if(x == 2){
                  auth.phone_1 = text;
                }else if(x == 3){
                  auth.address_1 = text;
                }else if(x == 4){
                  auth.email2 = text;
                }else{
                  Auth.pass = text;
                }
              },),
              SizedBox(
                height: 15,
              )
            },
            SizedBox(
              height: 40,
            ),
            _materialbutton.materialButton("ENREGISTRER", () {
              print(auth.toMap());
              _screenLoaders.functionLoader(context);
              _credentialsServices.editaccount(context, isPhoto: false).then((value){
                if(value != null){
                  _snackbarMessage.snackbarMessage(context, message: "Mise à jour effectuée.");
                }
              });
            }),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}