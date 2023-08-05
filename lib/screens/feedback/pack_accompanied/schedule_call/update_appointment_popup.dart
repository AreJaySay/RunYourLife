import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/screens/feedback.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import '../../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../../utils/snackbars/snackbar_message.dart';

class UpdateAppointmentPopUp extends StatefulWidget {
  final Map details;
  final String hour;
  UpdateAppointmentPopUp({required this.details, required this.hour});
  @override
  State<UpdateAppointmentPopUp> createState() => _UpdateAppointmentPopUpState();
}

class _UpdateAppointmentPopUpState extends State<UpdateAppointmentPopUp> {
  final Materialbutton _materialbutton = new Materialbutton();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final FeedbackServices _feedbackServices = new FeedbackServices();
  final HomeServices _homeServices = new HomeServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      child: Column(
        children: [
          Text("Vous avez toujours un rendez-vous non terminé à coacher, vous ne pouvez pas en fixer un autre tant qu'il n'est pas terminé. Mettez plutôt à jour l'heure/le jour pour votre rendez-vous ?",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
          Spacer(),
          _materialbutton.materialButton("Mettre à jour le rendez-vous", () {
            _screenLoaders.functionLoader(context);
            _feedbackServices.submit(date_id: widget.details["id_date"].toString(), time: widget.hour).then((value){
              if(value != null){
                _feedbackServices.getTime(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now().toUtc().add(Duration(hours: 2))), coach_id: subscriptionDetails.currentdata[0]['coach_id'].toString());
                _homeServices.getSchedule().whenComplete((){
                  Navigator.of(context).pop(null);
                  Navigator.of(context).pop(null);
                  Navigator.of(context).pop(null);
                  _snackbarMessage.snackbarMessage(context, message: "L'horaire a été soumis avec succès !");
                });
              }else{
                Navigator.of(context).pop(null);
              }
            });
          }),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(null);
            },
            child: Center(
              child: Text("Annuler",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15,color: Colors.black),),
            ),
          )
        ],
      ),
    );
  }
}
