import 'package:rxdart/rxdart.dart';

class FeedbackStreamServices{
  // COACH FEEDBACK
  final BehaviorSubject<List> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  List get current => subject.value;

  update({required List data}){
    subject.add(data);
  }

  // TIME
  final BehaviorSubject<Map> time = new BehaviorSubject();
  Stream get timeStream => time.stream;
  Map get currentTime => time.value;

  updateTime({required Map data}){
    time.add(data);
  }
}

FeedbackStreamServices feedbackStreamServices = new FeedbackStreamServices();