import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:run_your_life/data_component/objective_vm.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/screens/objective.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../../models/objective.dart';
import '../../../../../services/apis_services/screens/checkin.dart';
import '../../../../../services/landing_page_services/objective_service.dart';
import '../../../../../utils/palettes/app_colors.dart';
import '../../../../../utils/snackbars/snackbar_message.dart';
import '../../../../../widgets/no_data.dart';

class ObjectivesPage extends StatefulWidget {
  @override
  State<ObjectivesPage> createState() => _ObjectivesPageState();
}

class _ObjectivesPageState extends State<ObjectivesPage>{
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final CheckinServices _checkinServices = new CheckinServices();
  final ObjectiveServices _objectiveServices = new ObjectiveServices();
  late final ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    objectivesVM.update(data: true);
    objectivesVM.value.clear();
    _objectiveServices.get().then((objectives){
      if(objectives != null){
        setState(() {
          for(int x = 0; x < objectives["data"].length; x++){
            if(!objectivesVM.value.toString().contains(objectives["data"][x].toString())){
              objectivesVM.add(data: objectives["data"][x]);
            }
          }
        });
      }
      _objectiveServices.get_programmation().then((programmation){
        if(programmation != null){
          setState(() {
            for(int x = 0; x < programmation["data"].length; x++){
              if(!objectivesVM.value.toString().contains(programmation["data"][x].toString())){
                objectivesVM.add(data: programmation["data"][x]);
              }
            }
          });
          objectivesVM.update(data: false);
        }
      });
    });
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final double width = c.maxWidth;
        final double height = c.maxHeight;
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Image(
                width: double.infinity,
                fit: BoxFit.cover,
                image: AssetImage("assets/important_assets/heart_icon.png"),
              ),
              Positioned.fill(
                child: StreamBuilder<List>(
                  stream: objectivesVM.subject,
                  builder: (_, snapshot) {
                    return Scrollbar(
                      controller: _scrollController,
                      child: objectivesVM.currentLoader ?
                      Center(
                        child: CircularProgressIndicator(color: AppColors.appmaincolor,)
                      ) :
                      snapshot.data!.isEmpty ?
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                        child: NoDataFound(firstString: "AUCUN", secondString: "OBJECTIF TROUVÉ", thirdString: "Tu verras ici tous tes objectifs lorsque tu en auras."),
                      ) :
                      ListView.separated(
                        shrinkWrap: true,
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        itemBuilder: (_, index) =>
                            ZoomTapAnimation(
                              end: 0.99,
                              onTap: (){
                                print(snapshot.data![index]);
                              },
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
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
                                                value:  snapshot.data![index]["view_status"] == 1,
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
                                                  print(snapshot.data![index]);
                                                  setState(() {
                                                    snapshot.data![index]["view_status"] = snapshot.data![index]["view_status"] == 0 ? 1 : 0;
                                                  });
                                                  _objectiveServices.objStatus(id: snapshot.data![index]["id"].toString(), status: snapshot.data![index]["view_status"].toString() ,isProgrammation: snapshot.data![index].toString().contains("obj_programmation") ? true : false).then((value){

                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: snapshot.data![index]["view_status"] == 0 ? Colors.grey : AppColors.pinkColor ,width: 2),
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].toString().contains("obj_programmation") ? snapshot.data![index]["obj_programmation"]["title"] : snapshot.data![index]["objective"]["title"] ?? "Pas de titre", style: TextStyle(
                                              color: AppColors.appmaincolor,
                                              fontSize: 17.5,
                                              height: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            ),
                                            if (snapshot.data![index].toString().contains("obj_programmation") ? snapshot.data![index]["obj_programmation"] != null : snapshot.data![index]["objective"] != null) ...{
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                snapshot.data![index].toString().contains("obj_programmation") ?
                                                snapshot.data![index]["obj_programmation"]["programmation_description"] == null ?
                                                "Pas de description" : snapshot.data![index]["obj_programmation"]["programmation_description"] :

                                                snapshot.data![index]["objective"]["obj_description"] == null ?
                                                    "Pas de description": snapshot.data![index]["objective"]["obj_description"],
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  height: 1,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            },
                                            if (snapshot.data![index].toString().contains("obj_programmation") ? snapshot.data![index]["obj_programmation"] != null : snapshot.data![index]["objective"] != null &&
                                                snapshot.data![index].toString().contains("obj_programmation") ?
                                               snapshot.data![index]["obj_programmation"]["related_tags"]  !=
                                                null :
                                               snapshot.data![index]["objective"]["related_tags"] !=
                                                    null) ...{
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Chip(
                                                label: Text(
                                                  snapshot.data![index].toString().contains("obj_programmation") ?
                                                  snapshot.data![index]["obj_programmation"]["related_tags"]["name"].toString() :
                                                  snapshot.data![index]["objective"]["related_tags"]["name"].toUpperCase(),
                                                ),
                                              ),
                                            },
                                            const Divider(
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              DateFormat("dd, MMMM yyyy", "fr_FR")
                                                  .format(DateTime.parse(snapshot.data![index]["updated_at"].toString()))
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: AppColors.darpinkColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (_, i) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
