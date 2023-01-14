import 'package:run_your_life/screens/profile/components/parameters.dart';

class Parameters{
  String weight_unit;
  String height_unit;
  static String alcohol = "0";
  static String stress = "0";
  static String sleep = "0";
  static String tobacco = "0";
  static String food_supplement = "0";
  static String medicine = "0";
  static String coffee = "0";
  static String water = "0";
  static String training = "0";
  static String menstruation = "0";
  static String notify1st = "";
  static String notify2nd = "";
  static String notify3rd = "";
  static String hour1st = "null";
  static String hour2nd = "";
  static String hour3rd = "";
  List trackings = [stress,sleep,tobacco,alcohol,food_supplement,medicine,coffee,water,training,menstruation];
  String id;

  Parameters({
    this.weight_unit = "",
    this.height_unit = "",
    this.id = "",
  });

  Map<String, dynamic> toMap() => {
    "weight_unit": weight_unit,
    "height_unit": height_unit,
    "stress": trackings[0],
    "sleep": trackings[1],
    "tobacco": trackings[2],
    "alcohol": trackings[3],
    "food_supplement": trackings[4],
    "medicine": trackings[5],
    "coffee": trackings[6],
    "water": trackings[7],
    "training": trackings[8],
    "menstruation": trackings[9],
    "notifications[0][value]": notify1st,
    "notifications[1][value]": notify2nd,
    "notifications[2][value]": notify3rd,
    "notifications[0][hour]": hour1st,
    "notifications[1][hour]": hour2nd,
    "notifications[2][hour]": hour3rd,
    "id": id,
  };
}

Parameters parameters = new Parameters();