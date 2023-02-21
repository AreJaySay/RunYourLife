import 'package:flutter/material.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/landing.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../models/subscription_models/step1_subs.dart';
import '../models/subscription_models/step2_subs.dart';
import '../models/subscription_models/step4_subs.dart';
import '../models/subscription_models/step5_subs.dart';
import '../screens/coaching/subscription/form_completed.dart';
import '../screens/coaching/subscription/pack_solo/eating/main_page.dart';
import '../screens/coaching/subscription/pack_solo/objective/main_page.dart';
import '../screens/coaching/subscription/pack_solo/presentation/main_page.dart';
import '../screens/coaching/subscription/pack_solo/sport_practice/main_page.dart';
import '../services/stream_services/subscriptions/subscription_details.dart';
import '../services/stream_services/subscriptions/update_data.dart';

class FinishQuestionerPopup extends StatefulWidget {
  final bool isComplete;
  FinishQuestionerPopup({this.isComplete = true});
  @override
  State<FinishQuestionerPopup> createState() => _FinishQuestionerPopupState();
}

class _FinishQuestionerPopupState extends State<FinishQuestionerPopup> {
  final Materialbutton _materialButton = new Materialbutton();
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.isComplete ? 230 : 310,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      child: Column(
        children: [
          Text(widget.isComplete ? "Avant d’accéder à ces fonctions tu dois finir ton questionnaire" : "Cet abonnement ne vous permet pas d'obtenir un feedback de votre coach. Cependant, vous pouvez vous rendre sur la page de votre profil en bas de page et mettre à niveau votre abonnement pour que le mois prochain vous puissiez bénéficier d'un suivi 100% personnalisé et d'un contact permanent avec un coach !",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
          Spacer(),
          _materialButton.materialButton(widget.isComplete ? "VALIDER" : "CONTINUER", () {
            if(widget.isComplete){
              // step1subs.editStep1(context, details: subStreamServices.currentdata["client_info"] == null  ? {} : subStreamServices.currentdata["client_info"]);
              // step2subs.editStep2(context, details: subStreamServices.currentdata["food_preference"] == null ? {} : subStreamServices.currentdata["food_preference"]);
              // step4subs.editStep4(context, details: subStreamServices.currentdata["goal"] == null ? {} : subStreamServices.currentdata["goal"]);
              // step5subs.editStep5(context, details: subStreamServices.currentdata["sport"] == null ? {} : subStreamServices.currentdata["sport"]);

              // PRESENTATION
              if(subStreamServices.currentdata["client_info"] == null){
                _routes.navigator_push(context,  PackSoloPresentationMainPage());
              }else if(subStreamServices.currentdata["client_info"]["macro_status"] == false){
                _routes.navigator_push(context, PackSoloPresentationMainPage());
              }else{
                // OBJECTIVE
                if(subStreamServices.currentdata["goal"] == null){
                  _routes.navigator_push(context, PackSoloObjectiveMainPage());
                }else if(subStreamServices.currentdata["goal"]["macro_status"] == false){
                  _routes.navigator_push(context, PackSoloObjectiveMainPage());
                }else{
                  // SPORT
                  if(subStreamServices.currentdata["sport"] == null){
                    _routes.navigator_push(context, PackSoloSportMainPage());
                  }else if(subStreamServices.currentdata["sport"]["macro_status"] == false){
                    _routes.navigator_push(context, PackSoloSportMainPage());
                  }else{
                    // ALIMENTATION
                    if(subStreamServices.currentdata["food_preference"] == null){
                      _routes.navigator_push(context, PackSoloEatingMainPage());
                    }else if(subStreamServices.currentdata["food_preference"]["macro_status"] == false){
                      _routes.navigator_push(context, PackSoloEatingMainPage());
                    }else{
                      _routes.navigator_push(context, FormCompleted());
                    }
                  }
                }
              }
            }else{
              Navigator.of(context).pop(null);
              landingServices.updateIndex(index: 4);
            }
          }),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(null);
            },
            child: Text("ANNULER",style: TextStyle(fontFamily: "AppFontStyle",color: Colors.black87),),
          )
        ],
      ),
    );
  }
}
