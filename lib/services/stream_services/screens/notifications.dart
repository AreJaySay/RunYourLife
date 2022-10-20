import 'package:run_your_life/screens/notifications/notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationServices{
  BehaviorSubject<List> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  List get current => subject.value;

  update({required List data}){
    subject.add(data);
  }
}

NotificationServices notificationServices = new NotificationServices();
