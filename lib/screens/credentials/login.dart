import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/credentials/components/forgot_password/enter_email.dart';
import 'package:run_your_life/screens/credentials/create_account.dart';
import 'package:run_your_life/screens/credentials/goole_sign_in.dart';
import 'package:run_your_life/screens/landing.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../../utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/delayed.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/textfields.dart';

import '../../models/device_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Materialbutton _materialbutton = new Materialbutton();
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ProfileServices _profileServices = new ProfileServices();
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  bool _isRemember = false;
  bool _keyboardVisible = false;
  final DelayedWidgets _delayedWidgets = new DelayedWidgets();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KeyboardVisibilityController().onChange.listen((event) {
      Future.delayed(Duration(milliseconds:  100), () {
        setState(() {
          _keyboardVisible = event;
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: _keyboardVisible ? null :
        _appBars.preferredSize(height: 70,logowidth: 90),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: _keyboardVisible ? 20 : 60),
          color: Colors.white,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _keyboardVisible ? Container() : Text("CONNEXION",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                SizedBox(
                  height: _keyboardVisible ? 5 : 40,
                ),
                _delayedWidgets.delayedWidget(
                  delayDuration: 200,
                  delayedAnimations: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  animationDuration: 200,
                  widget: Container(
                      height: 50,
                      child: TextFields(_email,hintText: "Email")
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                _delayedWidgets.delayedWidget(
                  delayDuration: 200,
                  delayedAnimations: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  animationDuration: 200,
                  widget: Container(
                      height: 50,
                      child: TextFields(_pass,hintText: "Mot de passe",is_password: true)
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        width: 21,
                        height: 21,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.appmaincolor,width: 1.5),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                        child: Center(
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: _isRemember ? AppColors.appmaincolor : Colors.white,
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          _isRemember = !_isRemember;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Se souvenir de moi",style: TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "AppFontStyle"),)
                  ],
                ),
                Spacer(),
                _materialbutton.materialButton("SE CONNECTER", () {
                  if(_email.text.isEmpty){
                    _snackbarMessage.snackbarMessage(context, message: "L’adresse mail ne peut pas être vide !", is_error: true);
                  }else if(_pass.text.isEmpty){
                    _snackbarMessage.snackbarMessage(context, message: "Le mot de passe ne peut pas être vide !", is_error: true);
                  }else{
                    _screenLoaders.functionLoader(context);
                    credentialsServices.login(context, email: _email.text, password: _pass.text,).then((value){
                      if(value != null){
                        _profileServices.getProfile(clientid: value['client_id'].toString()).then((result){
                          if(result != null){
                            _routes.navigator_pushreplacement(context, Landing());
                          }else{
                            Navigator.of(context).pop(null);
                            _snackbarMessage.snackbarMessage(context, message: "les identifiants de connexion ne sont pas valides !", is_error: true);
                          }
                        });
                      }else{
                        Navigator.of(context).pop(null);
                        _snackbarMessage.snackbarMessage(context, message: "Informations d'identification invalides, veuillez vérifier et réessayer.", is_error: true);
                      }
                    });
                  }
                }),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: InkWell(
                      child: Text("Mot de passe oublié ?",style: TextStyle(color: AppColors.pinkColor,fontSize: 15,fontFamily: "AppFontStyle"),),
                      onTap: (){
                        _routes.navigator_push(context, EnterEmailAddress());
                      },
                    )
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                //  Column(
                //   children: [
                //     Row(
                //       children: [
                //         Expanded(
                //           child: Divider(
                //               thickness: 1.1,
                //               color: Colors.black
                //           ),
                //         ),
                //         SizedBox(
                //           width: 15,
                //         ),
                //         Text("Se connecter avec",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle")),
                //         SizedBox(
                //           width: 15,
                //         ),
                //         Expanded(
                //           child: Divider(
                //             color: Colors.black,
                //             thickness: 1.1,
                //           ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       height: _keyboardVisible ? 10 : 20,
                //     ),
                //     Container(
                //       height: 55,
                //       child: _materialbutton.materialButton("Google", () async{
                //         try {
                //           _routes.navigator_push(context, SignInGoogle());
                //         } catch (error) {
                //           print(error);
                //         }
                //       }, icon: "assets/icons/google.png",spacing: 15,bckgrndColor: Colors.white,textColor: AppColors.appmaincolor,fontsize: 17),
                //      decoration: BoxDecoration(
                //        border: Border.all(color: AppColors.appmaincolor),
                //        borderRadius: BorderRadius.circular(1000)
                //      ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Pas encore membre ?",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
                    InkWell(
                      onTap: (){
                        _routes.navigator_push(context, CreateAccount());
                      },
                      child: Text(" CREER UN COMPTE",style: TextStyle(color: AppColors.appmaincolor,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
