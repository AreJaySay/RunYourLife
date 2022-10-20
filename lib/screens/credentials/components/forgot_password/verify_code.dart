import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/credentials/login.dart';
import 'package:run_your_life/services/apis_services/credentials/forgot_password.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../utils/snackbars/snackbar_message.dart';
import '../../../../widgets/textfields.dart';

class EnterVerificationCode extends StatefulWidget {
  @override
  _EnterVerificationCodeState createState() => _EnterVerificationCodeState();
}

class _EnterVerificationCodeState extends State<EnterVerificationCode> {
  final ForgotPasswordServices _passwordServices = new ForgotPasswordServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final AppBars _appBars = new AppBars();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Routes _routes = new Routes();
  final Materialbutton _materialbutton = new Materialbutton();
  final TextEditingController _verifycode = new TextEditingController();
  final TextEditingController _newPassword = new TextEditingController();
  final TextEditingController _confirmPassword = new TextEditingController();
  String _code = "";
  bool _onEditing = false;
  Timer? _timer;
  int _start = 60;
  bool _isresend = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            setState(() {
              _isresend = false;
            });
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  color: Colors.grey[100],
                  image: AssetImage("assets/icons/logo_icon.png"),
                ),
              ),
              SafeArea(
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
                    children: [
                      Text("Le code de vérification".toUpperCase(),style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 40,
                      ),
                      Text("Entrez le code de vérification à 10 chiffres envoyé sur ton adresse mail.",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                      SizedBox(
                        height: 30,
                      ),
                      TextFields(_verifycode, hintText: "Entrez le code de vérification",isCode: true,),
                      SizedBox(
                        height: 30,
                      ),
                      TextFields(_newPassword, hintText: "Entrez un nouveau mot de passe",is_password: true,),
                      SizedBox(
                        height: 15,
                      ),
                      TextFields(_confirmPassword, hintText: "Confirmer le nouveau mot de passe",is_password: true),
                      SizedBox(
                        height: 60,
                      ),
                     _isresend ?
                      Container(
                        width: double.infinity,
                        child: Center(
                          child: Text("Attends ${_start.toString()} seconde(s) avant de faire une nouvelle demande de code. Merci.",textAlign: TextAlign.center,style: TextStyle(fontSize: 15, color: AppColors.appmaincolor,fontFamily: "AppFontStyle",)),
                        ),
                      ) :
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          child: Center(
                            child: Text("Envoyer de nouveau",style: TextStyle(color: AppColors.appmaincolor,fontFamily: "AppFontStyle",fontSize: 16),),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            _isresend = true;
                            _start = 60;
                            startTimer();
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _materialbutton.materialButton("ENTREZ LE CODE DE VÉRIFICATION", () {
                        if(_code == ""){
                          _snackbarMessage.snackbarMessage(context, message: "Entrez le code de vérification.", is_error: true);
                        }else if(_newPassword.text.isEmpty){
                          _snackbarMessage.snackbarMessage(context, message: "Entrez le nouveau mot de passe.", is_error: true);
                        }else if(_confirmPassword.text.isEmpty){
                          _snackbarMessage.snackbarMessage(context, message: "Confirmez votre nouveau mot de passe.", is_error: true);
                        }else if(_newPassword.text != _confirmPassword.text){
                          _snackbarMessage.snackbarMessage(context, message: "Le nouveau mot de passe et le mot de passe de confirmation ne correspondent pas.", is_error: true);
                        }else{
                          _screenLoaders.functionLoader(context);
                          _passwordServices.reset_password(context,token: _code.toString(),newpass: _newPassword.text);
                        }
                      }),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          child: Center(
                            child: Text("ANNULER",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600),),
                          ),
                        ),
                        onTap: (){
                          _routes.navigator_pushreplacement(context, Login(), transitionType: PageTransitionType.leftToRightWithFade);
                        },
                      ),
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
}
