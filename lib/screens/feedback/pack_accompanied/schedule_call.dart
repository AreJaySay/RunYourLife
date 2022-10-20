import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
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

  int selected = DateTime.now().day - DateTime.now().day;
  final FeedbackServices _feedbackServices = new FeedbackServices();
  final HomeServices _homeServices = new HomeServices();
  FixedExtentScrollController _scrollController =
  FixedExtentScrollController(initialItem: DateTime.now().day - DateTime.now().day);
  String _selectedhour = "";
  int _selected = 1;
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('fr'),
        initialDate: _currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageServices.getMessages();
    _feedbackServices.getTime(date: DateFormat("yyyy-MM-dd","fr").format(DateTime.now()), coach_id: subscriptionDetails.currentdata[0]['coach_id'].toString());
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
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    children: [
                      _selected == 2 ?
                      Text("Décrit les forces de cette semaine, les changements implémentés, tes succès mais aussi les difficultés face aux objectifs, les axes d’améliorations, les nouvelles difficultés rencontrées",style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),)
                      : Container(),
                      _selected == 2 ? Container() : Text("1 fois par semaine on fait le point. Choisis la manière dont tu veux faire le point avec ton coach. Un appel de 15 à 30 min ou si tu manques de temps cette semaine un message",style: TextStyle(fontFamily: "AppFontStyle"),),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
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
                      _selected == 2 ?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text("Message au coach :",style: new TextStyle(fontSize: 15,fontFamily: "AppFontStyle"),),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _message,
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              border: InputBorder.none,
                              hintText: "Saisir le message",
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
                        ],
                      ) : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text("DATE",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.calendar_month,size: 27,color: AppColors.appmaincolor,),
                                onPressed: (){
                                  _selectDate(context);
                                },
                              )
                            ],
                          ),
                          Container(
                            height: DeviceModel.isMobile ? 130 : 160,
                            child: RotatedBox(
                                quarterTurns: -1,
                                child: ClickableListWheelScrollView(
                                  scrollController: _scrollController,
                                  itemHeight: 55,
                                  itemCount: _selectedDate != null ? int.parse(DateTime(_selectedDate!.year, _selectedDate!.month + 1, 0).day.toString()) - _selectedDate!.day  + 1 : int.parse(DateTime(_currentDate.year, _currentDate.month + 1, 0).day.toString()) - _currentDate.day  + 1,
                                  child: ListWheelScrollView(
                                    onSelectedItemChanged: (x) {
                                      setState(() {
                                          selected = x;
                                          print(DateFormat("yyyy-MM-dd","fr").format(DateTime(DateTime.now().year, DateTime.now().month,x + DateTime.now().day)));
                                          _feedbackServices.getTime(date: DateFormat("yyyy-MM-dd","fr").format(DateTime(DateTime.now().year, DateTime.now().month,x + DateTime.now().day)), coach_id: subscriptionDetails.currentdata[0]['coach_id'].toString());
                                      });
                                    },
                                    controller: _scrollController,
                                    children: List.generate(
                                        _selectedDate != null ? int.parse(DateTime(_selectedDate!.year, _selectedDate!.month + 1, 0).day.toString()) - _selectedDate!.day + 1 : int.parse(DateTime(_currentDate.year, _currentDate.month + 1, 0).day.toString()) - _currentDate.day + 1,
                                            (x) => RotatedBox(
                                          quarterTurns: 1,
                                              child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 400),
                                                  height: 80 ,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: x == selected ? AppColors.appmaincolor : Colors.transparent,
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      _selectedDate != null ?
                                                      Text("${DateFormat('EEE',"fr").format(DateTime(_selectedDate!.year, _selectedDate!.month,x + _selectedDate!.day))[0].toUpperCase()}${DateFormat('EEE',"fr").format(DateTime(_selectedDate!.year, _selectedDate!.month,x + _selectedDate!.day,)).substring(1).toLowerCase()}",style: TextStyle(color: x == selected ? Colors.white : Colors.black,fontFamily: "AppFontStyle"),) :
                                                      Text("${DateFormat('EEE',"fr").format(DateTime(_currentDate.year, _currentDate.month,x + _currentDate.day,))[0].toUpperCase()}${DateFormat('EEE',"fr").format(DateTime(_currentDate.year, _currentDate.month,x + _currentDate.day,)).substring(1).toLowerCase()}",style: TextStyle(color: x == selected ? Colors.white : Colors.black,fontFamily: "AppFontStyle"),),
                                                      _selectedDate != null ?
                                                      Text('${x + _selectedDate!.day}',style: TextStyle(fontSize: 30,color: x == selected ? Colors.white : Colors.black,fontWeight: x == selected ? FontWeight.bold : FontWeight.w600,fontFamily: "AppFontStyle"),) :
                                                      Text('${x + _currentDate.day}',style: TextStyle(fontSize: 30,color: x == selected ? Colors.white : Colors.black,fontWeight: x == selected ? FontWeight.bold : FontWeight.w600,fontFamily: "AppFontStyle"),),
                                                    ],
                                                  )),
                                        )),
                                    itemExtent: 55,
                                  ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: _selectedDate != null ?
                            Text("${DateFormat('MMMM',"fr").format(_selectedDate!)[0].toUpperCase()}${DateFormat('MMMM',"fr").format(_selectedDate!).substring(1).toLowerCase()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle",color: AppColors.appmaincolor),) :
                            Text("${DateFormat('MMMM',"fr").format(_currentDate)[0].toUpperCase()}${DateFormat('MMMM',"fr").format(_currentDate).substring(1).toLowerCase()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle",color: AppColors.appmaincolor),),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text("HORAIRE",style: TextStyle(fontSize: 17,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                          !snapshot.hasData ?
                          TimeShimmerLoader() :
                          snapshot.data!["time"].isEmpty ? Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: NoDataFound(firstString: "PAS DE ", secondString: "créneaux disponible...".toUpperCase(), thirdString: "l’entraîneur n’a plus de disponibilités à cette date")) :
                          GridView.count(
                            padding: EdgeInsets.only(left: 5,bottom: 10,top: 20),
                            primary: false,
                            shrinkWrap: true,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 10,
                            crossAxisCount: DeviceModel.isMobile ? 3 : 4,
                            childAspectRatio: (1 / .4),
                            children: <Widget>[
                              for(var x = 0; x < snapshot.data!["time"].length; x++)...{
                                InkWell(
                                  child: Container(
                                    child: Center(child: Text(snapshot.data!["time"][x],style: TextStyle(fontSize: 17,color: _selectedhour == snapshot.data!["time"][x] ? Colors.white : Colors.black,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),)),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: _selectedhour == snapshot.data!["time"][x] ? Colors.transparent : Colors.black,width: 0.7),
                                        borderRadius: BorderRadius.circular(1000),
                                        color: _selectedhour == snapshot.data!["time"][x] ? AppColors.pinkColor : Colors.white
                                    ),
                                    margin: EdgeInsets.only(right: 5,bottom: 5),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      _selectedhour = snapshot.data!["time"][x];
                                    });
                                  },
                                )
                              },
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _selected == 2 ? DeviceModel.isMobile ? 70 : 300 : DeviceModel.isMobile ? 50 : 200,
                      ),
                      _materialbutton.materialButton("VALIDER", () {
                        if(_selected == 1){
                          if(snapshot.data!["time"].isEmpty){
                            _snackbarMessage.snackbarMessage(context, message: "Pas d'horaire pour le jour sélectionné !", is_error: true);
                          }else{
                            if(_selectedhour == ""){
                              _snackbarMessage.snackbarMessage(context, message: "Le temps de planification est requis !", is_error: true);
                            }else{
                              _screenLoaders.functionLoader(context);
                              _feedbackServices.submit(date_id: snapshot.data!["id_date"].toString(), time: _selectedhour).then((value){
                                if(value != null){
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
                          }
                        }else{
                          if(_message.text.isEmpty){
                            _snackbarMessage.snackbarMessage(context, message: "Écrivez quelque chose sur la zone de texte !", is_error: true);
                          }else{
                            _screenLoaders.functionLoader(context);
                            _messageServices.sendMessage(client_id: "1", message: _message.text.toString(), sender_type: "client", type: "text", base64Images: [], filename: []).then((value){
                              if(value != null){
                                Navigator.of(context).pop(null);
                                _message.text = "";
                                _snackbarMessage.snackbarMessage(context, message: "Une erreur s'est produite. Veuillez réessayerLe message a bien été envoyé à votre coach !",);
                              }else{
                                Navigator.of(context).pop(null);
                                _snackbarMessage.snackbarMessage(context, message: "Une erreur s'est produite. Veuillez réessayer.", is_error: true);
                              }
                            });
                          }
                        }
                      }),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
