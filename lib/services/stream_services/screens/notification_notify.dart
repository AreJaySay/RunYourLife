import 'package:rxdart/rxdart.dart';

class NotificationNotifyStreamServices{
  // MESSAGE
  BehaviorSubject<bool> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  bool get currentdata => subject.value;

  update({required bool data}){
    subject.add(data);
  }

  // NOTIFICATION
  BehaviorSubject<bool> notify = new BehaviorSubject();
  Stream get notifyStream => subject.stream;
  bool get currentNotify => subject.value;

  updateNotic({required bool data}){
    notify.add(data);
  }
}

NotificationNotifyStreamServices notificationNotifyStreamServices = new NotificationNotifyStreamServices();