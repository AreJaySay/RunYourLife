class CoachFeedBack{
  List currentWeek = [];
  List lastWeek = [];
  List otherWeek = [];

  CoachFeedBack({
   required this.currentWeek,
   required this.lastWeek,
   required this.otherWeek
  });
}

CoachFeedBack coachFeedBack = new CoachFeedBack(currentWeek: [], lastWeek: [], otherWeek: []);