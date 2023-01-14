import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/settings.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:intl/intl.dart';

import '../../../functions/loaders.dart';
import '../../../functions/logout_user.dart';
import '../../../models/auths_model.dart';
import '../../../utils/palettes/app_colors.dart';
import '../../../utils/palettes/app_gradient_colors.dart';
import '../../welcome.dart';

class ProfileNotSubscribed extends StatefulWidget {
  @override
  _ProfileNotSubscribedState createState() => _ProfileNotSubscribedState();
}

class _ProfileNotSubscribedState extends State<ProfileNotSubscribed> {
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final LogoutUser _logoutUser = new LogoutUser();
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: Auth.loggedUser == null ? Container() : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Téléphone",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                      SizedBox(
                        height: 5,
                      ),
                      Text(Auth.loggedUser!["phone_1"].toString() == "null" ? "--" : Auth.loggedUser!["phone_1"], style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date de naissance",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                    SizedBox(
                      height: 5,
                    ),
                    Text(Auth.loggedUser!["birthday"].toString() == "null" ? "--" : DateFormat("dd/MM/yyyy").format(DateTime.parse(Auth.loggedUser!["birthday"])), style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                SizedBox(
                  height: 5,
                ),
                Text(Auth.loggedUser!["email"].toString() == "null" ? "--" : Auth.loggedUser!["email"], style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Adresse",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                SizedBox(
                  height: 5,
                ),
                Text(Auth.loggedUser!["address_1"].toString() == "null" ? "--" : Auth.loggedUser!["address_1"], style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Settings(),
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
    );
  }
}
