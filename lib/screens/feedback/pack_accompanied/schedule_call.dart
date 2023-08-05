import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/services/apis_services/screens/feedback.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/apis_services/screens/messages.dart';
import 'package:run_your_life/services/stream_services/screens/feedback.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/appbar.dart';
import 'schedule_call/shimmer_loader.dart';
import 'schedule_call/update_appointment_popup.dart';

class ScheduleCall extends StatefulWidget {
  @override
  _ScheduleCallState createState() => _ScheduleCallState();
}

class _ScheduleCallState extends State<ScheduleCall> {
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final MessageServices _messageServices = new MessageServices();
  final Materialbutton _materialbutton = new Materialbutton();
  final AppBars _appBars = AppBars();
  final TextEditingController _message = new TextEditingController();
  final FeedbackServices _feedbackServices = new FeedbackServices();
  final HomeServices _homeServices = new HomeServices();
  DatePickerController _datePickerController = DatePickerController();
  String _dateChecker = DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now()).toString();
  String _selectedhour = "";
  int _selected = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageServices.getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: feedbackStreamServices.time,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: _appBars.whiteappbar(context, title: "PROGRAMMER"),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/important_assets/heart_icon.png"),
                  ),
                  ListView(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("CHOISIS LA MANIÈRE",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Un appel de 15 à 30 minutes avec ton coach ou, si tu manques de temps cette semaine, écris un message.",style: TextStyle(fontFamily: "AppFontStyle"),),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            ZoomTapAnimation(
                              end: 0.99,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: _selected == 1 ? AppColors.appmaincolor : Colors.transparent)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Radio(
                                        activeColor: AppColors.appmaincolor,
                                        value: 1,
                                        groupValue: _selected,
                                        onChanged: (val) {
                                          setState(() {
                                            _selected = 1;
                                          });
                                        },
                                      ),
                                    ),
                                    Text('Appel',style: new TextStyle(fontSize: 16,color: Colors.black,fontFamily: "AppFontStyle"),),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  _selected = 1;
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ZoomTapAnimation(
                              end: 0.99,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: _selected == 2 ? AppColors.appmaincolor : Colors.transparent)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Radio(
                                        activeColor: AppColors.appmaincolor,
                                        value: 2,
                                        groupValue: _selected,
                                        onChanged: (val) {
                                          setState(() {
                                            _selected = 2;
                                          });
                                        },
                                      ),
                                    ),
                                    Text('Message',style: new TextStyle(fontSize: 16,color: Colors.black,fontFamily: "AppFontStyle"),),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  _selected = 2;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      _selected == 2 ?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("DÉCRIS TA SEMAINE ET ENVOIE LE À TON COACH",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Décris tout d’abord: les forces de cette semaine, les changements implémentés, tes succès. Puis les difficultés rencontrées face au objectifs et/ou de manière générale. C’est aussi le moment de poser une question à ton coach.",style: new TextStyle(fontSize: 15,fontFamily: "AppFontStyle"),),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: _message,
                              maxLines: 5,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                border: InputBorder.none,
                                hintText: "Ton message...",
                                hintStyle: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.appmaincolor),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              onChanged: (text){
                                setState(() {
                                });
                              },
                            ),
                          ),
                        ],
                      ) : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("CHOISIS LE JOUR ET LE CRÉNEAU QUI T’INTERESSE",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          HorizontalDatePickerWidget(
                            locale: 'fr_FR',
                            startDate: DateTime(2020,01,01),
                            endDate:  DateTime(2100,01,01),
                            selectedDate: DateTime.now(),
                            widgetWidth: MediaQuery.of(context).size.width,
                            datePickerController: _datePickerController,
                            weekDayFontSize: 14,
                            monthFontSize: 14,
                            dayFontSize: 22,
                            selectedColor: AppColors.appmaincolor,
                            onValueSelected: (date)async{
                              setState(() {
                                _dateChecker = DateFormat("yyyy-MM-dd","fr_FR").format(date).toString();
                                _feedbackServices.getTime(date: DateFormat("yyyy-MM-dd","fr_FR").format(date), coach_id: subscriptionDetails.currentdata[0]['coach_id'].toString());
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          !snapshot.hasData ?
                          TimeShimmerLoader() :
                          snapshot.data.toString() == "{}"?
                          Padding(
                            padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                            child: NoDataFound(firstString: "PAS DE ", secondString: "créneaux disponibles...".toUpperCase(), thirdString: "l’entraîneur n’a plus de disponibilités à cette date")) :
                          snapshot.data!["time"].isEmpty ? Padding(
                            padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                            child: NoDataFound(firstString: "PAS DE ", secondString: "créneaux disponibles...".toUpperCase(), thirdString: "l’entraîneur n’a plus de disponibilités à cette date")) :
                          GridView.count(
                            padding: EdgeInsets.all(20),
                            primary: false,
                            shrinkWrap: true,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 10,
                            crossAxisCount: DeviceModel.isMobile ? 3 : 4,
                            childAspectRatio: (1 / .4),
                            children: <Widget>[
                              for(var x = 0; x < snapshot.data!["time"].length; x++)...{
                                if(snapshot.data!["unfinishsched"].toString() == "[]")...{
                                  if(snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString()))...{
                                  }else...{
                                    InkWell(
                                      child: Container(
                                        child: Center(child: Text(snapshot.data!["time"][x],style: TextStyle(fontSize: 17,color: snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString()) ? Colors.white : _selectedhour == snapshot.data!["time"][x] ? Colors.white : Colors.black,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),)),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: snapshot.data!["unfinishsched"].toString().contains(_dateChecker.toString()) ? Colors.white : snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString()) ? Colors.white : _selectedhour == snapshot.data!["time"][x] ? Colors.transparent : Colors.black,width: 0.7),
                                            borderRadius: BorderRadius.circular(1000),
                                            color: snapshot.data!["unfinishsched"].toString().contains(_dateChecker.toString()) ? AppColors.pinkColor : snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString()) ? Colors.grey.shade600 : _selectedhour == snapshot.data!["time"][x] ? AppColors.darpinkColor : Colors.white
                                        ),
                                        margin: EdgeInsets.only(right: 5,bottom: 5),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          if(!snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString())){
                                            _selectedhour = snapshot.data!["time"][x];
                                          }
                                        });
                                      },
                                    )
                                  }
                                }else...{
                                  if(snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString()) && snapshot.data!["unfinishsched"]["time"].toString() != snapshot.data!["time"][x].toString())...{
                                  }else...{
                                    InkWell(
                                      child: Container(
                                        child: Center(child: Text(snapshot.data!["time"][x],style: TextStyle(fontSize: 17,color: snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString()) ? Colors.white : _selectedhour == snapshot.data!["time"][x] ? Colors.white : Colors.black,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),)),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: snapshot.data!["unfinishsched"]["time"].toString() == snapshot.data!["time"][x].toString() && snapshot.data!["unfinishsched"].toString().contains(_dateChecker.toString()) ? Colors.white : snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString()) ? Colors.white : _selectedhour == snapshot.data!["time"][x] ? Colors.transparent : Colors.black,width: 0.7),
                                            borderRadius: BorderRadius.circular(1000),
                                            color: snapshot.data!["unfinishsched"]["time"].toString() == snapshot.data!["time"][x].toString() && snapshot.data!["unfinishsched"].toString().contains(_dateChecker.toString()) ? AppColors.pinkColor : snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString()) ? Colors.grey.shade600 : _selectedhour == snapshot.data!["time"][x] ? AppColors.darpinkColor : Colors.white
                                        ),
                                        margin: EdgeInsets.only(right: 5,bottom: 5),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          if(!snapshot.data!["selectedtime"].toString().contains(snapshot.data!["time"][x].toString())){
                                            _selectedhour = snapshot.data!["time"][x];
                                          }
                                        });
                                      },
                                    )
                                  }
                                }
                              },
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _selected == 2 ? DeviceModel.isMobile ? 70 : 300 : DeviceModel.isMobile ? 120 : 200,
                      ),
                    ],
                  ),
                  !snapshot.hasData ?
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ) :
                  snapshot.data.toString() == "{}" ?
                  Container() :
                  snapshot.data!["time"].isEmpty && _selected == 1 ? Container() : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 110,
                      color: Colors.white,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        margin: EdgeInsets.only(top: 20),
                        child: _materialbutton.materialButton("VALIDER", ()async{
                          if(_selected == 1){
                            if(_dateChecker == DateFormat("yyyy-MM-dd").format(DateTime.parse(DateTime.now().toString()))){
                              _snackbarMessage.snackbarMessage(context, message: "Cette heure n'est pas disponible.", is_error: true);
                            }else{
                              if(snapshot.data!["unfinishsched"].toString() == "null" || snapshot.data!["unfinishsched"].toString() == "[]"){
                                if(_selectedhour == ""){
                                  _snackbarMessage.snackbarMessage(context, message: "Le temps de planification est requis !", is_error: true);
                                }else{
                                  _screenLoaders.functionLoader(context);
                                  _feedbackServices.submit(date_id: snapshot.data!["id_date"].toString(), time: _selectedhour).then((value){
                                    if(value != null){
                                      _feedbackServices.getTime(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now().toUtc().add(Duration(hours: 2))), coach_id: subscriptionDetails.currentdata[0]['coach_id'].toString());
                                      _homeServices.getSchedule().whenComplete((){
                                        Navigator.of(context).pop(null);
                                        Navigator.of(context).pop(null);
                                        _snackbarMessage.snackbarMessage(context, message: "L'horaire a été soumis avec succès !");
                                      });
                                    }else{
                                      Navigator.of(context).pop(null);
                                    }
                                  });
                                }
                              }else{
                                if(_selectedhour == ""){
                                  _snackbarMessage.snackbarMessage(context, message: "Le temps de planification est requis !", is_error: true);
                                }else{
                                  await showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                                      isScrollControlled: true,
                                      context: context, builder: (context){
                                    return UpdateAppointmentPopUp(details: snapshot.data!, hour: _selectedhour,);
                                  }).whenComplete((){
                                    setState(() {
                                      _selectedhour = "";
                                    });
                                  });
                                }
                              }
                            }
                          }else{
                            if(_message.text.isEmpty){
                              _snackbarMessage.snackbarMessage(context, message: "Écrivez quelque chose sur la zone de texte !", is_error: true);
                            }else{
                              _screenLoaders.functionLoader(context);
                              _feedbackServices.addFeedback(message: _message.text).then((value){
                                if(value != null){
                                  Navigator.of(context).pop(null);
                                  _message.text = "";
                                  _snackbarMessage.snackbarMessage(context, message: "Le message a été envoyé à votre coach !",);
                                }else{
                                  Navigator.of(context).pop(null);
                                  _snackbarMessage.snackbarMessage(context, message: "Une erreur s'est produite. Veuillez réessayer.", is_error: true);
                                }
                              });
                            }
                          }
                        },bckgrndColor: AppColors.appmaincolor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
