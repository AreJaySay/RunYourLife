import 'package:run_your_life/screens/profile/components/parameters.dart';

class Parameters{
  String weight_unit;
  String height_unit;
  static String alcohol = "1";
  static String stress = "1";
  static String sleep = "1";
  static String tobacco = "1";
  static String food_supplement = "1";
  static String medicine = "1";
  static String coffee = "1";
  static String water = "1";
  static String training = "1";
  static String menstruation = "1";
  static String notify1st = "Me notifier quand le coach m’a envoyé un message";
  static String notify2nd = "Me rappeler de faire mon journal de bord journalier à";
  static String notify3rd = "";
  static String hour1st = "null";
  static String hour2nd = "18:00";
  static String hour3rd = "";
  List trackings = [stress,sleep,tobacco,alcohol,food_supplement,medicine,coffee,water,training,menstruation];
  String id;

  Parameters({
    this.weight_unit = "kg",
    this.height_unit = "Cm",
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