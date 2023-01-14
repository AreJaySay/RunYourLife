import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/profile/components/parameters.dart';
import 'package:run_your_life/services/stream_services/screens/profile.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/image_picker.dart';
import '../../../services/other_services/routes.dart';
import 'parameter_components/setting_components/upload_profile_pict.dart';

class ProfileAppBar extends StatefulWidget {
  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: profileStreamServices.subject,
      builder: (context, snapshot) {
        return !snapshot.hasData ? Container( ): Container(
          height: 110,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 8.0,
                spreadRadius: 0.0,
                offset: Offset(
                  0,
                  2,
                ),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              snapshot.data!["logo"] == "" ?
              GestureDetector(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      border: Border.all(color: AppColors.appmaincolor,width: 4.5)
                  ),
                  child: Center(
                    child: Icon(Icons.camera_alt,size: 30,color: AppColors.appmaincolor),
                  )),
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
              ) :
              GestureDetector(
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(1000),
                    border: Border.all(color: AppColors.appmaincolor,width: 3),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(snapshot.data!["logo"])
                    )
                  ),
                ),
                onTap: ()async{
                  await showModalBottomSheet(
                      context: context, builder: (context){
                    return ImagePicker(is_change: true, image: snapshot.data!["logo"]);
                  }).then((value)async{
                    setState((){
                      Uint8List bytes = File(value.path).readAsBytesSync();
                      auth.base64Image = "data:image/jpeg;base64,"+base64Encode(bytes);
                    });
                    _routes.navigator_push(context, UploadPhoto(photo: value,));
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: Auth.isNotSubs! ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text("${snapshot.data!["first_name"].toString() == "null" ? "" : snapshot.data!["first_name"].toString().toUpperCase()} ${snapshot.data!["last_name"].toString() == "null" ? "" : snapshot.data!["last_name"].toString().toUpperCase()}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    Auth.isNotSubs! || subscriptionDetails.currentdata[0]["price"].toString() == "null" ?
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text("Non abonné"),
                    ) :
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? Container() :
                          Image(
                            color: AppColors.appmaincolor,
                            width: 20,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            image:AssetImage("assets/icons/coaching.png",)
                          ),
                          subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? Container() : SizedBox(
                            width: 3,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("PACK ${subscriptionDetails.currentdata[0]["price"]["plan"]["name"].toString()}".toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontSize: 13.5,fontFamily: "AppFontStyle",),),
                              Text(subscriptionDetails.currentdata[0]["coach"]["full_name"].toString(),style: TextStyle(fontWeight: FontWeight.w600,color: AppColors.appmaincolor,fontSize: 13.5,fontFamily: "AppFontStyle",),)
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
