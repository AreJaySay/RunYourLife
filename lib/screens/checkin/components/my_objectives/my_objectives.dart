import 'package:flutter/material.dart';
import 'package:run_your_life/data_component/objective_vm.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/objective.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';

import '../my_ressources/my_ressources.dart';
import 'components/objectives.dart';

class MyObjectives extends StatefulWidget {
  @override
  _MyObjectivesState createState() => _MyObjectivesState();
}

class _MyObjectivesState extends State<MyObjectives> with TickerProviderStateMixin {
  final AppBars _appBars = new AppBars();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        body: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            TabBar(
              indicatorColor: AppColors.appmaincolor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  text: "Objectifs",
                ),
                Tab(
                  text: "Documents",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ObjectivesPage(),
                  MyRessources()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
