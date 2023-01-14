import 'package:run_your_life/models/measurement.dart';
import 'package:rxdart/rxdart.dart';

class HomeStreamServices{
  // SCHEDULING
  HomeStreamServices._pr();
  static final HomeStreamServices _instance = HomeStreamServices._pr();
  static HomeStreamServices get instance => _instance;
  BehaviorSubject<Map> subject = new BehaviorSubject();
  Stream get stream => subject.stream;
  Map get current => subject.value;

  update({required Map data}){
    subject.add(data);
  }

  // TRACKING
  BehaviorSubject<Map> tracking = new BehaviorSubject();
  Stream get trackStream => tracking.stream;
  Map get currentTrack => tracking.value;

  updateTrack({required Map data}){
    tracking.add(data);
  }

  // LATEST CHECKIN
  BehaviorSubject<Map> latestCheckin = new BehaviorSubject();
  Stream get latestCheckinStream => latestCheckin.stream;
  Map get currentlatestCheckin => latestCheckin.value;

  updateLatestCheckin({required Map data}){
    latestCheckin.add(data);
  }

  // TRACKING BY MONTH
  BehaviorSubject<List> month = new BehaviorSubject();
  List get currentMonth => month.value;

  updateMonth({required List data}){
    month.add(data);
  }

  //MEETING SCHEDULE
  BehaviorSubject<Map> meeting = new BehaviorSubject();
  Stream<Map> get meetingStream => meeting.stream;
  Map get currentMeeting => meeting.value;

  updateMeeting({required Map data}){
    meeting.add(data);
  }

  // GRAPH DATA
  BehaviorSubject<Map> graphWeight = new BehaviorSubject();
  Stream get graphWeightStream => graphWeight.stream;
  Map get currentgraphWeight => graphWeight.value;

  updateGraphWeight({required Map data}){
    graphWeight.add(data);
  }

  BehaviorSubject<List<Measurement>> graphHeight = new BehaviorSubject<List<Measurement>>();
  Stream<List<Measurement>> get graphHeightStream => graphHeight.stream;
  List<Measurement> get currentgraphHeight => graphHeight.value;

  updateGraphHeight({required List<Measurement> data}){
    graphHeight.add(data);
  }
}

HomeStreamServices homeStreamServices = HomeStreamServices.instance;