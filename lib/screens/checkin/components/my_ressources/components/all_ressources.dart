import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/components/components/view_ressources.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/components/videos_component/video_design.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../services/apis_services/screens/objective.dart';
import '../../../../../services/landing_page_services/objective_service.dart';

class AllRessources extends StatefulWidget {
  final List ressources;
  AllRessources({required this.ressources});
  @override
  _AllRessourcesState createState() => _AllRessourcesState();
}

class _AllRessourcesState extends State<AllRessources> with WidgetsBindingObserver, ObjectiveService {
  final ObjectiveServices _objectiveServices = new ObjectiveServices();

  void init() async {
    await fetchObjectiveAndPopulate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.ressources.isEmpty ?
     Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      child: NoDataFound(firstString: "C'EST ", secondString: "CALME PAR ICI...", thirdString: "Il n'y a encore rien à trouver ici !",),
     ) : ListView.builder(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 30),
      itemCount: widget.ressources.length,
      itemBuilder: (context, index){
        return ZoomTapAnimation(
          end: 0.99,
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
                          value: widget.ressources[index]["status"] == 1,
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
                              widget.ressources[index]["status"] = widget.ressources[index]["status"] == 0 ? 1 : 0;
                            });
                            _objectiveServices.changeStatus(id: widget.ressources[index]["id"].toString(), status:widget.ressources[index]["status"].toString(), isObjective: false).then((value){
                              init();
                            });
                          },
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: widget.ressources[index]["status"] == 0 ? Colors.grey : AppColors.pinkColor ,width: 2),
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
                widget.ressources[index]["programmation"]["file_type"] == "image/jpeg" || widget.ressources[index]["programmation"]["file_type"] == "image/png" || widget.ressources[index]["programmation"]["file_type"] == "image/jpg"?
                Container(
                  height: DeviceModel.isMobile ? 120 : 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  NetworkImage(widget.ressources[index]["programmation"]["file_path"])
                      )
                  ),
                ) : widget.ressources[index]["programmation"]["file_type"] == "video/mp4" ?
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
                ) :
                widget.ressources[index]["programmation"]["file_type"] == "link/url"?
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
                    image: AssetImage("assets/icons/url_file.png"),
                  ),
                ) :
                Container(
                  height: DeviceModel.isMobile ? 120 : 150,
                  width: 150,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image(
                    width: 20,
                    color: AppColors.appmaincolor,
                    image: AssetImage("assets/icons/pdf_file.png"),
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
                        Text(widget.ressources[index]["programmation"]["file_name"].toString().toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.ressources[index]["programmation"]["created_at"].toString())),style: TextStyle(color: AppColors.pinkColor,fontSize: 12,fontFamily: "AppFontStyle"),),
                        // Text("0 commentaires",style: TextStyle(color: Colors.grey,fontSize: 12,fontFamily: "AppFontStyle"),),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              child: Text(widget.ressources[index]["programmation"]["file_type"] == "image/jpeg" || widget.ressources[index]["programmation"]["file_type"] == "image/png" || widget.ressources[index]["programmation"]["file_type"] == "image/jpg" ? "Image" : widget.ressources[index]["programmation"]["file_type"] == "video/mp4" ? "Vidéo" : widget.ressources[index]["programmation"]["file_type"] == "link/url" ? "Lien" : "Docs",style: TextStyle(color: Colors.white,fontSize: 14.5,fontFamily: "AppFontStyle"),),
                              decoration: BoxDecoration(
                                color: AppColors.pinkColor,
                                borderRadius: BorderRadius.circular(3)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            widget.ressources[index]["programmation"]["file_type"] == "application/pdf" ?
                            Container(
                              child: Text("Lire",style: TextStyle(color: Colors.white,fontSize: 14.5,fontFamily: "AppFontStyle"),),
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
          onTap: (){
            print(widget.ressources[index]);
            showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ViewRessources(ressource: widget.ressources[index],isPdf: true,);
                });
            // _routes.navigator_push(context, ViewRessources());
          },
        );
      },
    );
  }
}
