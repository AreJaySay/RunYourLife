import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../../../../../models/auths_model.dart';
import '../../../../../widgets/image_picker.dart';

class UploadPhoto extends StatefulWidget {
  File photo;
  UploadPhoto({required this.photo});
  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  final Routes _routes = new Routes();
  final AppBars _appBars = new AppBars();
  final cropKey = GlobalKey<CropState>();
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final CredentialsServices _credentialsServices = new CredentialsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.whiteappbar(context, title: "Télécharger une photo de profil"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[300],
                child: Crop(
                  key: cropKey,
                  image: FileImage(widget.photo),
                  aspectRatio: 5.0 / 5.0,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 80,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 55,
                      child: _materialbutton.materialButton("Changer", () async{
                        await showModalBottomSheet(
                            context: context, builder: (context){
                          return ImagePicker();
                        }).then((value)async{
                        setState((){
                        Uint8List bytes = File(value.path).readAsBytesSync();
                         auth.base64Image = "data:image/jpeg;base64,"+base64Encode(bytes);
                         widget.photo = value;
                         });
                        });
                      },bckgrndColor: Colors.white,textColor: AppColors.pinkColor,radius: 10),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 55,
                      child: _materialbutton.materialButton("Enregistrer la photo", () {
                        _screenLoaders.functionLoader(context);
                        setState((){
                          auth.first_name = Auth.loggedUser!["first_name"];
                          auth.email2 = Auth.email.toString();
                        });
                        _credentialsServices.editaccount(context, isPhoto: true);
                      },radius: 10),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
