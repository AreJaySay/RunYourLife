import 'package:flutter/material.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/widgets/no_data.dart';

import '../../../models/auths_model.dart';

class ProfileNotSubscribed extends StatefulWidget {
  @override
  _ProfileNotSubscribedState createState() => _ProfileNotSubscribedState();
}

class _ProfileNotSubscribedState extends State<ProfileNotSubscribed> {
  final Materialbutton _materialbutton = new Materialbutton();
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone number",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                      SizedBox(
                        height: 5,
                      ),
                      Text(Auth.loggedUser!["phone_1"] == null ? "--" : Auth.loggedUser!["phone_1"], style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date de naissance",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                    SizedBox(
                      height: 5,
                    ),
                    Text(Auth.loggedUser!["birthday"] == null ? "--" : DateFormat("dd/MM/yyyy").format(DateTime.parse(Auth.loggedUser!["birthday"])), style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                SizedBox(
                  height: 5,
                ),
                Text(Auth.loggedUser!["email"] == null ? "--" : Auth.loggedUser!["email"], style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address",style: TextStyle(color: Colors.grey[500], fontSize: 14.5, fontFamily: "AppFontStyle")),
                SizedBox(
                  height: 5,
                ),
                Text(Auth.loggedUser!["address_1"] == null ? "--" : Auth.loggedUser!["address_1"], style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "AppFontStyle"),overflow: TextOverflow.ellipsis,maxLines: 1,),
              ],
            ),
          ),
          Spacer(),
          NoDataFound(firstString: "RIEN TROUVÉ ", secondString: "ICI ENCORE...", thirdString: "Une fois votre inscription terminée, les détails du formulaire s'afficheront ici."),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
