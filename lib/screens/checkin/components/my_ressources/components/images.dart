import 'package:flutter/material.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/screens/checkin/components/my_ressources/components/components/view_ressources.dart';
import 'package:run_your_life/services/landing_page_services/objective_service.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../services/apis_services/screens/checkin.dart';
import '../../../../../services/apis_services/screens/objective.dart';
import '../../../../../utils/palettes/app_colors.dart';
import '../../../../../widgets/materialbutton.dart';

class MyRessourcesImages extends StatefulWidget {
  final List images;
  MyRessourcesImages({required this.images});
  @override
  _MyRessourcesImagesState createState() => _MyRessourcesImagesState();
}

class _MyRessourcesImagesState extends State<MyRessourcesImages> with WidgetsBindingObserver, ObjectiveService {
  final ObjectiveServices _objectiveServices = new ObjectiveServices();
  final CheckinServices _checkinServices = new CheckinServices();
  final Materialbutton _materialButton = new Materialbutton();

  void init() async {
    await fetchObjectiveAndPopulate();
  }

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
        return ZoomTapAnimation(
          end: 0.99,
          onTap: (){
            showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return ViewRessources(ressource: widget.images[index],);
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
                          value: widget.images[index]["status"] == 1,
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
                              widget.images[index]["status"] = widget.images[index]["status"] == 0 ? 1 : 0;
                            });
                            _checkinServices.docStatus(id: widget.images[index]["id"].toString(), status:widget.images[index]["status"].toString(), isProgrammation: widget.images[index].toString().contains("programmation") ? true : false).then((value){
                              init();
                            });
                          },
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: widget.images[index]["status"] == 0 ? Colors.grey : AppColors.pinkColor ,width: 2),
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
                  height: DeviceModel.isMobile ? 120 : 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  NetworkImage(widget.images[index][widget.images[index].toString().contains("programmation") ? "programmation" : "documents"]["file_path"])
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
                        Text(widget.images[index][widget.images[index].toString().contains("programmation") ? "programmation" : "documents"]["file_name"].toString().toUpperCase(),style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,),
                        SizedBox(
                          height: 5,
                        ),
                        Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.images[index][widget.images[index].toString().contains("programmation") ? "programmation" : "documents"]["created_at"].toString())),style: TextStyle(color: AppColors.pinkColor,fontSize: 12,fontFamily: "AppFontStyle"),),
                        // Text("0 commentaires",style: TextStyle(color: Colors.grey,fontSize: 12,fontFamily: "AppFontStyle"),),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              child: Text("Image",style: TextStyle(color: Colors.white,fontSize: 14.5,fontFamily: "AppFontStyle"),),
                              decoration: BoxDecoration(
                                  color: AppColors.pinkColor,
                                  borderRadius: BorderRadius.circular(3)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            widget.images[index][widget.images[index].toString().contains("programmation") ? "programmation" : "documents"]["file_type"] == "application/pdf" ? Container(
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