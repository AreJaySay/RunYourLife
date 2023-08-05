import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/components/components/view_ressources.dart';
import 'package:run_your_life/services/apis_services/screens/objective.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../services/apis_services/screens/checkin.dart';
import '../../../../../services/landing_page_services/objective_service.dart';
import '../../../../../utils/palettes/app_colors.dart';
import '../../../../../widgets/materialbutton.dart';

class MyRessourcesVideos extends StatefulWidget {
  final List videos;
  MyRessourcesVideos({required this.videos});
  @override
  _MyRessourcesVideosState createState() => _MyRessourcesVideosState();
}

class _MyRessourcesVideosState extends State<MyRessourcesVideos>{
  final ObjectiveServices _objectiveServices = new ObjectiveServices();
  final CheckinServices _checkinServices = new CheckinServices();
  final Materialbutton _materialButton = new Materialbutton();

  @override
  Widget build(BuildContext context) {
    return widget.videos.isEmpty ?
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      child: NoDataFound(firstString: "C'EST ", secondString: "CALME PAR ICI...", thirdString: "Il n'y a encore rien à trouver ici !",),
    ) : ListView.builder(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
      itemCount: widget.videos.length,
      itemBuilder: (context, index){
        return ZoomTapAnimation(
          end: 0.99,
          onTap: (){
            showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ViewRessources(ressource: widget.videos[index],);
                });
          },
          child: Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                    child: Transform.scale(
                      scale: 1,
                      child: SizedBox(
                        width: 23,
                        height: 23,
                        child: Checkbox(
                          checkColor: AppColors.pinkColor,
                          activeColor: Colors.white,
                          value: widget.videos[index]["status"] == 1,
                          shape: CircleBorder(
                              side: BorderSide.none
                          ),
                          splashRadius: 20,
                          side: BorderSide(
                              width: 0,
                              color: Colors.transparent,
                              style: BorderStyle.none
                          ),
                          onChanged: (value) {
                            setState(() {
                              widget.videos[index]["status"] = widget.videos[index]["status"] == 0 ? 1 : 0;
                            });
                            _checkinServices.docStatus(id: widget.videos[index]["id"].toString(), status:widget.videos[index]["status"].toString(), isProgrammation: widget.videos[index].toString().contains("programmation") ? true : false).then((value){

                            });
                          },
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: widget.videos[index]["status"] == 0 ? Colors.grey : AppColors.pinkColor ,width: 2),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    padding: EdgeInsets.all(3),
                  ),
                  onTap: (){

                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 150,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image(
                    width: 20,
                    color: AppColors.appmaincolor,
                    image: AssetImage("assets/icons/video_file.png"),
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
                        Text(widget.videos[index][widget.videos[index].toString().contains("programmation") ? "programmation" : "documents"]["file_name"].toString().toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.videos[index][widget.videos[index].toString().contains("programmation") ? "programmation" : "documents"]["created_at"].toString())),style: TextStyle(color: AppColors.pinkColor,fontSize: 12,fontFamily: "AppFontStyle"),),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              child: Text("Vidéo",style: TextStyle(color: Colors.white,fontSize: 14.5,fontFamily: "AppFontStyle"),),
                              decoration: BoxDecoration(
                                  color: AppColors.pinkColor,
                                  borderRadius: BorderRadius.circular(3)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            widget.videos[index][widget.videos[index].toString().contains("programmation") ? "programmation" : "documents"]["file_type"] == "application/pdf" ? Container(
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
          ),
        );
      },
    );
  }
}
