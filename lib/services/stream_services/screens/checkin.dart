import 'package:rxdart/rxdart.dart';

class CheckInStreamServices{

  // MY PHOTOS
  BehaviorSubject<List> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  List get current => subject.value;

  update({required List data}){
    subject.add(data);
  }

  // PHOTOS TAGS
  BehaviorSubject<List> tags = new BehaviorSubject();
  Stream get tagstream => tags.stream;
  List get currentTags => tags.value;

  updateTag({required List data}){
    tags.add(data);
  }
  appendTag({required Map data}){
    currentTags.add(data);
  }

  // LOADER
  BehaviorSubject<bool> loader = new BehaviorSubject();
  Stream get streamLoader => loader.stream;
  bool get currentLoader => loader.value;

  updateloader({required bool data}){
    loader.add(data);
  }

  // MY RESSOURCES
  BehaviorSubject<List> ressources = new BehaviorSubject.seeded([]);
  Stream get ressourceStream => ressources.stream;
  List get currentRessources => ressources.value;

  addRessources({required Map data}){
    currentRessources.add(data);
  }

  // LAST UPDATED
  BehaviorSubject<Map> lastUpdated = new BehaviorSubject();
  Stream get lastUpdatedStream => lastUpdated.stream;
  Map get currentlastUpdated => lastUpdated.value;

  updatelastUpdated({required Map data}){
    lastUpdated.add(data);
  }
}

CheckInStreamServices checkInStreamServices = new CheckInStreamServices();