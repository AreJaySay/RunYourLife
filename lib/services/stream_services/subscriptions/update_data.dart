import 'package:rxdart/rxdart.dart';

class SubStreamServices{
  BehaviorSubject<Map> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  Map get currentdata => subject.value;

  addSubs({required Map data}){
    subject.add(data);
  }
}

SubStreamServices subStreamServices = new SubStreamServices();