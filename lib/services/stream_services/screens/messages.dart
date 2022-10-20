import 'package:rxdart/rxdart.dart';

class MessageStreamServices{
  // MESSAGE
  final BehaviorSubject<List> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  List get currentdata => subject.value;

  updatemessages({required List data}){
    subject.add(data);
  }
  appendmessage({required Map data}){
    currentdata.add(data);
  }

  // COACH
  final BehaviorSubject<Map> coach = new BehaviorSubject();
  Stream get coachstream => coach.stream;
  Map get currentcoach => coach.value;

  updatecoach({required Map data}){
    coach.add(data);
  }

  // PINNED MESSAGES
  final BehaviorSubject<List> pinned = new BehaviorSubject();
  Stream get pinnedstream => pinned.stream;
  List get currentpinned => pinned.value;

  updatePinned({required List data}){
    pinned.add(data);
  }
}

MessageStreamServices messageStreamServices  = new MessageStreamServices();