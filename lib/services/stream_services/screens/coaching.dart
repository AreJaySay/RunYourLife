import 'package:rxdart/rxdart.dart';

class CoachingStreamServices{
  final BehaviorSubject<List> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  List get currentdata => subject.value;

  updatePlans({required List data}){
    subject.add(data);
  }
}

CoachingStreamServices coachingStreamServices = new CoachingStreamServices();