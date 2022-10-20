import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/screens/checkin/photos.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/textfields.dart';

class AddPhotoTag extends StatefulWidget {
  @override
  State<AddPhotoTag> createState() => _AddPhotoTagState();
}

class _AddPhotoTagState extends State<AddPhotoTag> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final CheckinServices _checkinServices = new CheckinServices();
  final Materialbutton _materialbutton = new Materialbutton();
  TextEditingController _title = new TextEditingController();
  TextEditingController _desc = new TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: _keyboardVisible ? double.infinity : 420,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text("Ajouter une balise photo".toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",fontSize: 17,color: AppColors.appmaincolor,fontWeight: FontWeight.w600),),
          SizedBox(
            height: 20,
          ),
          TextFields(_title,hintText: "Titre de la photo",onChanged: (text){
            setState((){
              photos.title = text;
            });
          },),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: _desc,
            maxLines: 4,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              border: InputBorder.none,
              hintText: "Commentaire...",
              hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.appmaincolor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (text){
              setState((){
                photos.description = text;
              });
            },
          ),
          SizedBox(
            height: 40,
          ),
          _materialbutton.materialButton("AJOUTER", () {
            if(_title.text.isEmpty){
              _snackbarMessage.snackbarMessage(context, message: "Title is required !", is_error: true);
            }else if(_desc.text.isEmpty){
              _snackbarMessage.snackbarMessage(context, message: "Description is required !", is_error: true);
            }else{
              _screenLoaders.functionLoader(context);
              _checkinServices.addPhotoTag(context, name: _title.text, desc: _desc.text);
            }
          }),
          SizedBox(
            height: 20,
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
    );
  }
}
