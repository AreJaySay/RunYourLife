import 'package:run_your_life/screens/profile/components/parameters.dart';

class Parameters{
  String weight_unit;
  String height_unit;
  String alcohol;
  String tobacco;
  String food_supplement;
  String medicine;
  String coffee;
  String water;
  String notifvalue;
  String notifhour;
  String id;

  Parameters({
    this.weight_unit = "",
    this.height_unit = "",
    this.alcohol = "",
    this.tobacco = "",
    this.food_supplement = "",
    this.medicine = "",
    this.coffee = "",
    this.water = "",
    this.notifvalue = "",
    this.notifhour = "",
    this.id = "",
  });

  Map<String, dynamic> toMap() => {
    "weight_unit": weight_unit,
    "height_unit": height_unit,
    "alcohol": alcohol,
    "tobacco": tobacco,
    "food_supplement": food_supplement,
    "medicine": medicine,
    "coffee": coffee,
    "water": water,
    "notifications[value]": notifvalue,
    "notifications[hour]": notifhour,
    "id": id
  };
}

Parameters parameters = new Parameters();