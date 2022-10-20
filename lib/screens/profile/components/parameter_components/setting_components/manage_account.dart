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
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:intl/intl.dart';

class EditInformation extends StatefulWidget {

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  final AppBars _appBars = new AppBars();
  final List<String> _fields = ["Nom","Prénom","Numéro de téléphone","Address","Adresse mail","Mot de passe"];
  final List<String> _myinfos = [Auth.loggedUser!["first_name"].toString(),Auth.loggedUser!["last_name"].toString(),Auth.loggedUser!["phone_1"].toString(),Auth.loggedUser!["address_1"].toString(),Auth.loggedUser!["email"].toString(), Auth.pass!];
  final Materialbutton _materialbutton = new Materialbutton();
  final CredentialsServices _credentialsServices = new CredentialsServices();
  final Routes _routes = new Routes();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  String _selected = "";
  final List<TextEditingController> _controllers = [
    TextEditingController()..text=Auth.loggedUser!["first_name"].toString(),
    TextEditingController()..text=Auth.loggedUser!["last_name"].toString(),
    TextEditingController()..text=Auth.loggedUser!["phone_1"].toString(),
    TextEditingController()..text=Auth.loggedUser!["address_1"].toString(),
    TextEditingController()..text=Auth.loggedUser!["email"].toString(),
    TextEditingController()
  ];

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
                  child: Text("UPLOAD PROFILE PHOTO",style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle")),
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
              height: 15,
            ),
            for(int x = 0;x < _fields.length;x++)...{
              EditTextFields(title: _fields[x], myinfos: _myinfos[x],selected: _selected,controller: _controllers[x],action: (){
                setState((){
                  _selected = _fields[x];
                  print(_selected);
                });
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
              _credentialsServices.editaccount(context, isPhoto: false);
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

class EditTextFields extends StatefulWidget {
  String title,myinfos,selected;
  final TextEditingController controller;
  final VoidCallback action;
  EditTextFields({required this.title, required this.myinfos ,required this.selected, required this.controller, required this.action});
  @override
  State<EditTextFields> createState() => _EditTextFieldsState();
}

class _EditTextFieldsState extends State<EditTextFields> {
  final Materialbutton _materialbutton = new Materialbutton();
  bool _isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.title == "Nom"){
      auth.first_name = widget.myinfos;
    }else if(widget.title == "Prénom"){
      auth.last_name =  widget.myinfos;
    }else if(widget.title == "Numéro de téléphone"){
      auth.phone_1 =  widget.myinfos;
    }else if(widget.title == "Address"){
      auth.address_1 =  widget.myinfos;
    }else if(widget.title == "Adresse mail"){
      auth.email2 =  widget.myinfos;
    }else{
      Auth.pass = Auth.pass;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.selected == widget.title ?
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 70,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.appmaincolor)
          ),
          child: TextField(
            style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),
            controller: widget.controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey[400],fontFamily: "AppFontStyle"),
              prefixText: "${widget.title}:   ",
            ),
            onChanged: (text){
              setState((){
                if(widget.title == "Nom"){
                  auth.first_name = text;
                }else if(widget.title == "Prénom"){
                  auth.last_name = text;
                }else if(widget.title == "Numéro de téléphone"){
                  auth.phone_1 = text;
                }else if(widget.title == "Address"){
                  auth.address_1 = text;
                }else if(widget.title == "Adresse mail"){
                  auth.email2 = text;
                }else{
                  Auth.pass = widget.controller.text.isEmpty ? Auth.pass : text;
                }
              });
            },
          )  ,
        ) : Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),),
                    SizedBox(
                      height: 3,
                    ),
                    Text(widget.myinfos.toString() == "null" ? "--" : widget.title == "Mot de passe" ? widget.myinfos.replaceAll(RegExp(r"."), "*") : widget.myinfos,style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
                  ],
                ),
              ),
              ZoomTapAnimation(
                end: 0.99,
                child: Image(
                  width: 23,
                  color: Colors.grey,
                  image: AssetImage("assets/icons/editform.png"),
                ),
                onTap: widget.action
              ),
            ],
          ),
        ),
        widget.selected == widget.title  ? Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  child: _materialbutton.materialButton("VALIDER", () {
                    setState((){
                      widget.myinfos = widget.controller.text;
                      widget.selected = "";
                    });
                  }),
                ),
              ),
              Expanded(
                child: InkWell(
                    onTap: (){
                      setState((){
                        if( widget.myinfos != "null"){
                          widget.controller.text = widget.myinfos;
                        }
                        widget.selected = "";
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      child: Center(child: Text("ANNULER",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600,fontSize: 15),)),
                    )
                ),
              ),
            ],
          ),
        ) : Container()
      ],
    );
  }
}

