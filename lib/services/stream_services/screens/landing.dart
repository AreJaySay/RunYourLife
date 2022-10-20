import 'package:rxdart/rxdart.dart';

class LandingServices{
  BehaviorSubject<int> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  int get current => subject.value;

  updateIndex({required int index}){
    subject.add(index);
  }
}

LandingServices landingServices = new LandingServices();