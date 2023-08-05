import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/checkin/photos.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/add_photo_components/components/add_tag.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/add_photo_components/components/dialog_box.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/add_photo_components/components/tags_shimmer_loader.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/stream_services/screens/checkin.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/textfields.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DescribePhoto extends StatefulWidget {
  final File photo;
  DescribePhoto(this.photo);
  @override
  _DescribePhotoState createState() => _DescribePhotoState();
}

class _DescribePhotoState extends State<DescribePhoto> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final CheckinServices _checkinServices = new CheckinServices();
  final Materialbutton _materialbutton = new Materialbutton();
  final AppBars _appBars = AppBars();
  bool _isShare = false;
  TextEditingController _title = new TextEditingController();
  TextEditingController _desc = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkinServices.getPhotoTags(context);
    Uint8List bytes = File(widget.photo.path).readAsBytesSync();
    photos.image = "data:image/jpeg;base64,"+base64Encode(bytes);
    photos.sharable = "0";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: StreamBuilder<List>(
        stream: checkInStreamServices.tags,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: _appBars.whiteappbar(context, title: "DÉCRIVEZ VOTRE PHOTO"),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: ListView(
                padding: EdgeInsets.only(top: 25,bottom: 50),
                children: [
                  Container(
                    width: double.infinity,
                    height: DeviceModel.isMobile ? 220 : 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(widget.photo.path)),
                      )
                    ),
                  ),
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
                        borderSide: const BorderSide(color: AppColors.appmaincolor),
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
                  !snapshot.hasData ?
                  AddPhotosShimmerLoader() :
                  GridView.count(
                    padding: EdgeInsets.only(left: 5,right: 5,bottom: 25,top: 20),
                    primary: false,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: DeviceModel.isMobile ? 3 : 4,
                    childAspectRatio: (1 / .3),
                    children: <Widget>[
                      for(var x = 0; x < snapshot.data!.length; x++)...{
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                color: photos.taggable.contains(snapshot.data![x]["id"].toString()) ? AppColors.appmaincolor : Colors.white,
                                border: Border.all(color: photos.taggable.contains(snapshot.data![x]["id"].toString()) ? Colors.transparent : Colors.grey),
                                borderRadius: BorderRadius.circular(1000)
                            ),
                            child: Center(child: Text("#"+snapshot.data![x]["name"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: photos.taggable.contains(snapshot.data![x]["id"].toString()) ? Colors.white : Colors.black,fontFamily: "AppFontStyle"),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                          ),
                          onTap: (){
                            setState(() {
                              if(photos.taggable.contains(snapshot.data![x]["id"].toString())){
                                photos.taggable.remove(snapshot.data![x]["id"].toString());
                              }else{
                                photos.taggable.add(snapshot.data![x]["id"].toString());
                              }
                            });
                          },
                        )
                      },
                      ZoomTapAnimation(
                        end: 0.99,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.pinkColor,
                              borderRadius: BorderRadius.circular(1000)
                          ),
                          child: Icon(Icons.add,color: Colors.white,),
                        ),
                        onTap: (){
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                            isScrollControlled: true,
                            context: context, builder: (context){
                            return AddPhotoTag();
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: _isShare? Icon(Icons.radio_button_checked,color: AppColors.appmaincolor) : Icon(Icons.radio_button_off,color: AppColors.appmaincolor,),
                          onPressed: (){
                            setState((){
                              _isShare = !_isShare;
                              photos.sharable = _isShare ? "1" : "0";
                            });
                          },
                        ),
                        Text("Partager avec mon coach",style: TextStyle(fontFamily: "AppFontStyle"),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _materialbutton.materialButton("AJOUTER", () {
                    if(_title.text.isEmpty){
                      _snackbarMessage.snackbarMessage(context, message: "Le titre de la photo ne peut pas être vide !", is_error: true);
                    }else if(_desc.text.isEmpty){
                      _snackbarMessage.snackbarMessage(context, message: "La description de la photo ne peut pas être vide !", is_error: true);
                    }else{
                      _screenLoaders.functionLoader(context);
                      _checkinServices.addPhoto(context).then((value){
                        if(value != null){
                          _checkinServices.getUpdated().whenComplete((){
                            _checkinServices.getPhotos(context).whenComplete((){
                              Navigator.of(context).pop(null);
                              Navigator.of(context).pop(null);
                              photos.taggable.clear();
                              Navigator.of(context).pop();
                              _snackbarMessage.snackbarMessage(context, message: "Les détails de la photo ont été enregistrés avec succès !");
                             });
                          });
                        }else{
                          Navigator.of(context).pop(null);
                          _snackbarMessage.snackbarMessage(context, message: "Une erreur s'est produite. Veuillez réessayer !");
                        }
                      });
                    }
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child:  Container(
                      width: double.infinity,
                      height: 55,
                      child: Center(
                        child: Text("ANNULER",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600),),
                      ),
                    ),
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (_) => AddPhotoDialogBox(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
