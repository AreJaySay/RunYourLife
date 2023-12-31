import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/credentials/forgot_password.dart';
import 'package:run_your_life/services/apis_services/credentials/verify_email.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/textfields.dart';
import '../../../../../utils/snackbars/snackbar_message.dart';
import '../../../../profile/components/parameter_components/setting_components/manage_account.dart';

class EmailVerificationCode extends StatefulWidget {
  @override
  _EmailVerificationCodeState createState() => _EmailVerificationCodeState();
}

class _EmailVerificationCodeState extends State<EmailVerificationCode> {
  final ForgotPasswordServices _passwordServices = new ForgotPasswordServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final VerifyEmailServices _emailServices = new VerifyEmailServices();
  final TextEditingController _code = new TextEditingController();
  final Routes _routes = new Routes();
  final Materialbutton _materialbutton = new Materialbutton();
  Timer? _timer;
  int _start = 60;
  bool _isresend = false;
  bool _keyboardVisible = false;

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
    KeyboardVisibilityController().onChange.listen((event) {
      Future.delayed(Duration(milliseconds:  100), () {
        setState(() {
          _keyboardVisible = event;
        });
      });
    });
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _keyboardVisible ? Container() : Text("Le code de vérification".toUpperCase(),style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),),
                    _keyboardVisible ? Container() : SizedBox(
                      height: 40,
                    ),
                    _keyboardVisible ? Container() : Text("Entrez le code de vérification à 8 chiffres envoyé sur ton adresse mail.",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                     SizedBox(
                      height: 30,
                    ),
                    TextFields(_code, hintText: "Entrez le code de vérification",isCode: true,),
                    Spacer(),
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
                        _snackbarMessage.snackbarMessage(context, message: "Enter verification code.", is_error: true);
                      }else{
                        _screenLoaders.functionLoader(context);
                        _emailServices.code(context,token: _code.text);
                      }
                    }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
