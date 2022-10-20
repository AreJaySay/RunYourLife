import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:run_your_life/data_component/objective_vm.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/objective.dart';
import 'package:run_your_life/services/apis_services/screens/objective.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/services/landing_page_services/objective_service.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MyObjectives extends StatefulWidget {
  @override
  _MyObjectivesState createState() => _MyObjectivesState();
}

class _MyObjectivesState extends State<MyObjectives> with WidgetsBindingObserver, ObjectiveService{
  final AppBars _appBars = new AppBars();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ObjectivesVM _vm = ObjectivesVM.instance;
  final ObjectiveApi _objectiveApi = new ObjectiveApi();
  late final ScrollController _scrollController;

  void init() async {
    await fetchObjectiveAndPopulate();
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: _appBars.whiteappbar(
          context,
          title: "MES OBJECTIFS DE LA \nSEMAINE",
        ),
        body: LayoutBuilder(
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
                            child: NoDataFound(firstString: "AUCUN", secondString: "OBJECTIF TROUVÉ", thirdString: "Vous verrez ici tous vos objectifs, lorsque vous en avez."),
                          ) :
                          ListView.separated(
                            shrinkWrap: true,
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            itemBuilder: (_, index) => ZoomTapAnimation(
                              end: 0.99,
                              onTap: (){
                                _screenLoaders.functionLoader(context);
                                _objectiveApi.changeStatus(id: _result[index].id.toString(), status: _result[index].viewStatus == 0 ? "1" : "0").then((value){
                                  init();
                                  Navigator.of(context).pop(null);
                                });
                              },
                              child: Card(
                                color: _result[index].viewStatus == 0 ? Colors.white : AppColors.pinkColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_result[index].objective?.title ?? "Pas de titre", style: TextStyle(
                                          color: _result[index].viewStatus == 0 ? AppColors.appmaincolor : Colors.white,
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
                                            color: _result[index].viewStatus == 0 ? Colors.grey : Colors.white70,
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
                                          color: _result[index].viewStatus == 0 ? AppColors.darpinkColor : Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}
