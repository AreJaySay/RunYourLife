import 'package:rxdart/rxdart.dart';

class Step5StreamService{
  BehaviorSubject<bool> _subject = new BehaviorSubject();
  Stream get stream => _subject.stream;
  bool get current =>_subject.value;

  update({required bool data}){
    _subject.add(data);
  }
}

Step5StreamService step5streamService = new Step5StreamService();