import 'package:run_your_life/models/objective.dart';
import 'package:rxdart/rxdart.dart';

class ObjectivesVM {
  ObjectivesVM._pr();
  static final ObjectivesVM _instance = ObjectivesVM._pr();
  static ObjectivesVM get instance => _instance;

  final BehaviorSubject<List<Objective>> _subject = BehaviorSubject<List<Objective>>();
  Stream<List<Objective>> get stream => _subject.stream;
  List<Objective> get value => _subject.value;


  void populate(List<Objective> data) {
    _subject.add(data);
  }
}