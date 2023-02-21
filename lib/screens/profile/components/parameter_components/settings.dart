import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/functions/logout_user.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/setting_components/manage_account.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../coaching/recover_subscription.dart';
import '../../../welcome.dart';
import 'setting_components/delete_account_code.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ProfileServices _profileServices = new ProfileServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final LogoutUser _logoutUser = new LogoutUser();
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Materialbutton _materialbutton = new Materialbutton();

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Expanded(child: Text("Modifier les Informations Personnelles",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.white),)),
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
                Text("Mes abonnement",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.white),),
              ],
            ),
          ),
          onTap: (){
            _routes.navigator_push(context, RecoverSubscription());
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
                Icon(Icons.sticky_note_2,color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Text("Condition générales d’utilisation",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.white),),
              ],
            ),
          ),
          onTap: (){
            _launchUrl(link: "https://app.runyourlife.fr/terms_condition_use");
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
                Icon(Icons.shield_rounded,color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Text("Conditions générales de ventes",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.white),),
              ],
            ),
          ),
          onTap: (){
            _launchUrl(link: "https://app.runyourlife.fr/terms_condition");
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
                Icon(Icons.delete,color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Text("Suppression du compte",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.white),),
              ],
            ),
          ),
          onTap: ()async{
           await showModalBottomSheet(
               backgroundColor: Colors.white,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
               isScrollControlled: true,
                context: context, builder: (context){
              return _verify();
            });
          },
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
  Widget _verify(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      width: double.infinity,
      height: 240,
      child: Column(
        children: [
          Text("Es-tu sûr de vouloir supprimer ton compte ? Cette action ne peut pas être annulée.",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.black),textAlign: TextAlign.center,),
          Spacer(),
          _materialbutton.materialButton("Continuer", () {
            _screenLoaders.functionLoader(context);
            _profileServices.sendCode().whenComplete((){
              _routes.navigator_pushreplacement(context, DeleteAccountCode());
            });
          },radius: 15),
          SizedBox(
            height: 10,
          ),
          _materialbutton.materialButton("Annuler", () {
            Navigator.of(context).pop(null);
          },radius: 15, bckgrndColor: Colors.white, textColor: Colors.black),
        ],
      ),
    );
  }
}
