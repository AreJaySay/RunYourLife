import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/backbutton.dart';

import '../models/auths_model.dart';

class ImagePicker extends StatefulWidget {
  final bool is_change;
  final String image;
  ImagePicker({this.is_change = false,this.image = ""});
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      enableCloseButton: true,
      closeIcon: Icon(
        Icons.close,
        color: Colors.red,
        size: 12,
      ),
      context: context,
      source: source,
      barrierDismissible: true,
    );
    setState(() {
      Navigator.of(context).pop(File(image.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.is_change ? 250 : 180,
      padding: EdgeInsets.only(top: 30,left: 20,right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      child: Column(
        children: [
          widget.is_change ? GestureDetector(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.pinkColor
                  )
              ),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.image_rounded,color: AppColors.pinkColor,size: 27,),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Voir la photo de profil",style: TextStyle(fontFamily: "OpenSans-medium",fontSize: 15.5,color: AppColors.pinkColor,))
                ],
              ),
            ),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context) => Material(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.image)
                              )
                          ),
                        ),
                        PageBackButton()
                      ],
                    ),
                  ),
              );
            },
          ) : Container(),
          SizedBox(
            height:  widget.is_change ? 15 : 0,
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.appmaincolor,
                  borderRadius: BorderRadius.circular(50)
              ),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt_outlined,color: Colors.white,),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Prendre une photo",style: TextStyle(fontFamily: "OpenSans-medium",color: Colors.white,fontSize: 15.5),)
                ],
              ),
            ),
            onTap: (){
              getImage(ImgSource.Camera);
            },
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.appmaincolor
                  )
              ),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.image_outlined,color: AppColors.appmaincolor,size: 27,),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Choisir depuis la galerie",style: TextStyle(fontFamily: "OpenSans-medium",fontSize: 15.5,color: AppColors.appmaincolor,))
                ],
              ),
            ),
            onTap: (){
              setState(() {
                getImage(ImgSource.Gallery);
              });
            },
          ),
        ],
      ),
    );
  }
}
