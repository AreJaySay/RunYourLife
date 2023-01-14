import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/messages/components/images_message.dart';
import 'package:run_your_life/services/apis_services/screens/messages.dart';
import 'package:run_your_life/services/stream_services/screens/messages.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';

class PinMessages extends StatefulWidget {
  final Map coachdetails;
  PinMessages(this.coachdetails);
  @override
  State<PinMessages> createState() => _PinMessagesState();
}

class _PinMessagesState extends State<PinMessages> {
  final AppBars _appBars = new AppBars();
  final MessageServices _messageServices = new MessageServices();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageServices.getPinnedMessages();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: messageStreamServices.pinned,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: _appBars.whiteappbar(context, title: "Messages épinglés"),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: !snapshot.hasData ?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for(int x = 0; x < 6; x++)...{
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmeringLoader.pageLoader(radius: 1000, width: 35, height: 35),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 30,bottom: 8),
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              decoration: BoxDecoration(
                                  color: x.isEven ? Colors.white : Color.fromRGBO(68, 169, 204,0.9).withOpacity(0.6),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10)
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _shimmeringLoader.pageLoader(radius: 5, width: 230, height: 10),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _shimmeringLoader.pageLoader(radius: 5, width: 150, height: 10),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _shimmeringLoader.pageLoader(radius: 5, width: 200, height: 10),
                                ],
                              ),
                              ),
                            ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  }
                ],
              ),
            ) :
            snapshot.data!.isEmpty?
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("AUCUN ",style: TextStyle(fontSize: 16,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                        Text("MESSAGE ÉPINGLÉ TROUVÉ...",style: TextStyle(fontSize: 16,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Ce chat direct n'a pas de messages épinglés .. pour le moment !",style: TextStyle(fontSize: 15.5,color: Colors.black,fontFamily: "AppFontStyle"),textAlign: TextAlign.center,),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ) :
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    snapshot.data![index]["sender_type"] == "client" ?
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: Colors.grey[300],
                          image: Auth.loggedUser!["logo"] == null ?
                          DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/icons/my_profile.png")
                          ) :
                          DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(Auth.loggedUser!["logo"])
                          )
                      ),
                    ) :
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(1000),
                          image: widget.coachdetails["logo"] == null ?
                          DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/icons/no_profile.png")
                          ) :
                          DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.coachdetails["logo"])
                          )
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          snapshot.data![index]["type"] == "files" ?
                          snapshot.data![index]["message"] == null ? Container() :
                          Container(
                            padding: EdgeInsets.only(right: 30,left: 10),
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: ImagesMessages(false, jsonDecode(snapshot.data![index]["message"]),snapshot.data![index]),
                          ) :
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 30,bottom: 8),
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                              decoration: BoxDecoration(
                                  color: snapshot.data![index]["sender_type"] == "client" ? Colors.white : AppColors.appmaincolor,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10)
                                  )
                              ),
                              child: Text(snapshot.data![index]["message"],style: TextStyle(color: snapshot.data![index]["sender_type"] == "client" ? Colors.black : Colors.white),),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: DateFormat.yMMMd("fr").format(DateTime.parse(snapshot.data![index]["created_at"].toString())) == DateFormat.yMMMd("fr").format(DateTime.now().toUtc().add(Duration(hours: 2))) ?
                            Text("Aujourd'hui, ${DateFormat("HH:mm").format(DateTime.parse(snapshot.data![index]["created_at"].toString()))}",style: TextStyle(fontSize: 11,color: Colors.grey),) :
                            Text(DateFormat.yMMMd("fr").format(DateTime.parse(snapshot.data![index]["created_at"].toString())),style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Icon(Icons.remove_circle,color: AppColors.pinkColor,),
                      onTap: (){
                        _screenLoaders.functionLoader(context);
                        _messageServices.pinMessage(context,id: snapshot.data![index]["id"].toString(), status: "0").then((value){
                          setState((){
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                          Navigator.of(context).pop(null);
                          _snackbarMessage.snackbarMessage(context, message: "Message has been unpinned.");
                          print("PIN ${value.toString()}");
                        });
                      },
                    )
                  ],
                );
              },
            )
          ),
        );
      }
    );
  }
}
