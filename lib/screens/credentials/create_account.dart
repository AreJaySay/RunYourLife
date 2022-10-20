import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/screens/credentials/components/forgot_password/email_verification/validate_code.dart';
import 'package:run_your_life/screens/credentials/login.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import '../../../../utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/delayed.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/textfields.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../widgets/appbar.dart';
import 'components/account_created.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final DelayedWidgets _delayedWidgets = new DelayedWidgets();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final AppBars _appBars = new AppBars();
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();
  TextEditingController _fname = new TextEditingController();
  TextEditingController _lname = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phonenumber = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();
  bool _keyboardVisible = false;
  bool _ispassword = false;

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('fr'),
        initialDate:  DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        step1subs.birthdate = selectedDate.toString();
      });
    }
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fname.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: _keyboardVisible ? null :
        _appBars.preferredSize(height: 70,logowidth: 95),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.white,
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.only(bottom: 50,top: 40),
              children: [
                _keyboardVisible ? Container() :
                 Text("S'INSCRIRE",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                _delayedWidgets.delayedWidget(
                  delayDuration: 200,
                  delayedAnimations: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  animationDuration: 200,
                  widget: Column(
                    children: [
                      SizedBox(
                        height: _keyboardVisible ? 0 : 20,
                      ),
                      TextFields(_lname, hintText: "Nom de famille"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFields(_fname, hintText: "Prénom"),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: Text(selectedDate == null ? "Date d'anniversaire" : DateFormat("dd/MM/yyyy").format(DateTime.parse(selectedDate.toString())) ,style: TextStyle(color: selectedDate == null ? Colors.grey[400] : Colors.black,fontFamily: "AppFontStyle",fontSize: 15.5),),
                        ),
                        onTap: (){
                          _selectDate(context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFields(_phonenumber, hintText: "Numéro de téléphone (Optionnelle)"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFields(_email, hintText: "Adresse mail"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFields(_password, hintText: "Mot de passe",is_password: true,),
                      SizedBox(
                        height: 10,
                      ),
                      TextFields(_confirmpassword, hintText: "Répétez le mot de passe",is_password: true,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                _materialbutton.materialButton("S'INSCRIRE", () {
                  if(_lname.text.isEmpty){
                    _snackbarMessage.snackbarMessage(context, message: "Nom ne peut pas être vide !", is_error: true);
                  }else if(_fname.text.isEmpty){
                    _snackbarMessage.snackbarMessage(context, message: "Prénom ne peut pas être vide !", is_error: true);
                  }else if(_email.text.isEmpty){
                    _snackbarMessage.snackbarMessage(context, message: "Adresse mail ne peut pas être vide !", is_error: true);
                  }else if(step1subs.birthdate == ""){
                    _snackbarMessage.snackbarMessage(context, message: "La date de naissance ne peut pas être vide !", is_error: true);
                  }else if(_password.text.isEmpty){
                    _snackbarMessage.snackbarMessage(context, message: "Mot de passe ne peut pas être vide !", is_error: true);
                  }else if(_confirmpassword.text.isEmpty){
                    _snackbarMessage.snackbarMessage(context, message: "Mot de passe de confirmation ne peut pas être vide !", is_error: true);
                  }else if(_confirmpassword.text != _password.text){
                    _snackbarMessage.snackbarMessage(context, message: "Le mot de passe et le mot de passe de confirmation ne correspondent pas !", is_error: true);
                  }else{
                    _screenLoaders.functionLoader(context);
                    credentialsServices.register(context,lname: _lname.text, fname: _fname.text, email: _email.text, phone_1: _phonenumber.text, password: _password.text).then((value){
                      if(value != null){
                        _routes.navigator_pushreplacement(context, EmailVerificationCode());
                      }else{
                        Navigator.of(context).pop(null);
                        _snackbarMessage.snackbarMessage(context, message: "Les données fournies étaient invalides.",is_error: true);
                      }
                    });
                  }
                }),
                // SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Divider(
                //           thickness: 1.1,
                //           color: Colors.black
                //       ),
                //     ),
                //     SizedBox(
                //       width: 15,
                //     ),
                //     Text("Se connecter avec",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle")),
                //     SizedBox(
                //       width: 15,
                //     ),
                //     Expanded(
                //       child: Divider(
                //         color: Colors.black,
                //         thickness: 1.1,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   height: 55,
                //   child: _materialbutton.materialButton("Google", () {
                //
                //   }, icon: "assets/icons/google.png",spacing: 15,bckgrndColor: Colors.white,textColor: AppColors.appmaincolor,fontsize: 17),
                //   decoration: BoxDecoration(
                //       border: Border.all(color: AppColors.appmaincolor),
                //       borderRadius: BorderRadius.circular(1000)
                //   ),
                // ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Déjà membre ?",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
                    InkWell(
                      onTap: (){
                        _routes.navigator_push(context, Login(),transitionType: PageTransitionType.leftToRightWithFade);
                      },
                      child: Text(" SE CONNECTER",style: TextStyle(color: AppColors.appmaincolor,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
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
