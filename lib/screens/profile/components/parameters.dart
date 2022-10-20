import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/profile/parameters.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/change_hours.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/settings.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/unite_measures.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/stream_services/screens/coaching.dart';
import 'package:run_your_life/services/stream_services/screens/parameters.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../functions/logout_user.dart';
import '../../../services/other_services/routes.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/appbar.dart';
import '../../coaching/components/enter_card.dart';
import '../../coaching/components/view_details.dart';
import '../../welcome.dart';

class Parameters extends StatefulWidget {
  @override
  _ParametersState createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  final ParameterServices _parameterServices = new ParameterServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final LogoutUser _logoutUser = new LogoutUser();
  final Routes _routes = new Routes();
  final AppBars _appBars = new AppBars();
  List<String> _type = ["Me notifier quand mon coach m'a envoye un message","Me rappeler de faire mon check-in journalier à","Me rappeler de faire mon check-in hebdo :"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _parameterServices.getSetting().then((value){
      if(value.toString() != "{}"){
        parameters.notifvalue = value["notifications"]["value"].toString();
        parameters.notifhour =  value["notifications"]["hour"].toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: parameterStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: _appBars.whiteappbar(context, title: "Paramètres".toUpperCase()),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 30),
                children: [
                  Settings(),
                  if(!snapshot.hasData)...{
                    for(int x = 0; x < 3; x++)...{
                      _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 55),
                      SizedBox(
                        height: 15,
                      )
                    },
                  }else...{
                    for(var x = 0; x < _type.length; x++)...{
                      GestureDetector(
                        onTap: (){
                          if(!Auth.isNotSubs!){
                            setState(() {
                              print(snapshot.data);
                              parameters.notifvalue = _type[x];
                            });
                          }
                        },
                        child: ZoomTapAnimation(end: 0.99,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Auth.isNotSubs! ? Colors.grey[200] : Colors.white60,
                                border: Border.all(color: parameters.notifvalue == _type[x] ? AppColors.appmaincolor : Colors.transparent),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Transform.scale(
                                    scale: 0.9,
                                    child: SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Checkbox(
                                        checkColor: Colors.transparent,
                                        activeColor: AppColors.appmaincolor,
                                        value: parameters.notifvalue == _type[x],
                                        shape: CircleBorder(),
                                        splashRadius: 20,
                                        side: BorderSide(
                                            width: 0,
                                            color: Colors.transparent
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            print(snapshot.data);
                                            parameters.notifvalue = _type[x];
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                                      borderRadius: BorderRadius.circular(1000)
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: x == 2 ?
                                  Text(snapshot.data!["notifications"] == null ? "${_type[x]} 0 heures avant mon point hebdo" :  snapshot.data!["notifications"]["hour"].toString() == "null" ? "${_type[x]} 0 heures avant mon point hebdo" : "${_type[x]} ${snapshot.data!["notifications"]["hour"]} heures avant mon point hebdo",style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),):
                                  Text(_type[x],style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),),
                                SizedBox(
                                  width: 5,
                                ),
                                x == 0 ? Container() : InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 18,vertical: 13),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Auth.isNotSubs! ? AppColors.pinkColor.withOpacity(0.4) : AppColors.pinkColor
                                    ),
                                    child: snapshot.data!.toString() == "{}" ?
                                    Text("Régler le temps",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),) :
                                    snapshot.data!["notifications"]["value"].toString() == "null" || snapshot.data!["notifications"]["hour"].toString() == "null" ?
                                    Text("Régler le temps",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),) :
                                    Text(snapshot.data!["notifications"]["hour"],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "AppFontStyle"),),
                                  ),
                                  onTap: (){
                                     if(!Auth.isNotSubs!){
                                       _routes.navigator_push(context, ParametersChangeHour());
                                     }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    },
                  },
                  SizedBox(
                    height: 10,
                  ),
                  if(!snapshot.hasData)...{
                    for(int x = 0; x < 5; x++)...{
                      _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 55),
                      SizedBox(
                        height: 15,
                      )
                    },
                  }else...{
                    UniteMeasures(details: snapshot.data!,),
                  },
                  SizedBox(
                    height: DeviceModel.isMobile ? 50 : 80,
                  ),
                  Container(
                    child: _materialbutton.materialButton("ENREGISTRER", () {
                      if(!Auth.isNotSubs!){
                        _screenLoaders.functionLoader(context);
                        _parameterServices.submit(context).then((value){
                          if(value != null){
                            _parameterServices.getSetting().whenComplete((){
                              Navigator.of(context).pop(null);
                              _snackbarMessage.snackbarMessage(context , message: "Le paramètre a été mis à jour avec succès !");
                            });
                          }else{
                            Navigator.of(context).pop(null);
                            _snackbarMessage.snackbarMessage(context, message: "Une erreur s'est produite. Veuillez réessayer !", is_error: true);
                          }
                        });
                      }
                    }, bckgrndColor: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.5) : AppColors.appmaincolor),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Auth.loggedUser == null ? _upgrader() :
                  subscriptionDetails.currentdata.toString() == "[]" ? _upgrader() :
                  subscriptionDetails.currentdata[0]["plan_id"] == 2 ? Container() : _upgrader(),
                  InkWell(
                    onTap: (){
                      _screenLoaders.functionLoader(context);
                      _logoutUser.logout().whenComplete((){
                        Navigator.of(context).pop(null);
                        _routes.navigator_pushreplacement(context, Welcome(), transitionType: PageTransitionType.leftToRightWithFade);
                      });
                    },
                    child: Container(
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_outlined,size: 24,color: AppColors.pinkColor,),
                          SizedBox(
                            width: 7,
                          ),
                          Text("SE DÉCONNECTER",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600,fontSize: 15),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  Widget _upgrader(){
   return Column(
     children: [
       DottedLine(
         dashColor: Colors.grey.shade400,
       ),
       SizedBox(
         height: DeviceModel.isMobile ? 30 : 50,
       ),
       ZoomTapAnimation(
          end: 0.99,
          onTap: (){
            if(!Auth.isNotSubs!){
              showModalBottomSheet(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                  isScrollControlled: true,
                  context: context, builder: (context){
                return EnterCreditCard(title: "SUBSCRIBE TO MACRO SOLO",details:coachingStreamServices.currentdata[1],);
              });
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: DeviceModel.isMobile ? 110 : 140,
            decoration: Auth.isNotSubs! ?
            BoxDecoration(
                color: AppColors.appmaincolor.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 2), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.circular(10)
            ) :
            BoxDecoration(
                gradient: AppGradientColors.gradient,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 2), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.circular(10)
            ),
            child: Stack(
              children: [
                Image(
                  color: Colors.white.withOpacity(0.1),
                  width: double.infinity,
                  image: AssetImage("assets/icons/coaching.png",),
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                  filterQuality: FilterQuality.high,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("UPGRADER",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Laissez-vous porter !",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
     ],
   );
  }
}
