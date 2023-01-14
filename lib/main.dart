import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/screens/welcome.dart';
import 'package:run_your_life/services/apis_services/credentials/auths.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/other_services/push_notifications.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'models/auths_model.dart';
import 'screens/landing.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true
  );
  runApp(MyApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new DarwinInitializationSettings();
    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    return Future.value(true);
  });
}


class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pushNotifications.firebasemessaging.getToken().then((value)async{
      setState(() {
        DeviceModel.devicefcmToken = value;
      });
      print("APNS TOKEN ${value.toString()}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Auth.email = prefs.getString('email');
      Auth.pass = prefs.getString('password');
      if(Auth.email == null && Auth.pass == null){
        _routes.navigator_pushreplacement(context, Welcome(), transitionType: PageTransitionType.fade);
      }else{
        credentialsServices.login(context, email: Auth.email!, password: Auth.pass!).then((value){
          if(value != null){
            _profileServices.getProfile(clientid: value['client_id'].toString()).then((result){
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
