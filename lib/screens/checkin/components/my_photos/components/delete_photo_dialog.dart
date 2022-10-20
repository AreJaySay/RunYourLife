import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/my_photos.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

class DeletePhotoDialog extends StatefulWidget {
  final Map details;
  DeletePhotoDialog({required this.details});
  @override
  _DeletePhotoDialogState createState() => _DeletePhotoDialogState();
}

class _DeletePhotoDialogState extends State<DeletePhotoDialog> {
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final CheckinServices _checkinServices = new CheckinServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white.withOpacity(0.4),
        child: Center(
          child: Container(
            width: 350,
            height: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Stack(
              children: [
                Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/important_assets/heart_icon.png"),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text("ETES-VOUS SÛR DE VOULOIR SUPPRIMER CETTE PHOTO ?",style: TextStyle(decoration: TextDecoration.none,fontSize: 20,color: AppColors.appmaincolor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),textAlign: TextAlign.center,),
                      Spacer(),
                      _materialbutton.materialButton("SUPPRIMER", () {
                        _screenLoaders.functionLoader(context);
                        _checkinServices.remove_photo(context, id: widget.details["id"].toString()).whenComplete((){
                          Navigator.of(context).pop(null);
                          Navigator.of(context).pop(null);
                          _routes.navigator_pushreplacement(context, MyPhotos(), transitionType: PageTransitionType.leftToRightWithFade);
                          _snackbarMessage.snackbarMessage(context, message: "La photo a été supprimée.", is_error: true);
                        });
                      }),
                      SizedBox(
                        height: 15,
                      ),
                      _materialbutton.materialButton("ANNULER", () {
                        Navigator.of(context).pop(null);
                      },bckgrndColor: Colors.white,textColor:  AppColors.darpinkColor),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
