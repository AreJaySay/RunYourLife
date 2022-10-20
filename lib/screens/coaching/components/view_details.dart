import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/screens/coaching/components/welcome_subscriber.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/apis_services/subscriptions/choose_plan.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../../../models/screens/profile/parameters.dart';
import '../../../widgets/backbutton.dart';

class ViewCoachingDetails extends StatefulWidget {
  final Map planDetails,choosePlan;
  ViewCoachingDetails({required this.planDetails,required this.choosePlan});
  @override
  _ViewCoachingDetailsState createState() => _ViewCoachingDetailsState();
}

class _ViewCoachingDetailsState extends State<ViewCoachingDetails> {
  final ChoosePlanService _choosePlanService = new ChoosePlanService();
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ParameterServices _parameterServices = new ParameterServices();
  final Routes _routes = new Routes();
  List _bulletnames = ['Sulvi et Feedback débloques','Calcul de macro','Accés â des ressources','Feedback','Appel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            widget.planDetails['name'].toString() == "macro solo" ? Container() : Image(
              width: double.infinity,
              alignment: Alignment.topRight,
              image: AssetImage("assets/important_assets/coaching_back.png"),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageBackButton(margin: 0,),
                    SizedBox(
                      height: 30,
                    ),
                    Text("PACK",style: TextStyle(color: AppColors.appmaincolor,fontSize: 27,fontFamily: "AppFontStyle"),),
                    Text( "${widget.planDetails['name']}",style: TextStyle(color: AppColors.appmaincolor,fontSize: 27,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                    SizedBox(
                      height: 20,
                    ),
                    Text(widget.planDetails["description"],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${widget.planDetails["prices"][widget.planDetails["prices"].length - 1]["price"].toString()}€",style: TextStyle(fontSize: 40,color: AppColors.appmaincolor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                        Container(
                          width: 50,
                          height: 30,
                          alignment: Alignment.bottomCenter,
                          child: Text("/mois",style: TextStyle(fontSize: 17,color: AppColors.appmaincolor),),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for(var x = 0; x < _bulletnames.length;x++)...{
                      Row(
                        children: [
                           widget.planDetails['name'].toString() == "macro solo" ? Container(
                            child: x == 4 || x == 3 ?
                            Icon(Icons.close_rounded,size: 23,color: Colors.grey,) :
                            Icon(Icons.check_circle,size: 23,color: AppColors.pinkColor,),
                          ) : Container(
                            child: Icon(Icons.check_circle,size: 23,color: AppColors.pinkColor,),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(_bulletnames[x],style: TextStyle(
                            color: widget.planDetails['name'].toString() == "macro solo" ? x == 4 || x == 3 ? Colors.grey : Colors.black : Colors.black,
                            fontSize: 15,
                            fontWeight: x == 2 ? FontWeight.w500 : FontWeight.bold,
                            fontFamily: "AppFontStyle"
                          ),),
                          x == 0 || x == 2 ? Container() :
                          Text(x == 4 ? " hebdomadaire" : " personnalisé",style: TextStyle(
                              color:  widget.planDetails['name'].toString() == "macro solo" ? x == 4 || x == 3 ? Colors.grey : Colors.black : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: "AppFontStyle"
                          ),)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    },
                    Spacer(),
                    Container(
                      child: _materialbutton.materialButton("ACHETER", () {
                        setState((){
                          parameters.alcohol = "Oui";
                          parameters.tobacco = "Oui";
                          parameters.food_supplement = "Oui";
                          parameters.medicine = "Oui";
                          parameters.coffee = "Oui";
                          parameters.water = "Oui";
                        });
                        _screenLoaders.functionLoader(context);
                        _parameterServices.submit(context).whenComplete((){
                          _routes.navigator_pushreplacement(context, SubscriberWelcome(planDetails: widget.planDetails, choosenSubs: widget.choosePlan,));
                        });
                      }),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
