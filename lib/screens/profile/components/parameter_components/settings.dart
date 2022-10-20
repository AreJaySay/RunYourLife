import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/functions/logout_user.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/setting_components/manage_account.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../welcome.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final LogoutUser _logoutUser = new LogoutUser();
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();

  Future<void> _launchUrl({required String link}) async {
    if (!await launchUrl(Uri.parse(link))) {
      throw _snackbarMessage.snackbarMessage(context, message: "Could not launch!",is_error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ZoomTapAnimation(
          end: 0.99,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 65,
            decoration: BoxDecoration(
              gradient: AppGradientColors.gradient,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Image(
                  image: AssetImage("assets/icons/profile.png"),
                  width: 18,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Modifier les Informations Personnelles",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.white),),
              ],
            ),
          ),
          onTap: (){
            _routes.navigator_push(context, EditInformation());
          },
        ),
        SizedBox(
          height: 15,
        ),
        ZoomTapAnimation(
          end: 0.99,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17),
            height: 65,
            decoration: BoxDecoration(
                gradient: AppGradientColors.gradient,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.menu_book,color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Text("Privacy Policy",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.white),),
              ],
            ),
          ),
          onTap: (){
            _launchUrl(link: "https://webtest.runyourlife.studioseizh.com/privacy_policy");
          },
        ),
        SizedBox(
          height: 15,
        ),
        ZoomTapAnimation(
          end: 0.99,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17),
            height: 65,
            decoration: BoxDecoration(
                gradient: AppGradientColors.gradient,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.shield_outlined,color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Text("Terms and Condition",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.white),),
              ],
            ),
          ),
          onTap: (){
            _launchUrl(link: "https://webtest.runyourlife.studioseizh.com/terms_condition");
          },
        ),
        SizedBox(
          height: 35,
        ),
        DottedLine(
          dashColor: Colors.grey.shade400,
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
