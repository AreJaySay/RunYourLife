import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:run_your_life/screens/notifications/notifications.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/apis_services/screens/coaching.dart';
import 'package:run_your_life/services/apis_services/screens/feedback.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/apis_services/screens/messages.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/messages.dart';
import 'package:run_your_life/services/stream_services/screens/notification_notify.dart';
import 'package:run_your_life/utils/snackbars/notification_message.dart';
import '../../models/auths_model.dart';
import '../../models/screens/feedback/feedback.dart';
import '../../models/screens/profile/parameters.dart';
import '../../screens/messages/messages.dart';
import '../stream_services/screens/parameters.dart';

class PushNotifications{
  final MessageServices _messageServices = new MessageServices();
  final NotificationMessage _message = new NotificationMessage();
  final ProfileServices _profileServices = new ProfileServices();
  final Routes _routes = new Routes();
  final FeedbackServices _feedbackServices = new FeedbackServices();
  final CheckinServices _checkinServices = new CheckinServices();
  final HomeServices _homeServices = new HomeServices();
  final CoachingServices _coachingServices = new CoachingServices();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final ParameterServices _parameterServices = new ParameterServices();

  final String serverToken = 'AAAAVYPQqbM:APA91bEFYu0SIzRqgrVr6W38X2WM2zKycMBc1PNMXmaTKCLBuVfQp0AaHIL_N1JGECnH1cVfa_6bv_-POYp2FacfNHttHaqYJeI-b9T3sWVpPI_6yE8IChYT7FORP6iEqIdg_ZBybrnO';
  FirebaseMessaging firebasemessaging = FirebaseMessaging.instance;

  Future<void> initialize(context)async{
      await firebasemessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      await firebasemessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
        RemoteNotification? notification = message!.notification;
        if (message != null) {
          print("FIRST RECIEVER :"+notification!.body.toString());
        }
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if(notification!.title!.contains("New Message")){
          _messageServices.getMessages();
          notificationNotifyStreamServices.update(data: true);
          if(Parameters.notify1st != ""){
            _message.notificSnackbar(context, message: notification.body.toString());
          }
        }else if(notification.title!.contains("Nouveau feedback")){
          _feedbackServices.getFeedback().then((value){
            coachFeedBack.currentWeek.clear();
            coachFeedBack.lastWeek.clear();
            coachFeedBack.otherWeek.clear();
            for(int x = 0; x < value.length; x++){
              if(DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays <= 7){
                if(!coachFeedBack.currentWeek.toString().contains(value[x].toString())){
                  coachFeedBack.currentWeek.add(value[x]);
                }
              }
              if(DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays > 7 && DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays <= 14){
                if(!coachFeedBack.lastWeek.toString().contains(value[x].toString())){
                  coachFeedBack.lastWeek.add(value[x]);
                }
              }
              if(DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays > 14){
                if(!coachFeedBack.otherWeek.toString().contains(value[x].toString())){
                  coachFeedBack.otherWeek.add(value[x]);
                }
              }
            }
          });
           notificationNotifyStreamServices.updateNotic(data: true);
          // _message.notificSnackbar(context, message: notification.body.toString());
        }else{
          _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString(), relation: "activeSubscription");
          _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString(), relation: "notifications");
          _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.parse(notification.body!)));
          _homeServices.getSchedule();
          _coachingServices.getplans();
          _subscriptionServices.getInfos();
          _parameterServices.getSetting();
          _homeServices.getWeights();
          _homeServices.getHeights();
          notificationNotifyStreamServices.updateNotic(data: true);
          // _message.notificSnackbar(context, message: "Un nouveau fichier a été envoyé");
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if(notification!.title!.contains("New Message")){
          _messageServices.getMessages().whenComplete((){
            _routes.navigator_pushreplacement(context, Messages());
            notificationNotifyStreamServices.update(data: false);
          });
        }else{
          _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString());
          _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString(), relation: "notifications").whenComplete((){
            _routes.navigator_pushreplacement(context, Notifications());
            _homeServices.getSchedule();
            _coachingServices.getplans();
            _subscriptionServices.getInfos();
            _parameterServices.getSetting();
            _homeServices.getWeights();
            _homeServices.getHeights();
            notificationNotifyStreamServices.updateNotic(data: true);
          });
          _checkinServices.getTracking(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.parse(notification.body!)));
        }
      });
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async{
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        notificationNotifyStreamServices.update(data: true);
        print("onBackgroundMessage"+notification!.body.toString());
      });
  }
}
