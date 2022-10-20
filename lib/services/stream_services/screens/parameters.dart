import 'package:rxdart/rxdart.dart';

class ParameterStreamServices{
  BehaviorSubject<Map> subject = BehaviorSubject();
  Stream get stream => subject.stream;
  Map get current => subject.value;

  update({required Map data}){
    subject.add(data);
  }
}

ParameterStreamServices parameterStreamServices = new ParameterStreamServices();