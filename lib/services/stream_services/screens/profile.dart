import 'package:rxdart/rxdart.dart';

class ProfileStreamServices{
  // APPBAR
  BehaviorSubject<Map> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  Map get current => subject.value;

  update({required Map data}){
    subject.add(data);
  }
}

ProfileStreamServices profileStreamServices = new ProfileStreamServices();