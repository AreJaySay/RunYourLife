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

class _ObjectivesPageState extends State<ObjectivesPage> with WidgetsBindingObserver, ObjectiveService {
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ObjectivesVM _vm = ObjectivesVM.instance;
  final CheckinServices _checkinServices = new CheckinServices();
  final ObjectiveServices _objectiveServices = new ObjectiveServices();
  late final ScrollController _scrollController;

  void init() async {
    await fetchObjectiveAndPopulate();
  }


  @override
  void initState() {
    // TODO: implement initState
    init();
    _checkinServices.getResources(context);
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
                child: StreamBuilder<List<Objective>>(
                  stream: _vm.stream,
                  builder: (_, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      if (!snapshot.hasData) {
                        return LoadingAnimationWidget.hexagonDots(
                          color: AppColors.appmaincolor,
                          size: 40,
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "Erreur lors de la récupération des données, veuillez réessayer.",
                            style: TextStyle(
                              color: AppColors.appmaincolor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    }
                    final List<Objective> _result = snapshot.data!;
                    return Scrollbar(
                      controller: _scrollController,
                      child: _result.isEmpty ?
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
                                                value:  _result[index].viewStatus == 1,
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
                                                    _result[index].viewStatus = _result[index].viewStatus == 0 ? 1 : 0;
                                                  });
                                                  // _screenLoaders.functionLoader(context);
                                                  _objectiveServices.changeStatus(id: _result[index].id.toString(), status: _result[index].viewStatus.toString()).then((value){
                                                    init();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: _result[index].viewStatus == 0 ? Colors.grey : AppColors.pinkColor ,width: 2),
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
                                            Text(_result[index].objective?.title ?? "Pas de titre", style: TextStyle(
                                              color: AppColors.appmaincolor,
                                              fontSize: 17.5,
                                              height: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            ),
                                            if (_result[index].objective != null &&
                                                _result[index]
                                                    .objective!
                                                    .description
                                                    .isNotEmpty) ...{
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                _result[index].objective?.description ??
                                                    "Pas de description",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  height: 1,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            },
                                            if (_result[index].objective != null &&
                                                _result[index].objective!.relatedTags !=
                                                    null) ...{
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Chip(
                                                label: Text(
                                                  _result[index]
                                                      .objective!
                                                      .relatedTags!
                                                      .name
                                                      .toUpperCase(),
                                                ),
                                              ),
                                            },
                                            const Divider(
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              DateFormat("dd, MMMM yyyy", "fr_FR")
                                                  .format(_result[index].createdAt)
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
                        itemCount: _result.length,
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
