import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/coaching/components/view_details.dart';
import 'package:run_your_life/services/apis_services/screens/coaching.dart';
import 'package:run_your_life/services/apis_services/subscriptions/choose_plan.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

class EnterCreditCard extends StatefulWidget {
  final String title;
  final Map details;
  EnterCreditCard({required this.title, required this.details});
  @override
  State<EnterCreditCard> createState() => _EnterCreditCardState();
}

class _EnterCreditCardState extends State<EnterCreditCard> {
  final ChoosePlanService _choosePlanService = new ChoosePlanService();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Routes _routes = new Routes();
  final Materialbutton _materialbutton = new Materialbutton();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _expiryDate = TextEditingController();
  final TextEditingController _cvc = TextEditingController();
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
    return Container(
      width: double.infinity,
      height: _keyboardVisible ? double.infinity : 460,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: widget.title == "S'ABONNER À MACRO SOLO" ? AppColors.pinkColor :  AppColors.appmaincolor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_keyboardVisible ? 0 : 15),
                  topLeft: Radius.circular(_keyboardVisible ? 0 : 15)
                )
            ),
            child: Center(
              child: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "AppFontStyle",decoration: TextDecoration.none,fontWeight: FontWeight.w600),),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Code de réduction",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(1000)
                  ),
                  child: TextField(
                    controller: _code,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none,
                      hintText: "Code de réduction",
                      hintStyle: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("COMPTES",style: TextStyle(color: AppColors.appmaincolor,fontSize: 15,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(1000)
                  ),
                  child: TextField(
                    controller: _cardNumber,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: InputBorder.none,
                        hintText: "Entrez le numéro de la carte",
                        hintStyle: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                        child: TextField(
                          controller: _expiryDate,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              border: InputBorder.none,
                              hintText: "MM/YY",
                              hintStyle: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(1000)
                        ),
                        child: TextField(
                          controller: _cvc,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              border: InputBorder.none,
                              hintText: "CVC",
                              hintStyle: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: _materialbutton.materialButton("SUBSCRIBE", () {
              if(_code.text.isEmpty){
                _snackbarMessage.snackbarMessage(context, message: "Entrez votre code de réduction.", is_error: true);
              }else if(_cardNumber.text.isEmpty){
                _snackbarMessage.snackbarMessage(context, message: "Entrez votre numéro de carte.", is_error: true);
              }else if(_expiryDate.text.isEmpty){
                _snackbarMessage.snackbarMessage(context, message: "Entrez la date d'expiration.", is_error: true);
              }else if(_cvc.text.isEmpty){
                _snackbarMessage.snackbarMessage(context, message: "Entrez le code de vérification de la carte.", is_error: true);
              }else{
                _screenLoaders.functionLoader(context);
                _choosePlanService.choosePlan(context, planDetails: widget.details, code: "", card_number: "4242424242424242", expiration_date_month: "11", expiration_date_year: "2023", cvc: "314").then((value){
                  if(value != null){
                    _routes.navigator_push(context, ViewCoachingDetails(planDetails: widget.details,choosePlan: value,));
                  }
                });
              }
            }),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
