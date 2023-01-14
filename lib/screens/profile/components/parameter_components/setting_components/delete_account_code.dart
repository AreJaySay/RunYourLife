import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';

import '../../../../../services/apis_services/screens/profile.dart';
import '../../../../../services/other_services/routes.dart';
import '../../../../welcome.dart';

class DeleteAccountCode extends StatefulWidget {
  @override
  State<DeleteAccountCode> createState() => _DeleteAccountCodeState();
}

class _DeleteAccountCodeState extends State<DeleteAccountCode> {
  final ProfileServices _profileServices = new ProfileServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Routes _routes = new Routes();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  Timer? _timer;
  int _start = 60;
  bool _isresend = false;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

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
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer!.cancel();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Padding(
              padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("SUPPRIMER LE PROFIL",style: TextStyle(fontFamily: "AppMediumStyle",fontWeight: FontWeight.w600, fontSize: 20),),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Entre la vérification que nous avons envoyée à ton adresse électronique pour valider la suppression de ton compte.',
                    style: TextStyle(fontFamily: "AppMediumStyle", fontSize: 16),
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 8,
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      disabledColor: Colors.grey,
                      activeColor: Colors.white,
                      selectedColor: Colors.white,
                      selectedFillColor: Colors.white,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: AppColors.appmaincolor,
                      inactiveColor: AppColors.appmaincolor
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                  )),
            ),
            Spacer(),
            _isresend ?
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text("Attends ${_start.toString()} seconde(s) avant de faire une nouvelle demande de code. Merci.",textAlign: TextAlign.center,style: TextStyle(fontSize: 15, color: AppColors.appmaincolor,fontFamily: "AppFontStyle",)),
              ),
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous n'avez pas reçu le code? ",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                TextButton(
                  onPressed: (){
                    setState(() {
                      _profileServices.sendCode();
                      currentText = "";
                      textEditingController.text = "";
                      _isresend = true;
                      _start = 60;
                      startTimer();
                    });
                  },
                  child: Text(
                    "Renvoyer".toUpperCase(),
                    style: TextStyle(
                        color: AppColors.darpinkColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )
              ],
            ),
            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
              child: ButtonTheme(
                height: 55,
                child: TextButton(
                  onPressed: () {
                    if(textEditingController.text.length == 8){
                      _screenLoaders.functionLoader(context);
                      _profileServices.VerifyCode(context,code: textEditingController.text);
                    }
                  },
                  child: Center(
                      child: Text(
                        "Supprimer".toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              decoration: BoxDecoration(
                  color: AppColors.appmaincolor,
                  borderRadius: BorderRadius.circular(10),
              )
            ),
           TextButton(
             onPressed: (){
               Navigator.of(context).pop(null);
             },
             child: Center(
               child: Text("ANNULER",style: TextStyle(fontFamily: "AppFontStyle",color: Colors.black87),),
             ),
           ),
           SizedBox(
            height: 30,
          ),
          ],
        ),
      ),
    );
  }
}