import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/screens/welcome.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/other_services/push_notifications.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/auths_model.dart';
import 'models/reminder_helper.dart';
import 'screens/landing.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await NotificationService().requestIOSPermissions();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Run your life',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fr', 'FR'),
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Routes _routes = new Routes();
  final PushNotifications _pushNotifications = new PushNotifications();
  final CredentialsServices _credentialsServices = new CredentialsServices();
  final ProfileServices _profileServices = new ProfileServices();
  List _todos = ['MON POIDS',"MES MESURES","MES PHOTOS","MES OBJECTIFS DE LA SEMAINE"];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pushNotifications.firebasemessaging.getToken().then((value)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        DeviceModel.devicefcmToken = value;
        print("APNS TOKEN ${value.toString()}");
        Auth.email = prefs.getString('email');
        Auth.pass = prefs.getString('password');
        if(prefs.getString("poid_date") == null && prefs.getString("other_date") == null){
        }else{
          for(int x = 0; x < prefs.getStringList('checkin')!.length; x++){
            if(prefs.getStringList('checkin')![x] == "MON POIDS"){
              if(DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.parse(prefs.getString("poid_date").toString()))).difference(DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now().toUtc().add(Duration(hours: 2))))).inDays == 0){
                CheckinServices.checkinSelected.remove(prefs.getStringList('checkin')![0]);
              }else{
                print("didi");
                CheckinServices.checkinSelected.add(prefs.getStringList('checkin')![x]);
              }
            }else{
              if(DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(prefs.getString("other_date").toString())).inDays > 0){
                CheckinServices.checkinSelected.remove(prefs.getStringList('checkin')![0]);
              }else{
                print("didi");
                CheckinServices.checkinSelected.add(prefs.getStringList('checkin')![x]);
              }
            }
          }
        }
      });
      if(Auth.email == null && Auth.pass == null){
        _routes.navigator_pushreplacement(context, Welcome(), transitionType: PageTransitionType.fade);
      }else{
        credentialsServices.login(context, email: Auth.email!, password: Auth.pass!).then((value){
          if(value != null){
            _profileServices.getProfile(clientid: value['client_id'].toString()).then((result){
              print(result);
              if(result != null){
                _routes.navigator_pushreplacement(context, Landing());
              }else{
                _routes.navigator_pushreplacement(context, Welcome(), transitionType: PageTransitionType.fade);
              }
            });
          }else{
            _routes.navigator_pushreplacement(context, Welcome(), transitionType: PageTransitionType.fade);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DeviceModel.screenW = MediaQuery.of(context).size.width;
    return SplashScreen();
  }
}