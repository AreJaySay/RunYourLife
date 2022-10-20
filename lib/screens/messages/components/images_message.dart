import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_your_life/functions/base64_converter.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'dart:io';
import 'package:bouncy_widget/bouncy_widget.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:video_player/video_player.dart';

import '../../../functions/loaders.dart';
import '../../../services/apis_services/screens/messages.dart';
import '../../../services/stream_services/screens/messages.dart';

class ImagesMessages extends StatefulWidget {
  final bool ismine;
  final List datas;
  final Map details;
  ImagesMessages(this.ismine,this.datas,this.details);
  @override
  _ImagesMessagesState createState() => _ImagesMessagesState();
}

class _ImagesMessagesState extends State<ImagesMessages> {
  final MessageServices _messageServices = new MessageServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Base64Converter _base64converter = new Base64Converter();
  String _isdownloading = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return widget.datas.toString().contains(".pdf") ?
      Column(
        children: [
          for(int x = 0; x < widget.datas.length; x++)...{
           widget.ismine ?
           Container(
             height: 60,
             child: Row(
               children: [
                 _isdownloading ==  widget.datas[x].toString()+x.toString() ? Container(
                   margin: EdgeInsets.only(left: 12),
                   child: Bouncy(
                       duration: Duration(milliseconds: 1000),
                       lift: 15,
                       ratio: 0.3,
                       pause: 0.2,
                       child: Icon(Icons.download,color: widget.ismine ? AppColors.appmaincolor : Colors.white,)),
                 ) :
                 IconButton(
                   onPressed: (){
                     setState((){
                       _isdownloading = widget.datas[x].toString()+x.toString();
                       _base64converter.networkImageToBase64(widget.datas[x]["file"]).then((value){
                         setState((){
                           _isdownloading = "";
                         });
                         if(value != null){
                           _snackbarMessage.snackbarMessage(context, message: "Le fichier a été téléchargé et enregistré avec succès dans le dossier de votre appareil..");
                         }
                       });
                       // _isdownloading = widget.datas[x].toString()+x.toString();
                       // _base64converter.createFileFromString(base64String:  widget.datas[x]["file"].toString().replaceAll("data:application/pdf;base64,", "")).then((value){
                       //   setState((){
                       //     _isdownloading = "";
                       //   });
                       //   if(value != null){
                       //     _snackbarMessage.snackbarMessage(context, message: "Le fichier a été téléchargé et enregistré avec succès dans le dossier de votre appareil..");
                       //   }
                       // });
                     });
                   },
                   icon: Icon(Icons.download,color: widget.ismine ? AppColors.appmaincolor : Colors.white,),
                 ),
                 Expanded(
                   child: Text(widget.datas[x]["file_name"].toString(),style: TextStyle(fontSize: 12,color: widget.ismine ? Colors.black54 : Colors.white),maxLines: 3,overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
                 ),
                 Image(
                   color: widget.ismine ? AppColors.appmaincolor : Colors.white,
                   image: AssetImage("assets/icons/pdf.png"),
                 ),
                 SizedBox(
                   width: 5,
                 )
               ],
             ),
             padding: EdgeInsets.symmetric(vertical: 10),
             decoration: BoxDecoration(
                 color: widget.ismine ? Colors.white : AppColors.appmaincolor,
                 borderRadius: BorderRadius.circular(5)
             ),
           ) :
           Container(
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Image(
                    color: widget.ismine ? AppColors.appmaincolor : Colors.white,
                    image: AssetImage("assets/icons/pdf.png"),
                  ),
                  Expanded(
                    child: Text(widget.datas[x]["file_name"].toString(),style: TextStyle(fontSize: 12,color: widget.ismine ? Colors.black54 : Colors.white),maxLines: 3,overflow: TextOverflow.ellipsis,textAlign: TextAlign.left,),
                  ),
                  _isdownloading ==  widget.datas[x].toString()+x.toString() ? Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Bouncy(
                        duration: Duration(milliseconds: 1000),
                        lift: 15,
                        ratio: 0.3,
                        pause: 0.2,
                        child: Icon(Icons.download,color: widget.ismine ? AppColors.appmaincolor : Colors.white,)),
                  ) :
                  IconButton(
                    onPressed: (){
                      setState((){
                        _isdownloading = widget.datas[x].toString()+x.toString();
                        _base64converter.networkImageToBase64(widget.datas[x]["file"]).then((value){
                          setState((){
                            _isdownloading = "";
                          });
                          if(value != null){
                            _snackbarMessage.snackbarMessage(context, message: "Le fichier a été téléchargé et enregistré avec succès dans le dossier de votre appareil..");
                          }
                        });
                        // _isdownloading = widget.datas[x].toString()+x.toString();
                        // _base64converter.createFileFromString(base64String:  widget.datas[x]["file"].toString().replaceAll("data:application/pdf;base64,", "")).then((value){
                        //   setState((){
                        //     _isdownloading = "";
                        //   });
                        //   if(value != null){
                        //     _snackbarMessage.snackbarMessage(context, message: "Le fichier a été téléchargé et enregistré avec succès dans le dossier de votre appareil..");
                        //   }
                        // });
                      });
                    },
                    icon: Icon(Icons.download,color: widget.ismine ? AppColors.appmaincolor : Colors.white,),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: widget.ismine ? Colors.white : AppColors.appmaincolor,
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
            SizedBox(
              height: 8,
            )
          },
        ],
      ) :
    // Column(
    //   children: [
    //     for(int x = 0; x < widget.datas.length; x++)...{
    //       InkWell(
    //         onTap: (){
    //           print(widget.datas[x].toString());
    //         },
    //         child: Text(widget.datas[x].toString()),
    //       )
    //     }
    //   ],
    // );
    Container(
        child: Directionality(
        textDirection: widget.ismine ? TextDirection.rtl : TextDirection.ltr,
        child: GridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 3,
          childAspectRatio: (_size.width / 2 / (_size.height - kToolbarHeight - 5) / 0.3),
          children: <Widget>[
            for(var x = 0; x < widget.datas.length; x++)...{
              GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Image(
                            image: NetworkImage(widget.datas[x]["file"])
                        ),
                      )
                  );
                },
                onLongPress: (){
                  showModalBottomSheet(
                      context: context, builder: (context){
                    return _messageAction(details: widget.details);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3.5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                          image: NetworkImage(widget.datas[x]["file"])
                      )
                  ),
                ),
              )
            }
          ],
        ),
    ),
      margin: EdgeInsets.only(bottom: 8),
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
                _screenLoaders.functionLoader(context);
                _messageServices.deleteMessage(id: details["id"].toString()).whenComplete((){
                  messageStreamServices.currentdata.remove(details);
                  messageStreamServices.updatemessages(data: messageStreamServices.currentdata);
                  Navigator.of(context).pop(null);
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
