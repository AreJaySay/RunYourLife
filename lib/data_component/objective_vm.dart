import 'package:run_your_life/models/objective.dart';
import 'package:rxdart/rxdart.dart';

class ObjectivesVM {
  // LOADER
  BehaviorSubject<bool> loader = new BehaviorSubject();
  Stream get streamLoader => loader.stream;
  bool get currentLoader => loader.value;

  update({required bool data}){
    loader.add(data);
  }

  // OBJECTIVES
  final BehaviorSubject<List> subject = BehaviorSubject.seeded([]);
  Stream get stream => subject.stream;
  List get value => subject.value;

  add({required Map data}) {
    value.add(data);
  }
}

ObjectivesVM objectivesVM = new ObjectivesVM();