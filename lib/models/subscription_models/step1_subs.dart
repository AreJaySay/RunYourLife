import 'package:run_your_life/services/other_services/routes.dart';
import '../../services/stream_services/subscriptions/subscription_details.dart';

class Step1Subs{
  final Routes _routes = new Routes();

  String gender;
  String birthdate;
  String weight;
  String height;
  String target_weight;
  String isMarried;
  String haveChildren;
  double peopeSupport;
  String shopforHousehold;
  String cookforHousehold;
  String id;
  String subscription_id;

  Step1Subs({
    this.gender = "",
    this.birthdate = "",
    this.height = "",
    this.weight = "",
    this.target_weight = "",
    this.isMarried = "",
    this.haveChildren = "",
    this.peopeSupport = 0,
    this.shopforHousehold = "",
    this.cookforHousehold = "",
    this.id = "",
    this.subscription_id = "",
  });

  Map<String, dynamic> toMap() => {
    "gender": gender,
    "birth_date": birthdate,
    "height": height,
    "weight": weight,
    "target_weight": target_weight,
    "married": isMarried,
    "have_children": haveChildren,
    "people_support": peopeSupport.toString(),
    "shop_for_household": shopforHousehold,
    "cook_for_household": cookforHousehold,
    "id": id,
    "subscription_id": subscriptionDetails.currentdata[0]["id"].toString(),
  };

  // Future editStep1(context,{required Map details})async{
  //   if(details.toString() != "{}"){
  //     gender = details["gender"] == null ? "" : details["gender"].toString();
  //     weight = details["weight"] == null ? "" : details["weight"].toString();
  //     height = details["height"] == null ? "" : details["height"].toString();
  //     birthdate = details["birth_date"] == null ? "" : details["birth_date"].toString();
  //     isMarried = details["have_children"] == null ? "" : details["have_children"].toString();
  //     haveChildren = details["have_children"] == null ? "" : details["have_children"].toString();
  //     peopeSupport = details["people_support"] == null ? 0 : double.parse(details["people_support"].toString());
  //     shopforHousehold = details["shop_for_household"] == null ? "" : details["shop_for_household"].toString();
  //     cookforHousehold = details["cook_for_household"] == null ? "" : details["cook_for_household"].toString();
  //     id = details["id"].toString();
  //     subscription_id = details["subscription_id"].toString();
  //   }
  // }
}
Step1Subs step1subs = new Step1Subs();