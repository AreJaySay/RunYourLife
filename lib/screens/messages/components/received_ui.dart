import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/services/apis_services/screens/messages.dart';
import 'package:run_your_life/services/stream_services/screens/messages.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'images_message.dart';
import 'package:intl/intl.dart';

class RecievedDesign extends StatefulWidget {
  final Map details;
  RecievedDesign({required this.details});
  @override
  _RecievedDesignState createState() => _RecievedDesignState();
}

class _RecievedDesignState extends State<RecievedDesign> {
  final MessageServices _messageServices = new MessageServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.details["type"] == "files" ?
        widget.details["message"] == null ? Container() :
        Container(
          padding: EdgeInsets.only(right: 70,left: 20),
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: ImagesMessages(false, jsonDecode(widget.details["message"]),widget.details),
        ) :
        GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 20,right: 70,bottom: 8),
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              decoration: BoxDecoration(
                  color: AppColors.appmaincolor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10)
                  )
              ),
              child: Text(widget.details["message"],style: TextStyle(color: Colors.white),),
            ),
          ),
          onLongPress: (){
            showModalBottomSheet(
                context: context, builder: (context){
              return _messageAction(details: widget.details);
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: DateFormat.yMMMd("fr").format(DateTime.parse(widget.details["created_at"].toString())) == DateFormat.yMMMd("fr").format(DateTime.now()) ?
          Text("Aujourd'hui, ${DateFormat("HH:mm").format(DateTime.parse(widget.details["created_at"].toString()))}",style: TextStyle(fontSize: 11,color: Colors.grey),) :
          Text(DateFormat.yMMMd("fr").format(DateTime.parse(widget.details["created_at"].toString())),style: TextStyle(fontSize: 11,color: Colors.grey),),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
  Widget _messageAction({required Map details}){
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(1000)
                    ),
                    child: Center(child: Icon(Icons.file_copy)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Copie",style: TextStyle(fontSize: 15,color: Colors.black))
                ],
              ),
            ),
            onTap: (){
              Clipboard.setData(ClipboardData(text: details["message"]));
            },
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(1000)
                    ),
                    child: Center(child: Image(
                      width: 20,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      image: AssetImage("assets/icons/pin.png"),
                    )),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Épingler message",style: TextStyle(fontSize: 15,color: Colors.black))
                ],
              ),
            ),
            onTap: (){
              _screenLoaders.functionLoader(context);
              _messageServices.pinMessage(context,id: details["id"].toString(), status: "1").then((value){
                Navigator.of(context).pop(null);
                Navigator.of(context).pop(null);
                _snackbarMessage.snackbarMessage(context, message: "Message has been pinned.");
                print("PIN ${value.toString()}");
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(1000)
                    ),
                    child: Center(child: Icon(Icons.delete)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Supprimer",style: TextStyle(fontSize: 15,color: Colors.red))
                ],
              ),
            ),
            onTap: (){
              setState((){
                _messageServices.deleteMessage(id: widget.details["id"].toString()).whenComplete((){
                  messageStreamServices.currentdata.remove(widget.details);
                  messageStreamServices.updatemessages(data: messageStreamServices.currentdata);
                  Navigator.of(context).pop(null);
                });
              });
            },
          )
        ],
      ),
    );
  }
}
