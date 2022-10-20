import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/palettes/app_colors.dart';

class MyRessourcesImages extends StatefulWidget {
  final List images;
  MyRessourcesImages({required this.images});
  @override
  _MyRessourcesImagesState createState() => _MyRessourcesImagesState();
}

class _MyRessourcesImagesState extends State<MyRessourcesImages> {
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return widget.images.isEmpty ?
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      child: NoDataFound(firstString: "C'EST ", secondString: "CALME PAR ICI...", thirdString: "Il n'y a encore rien à trouver ici !",),
    ) : ListView.builder(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
      itemCount: widget.images.length,
      itemBuilder: (context, index){
        return Container(
          width: double.infinity,
          height: 100,
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Container(
                height: DeviceModel.isMobile ? 120 : 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:  NetworkImage("https://api.runyourlife.checkmy.dev/documents/coach/${widget.images[index]["documents"]["coach_id"].toString()}/${widget.images[index]["documents"]["file_path"]}")
                    )
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.images[index]["documents"]["file_name"].toString().toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      SizedBox(
                        height: 5,
                      ),
                      Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.images[index]["documents"]["created_at"].toString())),style: TextStyle(color: AppColors.pinkColor,fontSize: 12,fontFamily: "AppFontStyle"),),
                      // Text("0 commentaires",style: TextStyle(color: Colors.grey,fontSize: 12,fontFamily: "AppFontStyle"),),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                            child: Text(widget.images[index]["documents"]["file_type"] == "image/jpeg" ? "Image" : widget.images[index]["documents"]["file_type"] == "video/mp4" ? "Vidéo" : "Lien",style: TextStyle(color: Colors.white,fontSize: 14.5,fontFamily: "AppFontStyle"),),
                            decoration: BoxDecoration(
                                color: AppColors.pinkColor,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          widget.images[index]["documents"]["file_type"] == "application/pdf" ? Container(
                            child: Text("Read",style: TextStyle(color: Colors.white,fontSize: 14.5,fontFamily: "AppFontStyle"),),
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(3)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          ) : Container()
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}