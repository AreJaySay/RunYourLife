import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/delete_photo_dialog.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:intl/intl.dart';

class ViewPhoto extends StatefulWidget {
  final Map details;
  final bool is_share;
  ViewPhoto(this.details,{required this.is_share});
  @override
  _ViewPhotoState createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  final AppBars _appBars = AppBars();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.whiteappbar(context, title: "TITRE DE LA PHOTO"),
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
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: DeviceModel.isMobile ? 210 : 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage("https://api.runyourlife.fr/images/clients/${Auth.loggedUser!['id'].toString()}/${widget.details["file_name"]}")
                      )
                    ),
                  ),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Image(
                          image: NetworkImage("https://api.runyourlife.fr/images/clients/${Auth.loggedUser!['id'].toString()}/${widget.details["file_name"]}")
                        ),
                      )
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Text(widget.details['title'] == null ? "--" : widget.details['title'],style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 5,
                ),
                Text(widget.details['description'] == null ? "--" : widget.details['description'],style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
                SizedBox(
                  height: 5,
                ),
                Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.details['created_at'].toString())),style: TextStyle(color: Colors.grey,fontSize: 13,fontFamily: "AppFontStyle"),),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("COMMENTAIRE DU COACH",style: TextStyle(color: AppColors.appmaincolor,fontSize: 15,fontWeight: FontWeight.w700,fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 15,
                      ),
                      if(widget.details['comment'].isEmpty)...{
                       Text("--")
                      }else...{
                        for(int x = 0; x < widget.details['comment'].length; x++)...{
                          Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.details['created_at'].toString())),style: TextStyle(color: Colors.grey,fontSize: 13,fontFamily: "AppFontStyle"),),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.details['comment'][x]["text"],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                          SizedBox(
                            height: 15,
                          ),
                        }
                      }
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.appmaincolor,width: 1.5),
                          borderRadius: BorderRadius.circular(1000)
                      ),
                      child: Center(
                        child: Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            color: widget.details['sharable'] == 1 ? AppColors.appmaincolor : Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Partager avec le coach",style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (_) => DeletePhotoDialog(details: widget.details,),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    child: Center(child: Text("SUPPRIMER LA PHOTO",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600,fontSize: 15),)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
