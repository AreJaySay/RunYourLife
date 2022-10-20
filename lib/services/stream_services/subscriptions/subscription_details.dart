import 'package:rxdart/rxdart.dart';

class SubscriptionDetails{
  BehaviorSubject<List> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  List get currentdata => subject.value;

  updateSubs({required List data}){
    subject.add(data);
  }
}

SubscriptionDetails subscriptionDetails = new SubscriptionDetails();