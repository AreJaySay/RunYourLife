import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../landing.dart';
import 'components/account_created.dart';

class SignInGoogle extends StatefulWidget {
  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {
  final ProfileServices _profileServices = new ProfileServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Routes _routes = new Routes();
  final AppBars _appBars = new AppBars();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Materialbutton _materialbutton = new Materialbutton();
  AdditionalUserInfo? _additionalUserInfo;
  AuthCredential? _authCredential;
  User? _user;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value)async{
      setState(() {
         value.user!.getIdTokenResult().then((token)async{
         await credentialsServices.login(context, email: token.claims!["email"], password: token.claims!["user_id"],).then((login){
           print("RETURN ${login.toString()}");
           if(login != null){
              _routes.navigator_pushreplacement(context, Landing());
            }else{
              setState((){
                _additionalUserInfo = value.additionalUserInfo;
                _authCredential = value.credential;
                _user = value.user;
                if(_additionalUserInfo == null){
                  GoogleSignIn().signOut().whenComplete((){
                    Navigator.of(context).pop(null);
                  });
                }
              });
            }
          });
        });
      });
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _additionalUserInfo == null ? null : _appBars.preferredSize(height: 56,logowidth: 95),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: _additionalUserInfo == null ? Center(
          child: CircularProgressIndicator(),
        ) : Stack(
          children: [
            Image(
              color: AppColors.appmaincolor.withOpacity(0.06),
              alignment: Alignment.centerRight,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              image: AssetImage("assets/icons/google_transparent.png"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(1000),
                                border: Border.all(color: AppColors.appmaincolor,width: 3),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(_additionalUserInfo!.profile!['picture'])
                                )
                            ),
                          ),
                          Container(
                            height: 110,
                            width: 110,
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1000),
                                border: Border.all(color: AppColors.appmaincolor,width: 1),
                              ),
                              child: Image(
                                image: AssetImage("assets/icons/google.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Connecté en tant que',style: TextStyle(fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(_additionalUserInfo!.profile!['name'].toString(),style: TextStyle(fontFamily: "AppFontStyle",fontSize: 18,fontWeight: FontWeight.w600),),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rappel: ",style: TextStyle(fontFamily: "AppFontStyle"),),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Vos informations google sont masquées et protégées conformément à la politique Google Playstore.",style: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey[600]),)
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      _materialbutton.materialButton("Continuer", () {
                        _screenLoaders.functionLoader(context);
                        _user!.getIdTokenResult().then((value){
                          credentialsServices.register(context,lname: _additionalUserInfo!.profile!["given_name"], fname: _additionalUserInfo!.profile!["family_name"], email: value.claims!["email"], phone_1: "", password: value.claims!["user_id"]).then((register){
                            if(register != null){
                              credentialsServices.login(context, email: register["email"], password: value.claims!["user_id"],).then((value){
                                print(value.toString());
                                if(value != null){
                                  _routes.navigator_pushreplacement(context, Landing());
                                }else{
                                  Navigator.of(context).pop(null);
                                  _snackbarMessage.snackbarMessage(context, message: "An error occured. Please try again !", is_error: true);
                                }
                              });
                            }else{
                              credentialsServices.login(context, email: value.claims!["email"], password: value.claims!["user_id"],).then((value){
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
                          });
                          print(_additionalUserInfo!.profile);
                          print(value);
                        });
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      _materialbutton.materialButton("Annuler", () async{
                        await GoogleSignIn().signOut().whenComplete((){
                          Navigator.of(context).pop(null);
                        });
                      },radius: 1000,bckgrndColor: Colors.white,textColor: AppColors.appmaincolor),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}