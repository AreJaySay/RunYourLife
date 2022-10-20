import 'package:rxdart/rxdart.dart';

class VideoStream{
  BehaviorSubject<bool> _subject = BehaviorSubject();
  Stream get stream => _subject.stream;
  update({bool? value}) => _subject.add(value!);
}

VideoStream videoStream = new VideoStream();