import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/credentials/components/forgot_password/components/email_sent.dart';
import 'package:run_your_life/services/apis_services/credentials/forgot_password.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../../utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/backbutton.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import '../../../../widgets/textfields.dart';

class EnterEmailAddress extends StatefulWidget {
  @override
  _EnterEmailAddressState createState() => _EnterEmailAddressState();
}

class _EnterEmailAddressState extends State<EnterEmailAddress> {
  final ForgotPasswordServices _passwordServices = new ForgotPasswordServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Materialbutton _materialbutton = new Materialbutton();
  TextEditingController _email = new TextEditingController();
  bool _keyboardVisible = false;

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
      appBar: _appBars.preferredSize(height: 70,logowidth: 95),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  child: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    child: Center(
                      child: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 22,),
                    ),
                    decoration: BoxDecoration(
                        gradient: AppGradientColors.gradient,
                        borderRadius: BorderRadius.circular(1000)
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      Navigator.of(context).pop(null);
                    });
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                Text("MOT DE PASSE OUBLIÉ ?",style: TextStyle(fontSize: 20,color: AppColors.appmaincolor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: TextFields(_email,hintText: "Adresse mail"),
            ),
            Spacer(),
            _materialbutton.materialButton("RÉINITIALISER", () {
              if(_email.text.isEmpty){
                _snackbarMessage.snackbarMessage(context, message: "Email address cannot be empty.", is_error: true);
              }else{
                _screenLoaders.functionLoader(context);
                _passwordServices.enter_email(context,email: _email.text);
              }
            }),
            SizedBox(
              height: _keyboardVisible ? 10 : 70,
            ),
          ],
        ),
      ),
    );
  }
}
