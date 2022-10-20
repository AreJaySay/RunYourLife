import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:run_your_life/functions/base64_converter.dart';
import 'package:run_your_life/functions/create_video_player.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/messages/components/pin_messages.dart';
import 'package:run_your_life/screens/messages/components/received_ui.dart';
import 'package:run_your_life/screens/messages/components/sent_ui.dart';
import 'package:run_your_life/screens/messages/components/shimmer_loader.dart';
import 'package:run_your_life/services/apis_services/screens/messages.dart';
import 'package:run_your_life/services/other_services/push_notifications.dart';
import 'package:run_your_life/services/stream_services/screens/messages.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/backbutton.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:video_player/video_player.dart';
import '../../services/other_services/routes.dart';
import '../../widgets/materialbutton.dart';
import 'dart:ui' as ui;

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final CreateVideoPlayer _createVideoPlayer = new CreateVideoPlayer();
  final PushNotifications _pushNotifications = new PushNotifications();
  final Materialbutton _materialbutton = new Materialbutton();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final TextEditingController _controller = new TextEditingController();
  final MessageServices _messageServices = new MessageServices();
  final Routes _routes = new Routes();
  final Base64Converter _base64converter = new Base64Converter();
  final ScrollController _scrollController = new ScrollController();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  List<File> _fileImages = [];
  List<String> _pdfNames = [];
  List<String> _base64Images = [];
  bool _isVisible = false;
  bool _showFilePopup = false;
  String? _message;
  Widget? _sending;
  List<VideoPlayerController> _videocontroller = [];
  Future _takeImage(BuildContext context) async {
    await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        // allowedExtensions: [
        //   'jpg',
        //   'jpeg',
        //   'png',
        //   'gif',
        //   "tiff",
        //   "eps",
        //   "raw"
        // ]
    ).then((value) {
      if (value == null) return;
      for(int x = 0; x < value.paths.length; x++){
        setState(() {
          _fileImages.add(File(value.paths[x]!));
          _pdfNames.add("Image");
          Uint8List bytes = File(value.paths[x]!).readAsBytesSync();
          _base64Images.add("data:image/jpeg;base64,"+base64Encode(bytes));
          _showFilePopup = true;
        });
      }
    });
    Navigator.of(context).pop();
  }

  Future _pickImage(BuildContext context) async {
    var isPopup = false;
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          if (!isPopup) {
            isPopup = true;
            _takeImage(context);
          }
          return const Center();
        });
  }

  Future _pickFiles() async {
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    ).then((value) {
      setState(() {
        _fileImages.add(File(value!.files.single.path!));
        _pdfNames.add(value.names.single!);
        Uint8List bytes = File(value.files.single.path!).readAsBytesSync();
        _base64Images.add("data:file/pdf;base64," + base64Encode(bytes));
        _showFilePopup = true;
      });
    });
  }

  Future _pickVideo() async {
    await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'mp4',
      ],
    ).then((value) {
      setState(() {
        _fileImages.add(File(value!.files.single.path!));
        _pdfNames.add("Video");
        _createVideoPlayer
            .createVideoPlayer(fileimage: File(value.files.single.path!))
            .then((value) {
          setState(() {
            _videocontroller.add(value);
          });
        });
        Uint8List bytes = File(value.files.single.path!).readAsBytesSync();
        _base64Images.add("data:video/mpeg;base64," + base64Encode(bytes));
        _showFilePopup = true;
        print("Videos ${_fileImages.toString()}");
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      // _pushNotifications.initialize(context);
    } catch (e) {
      print("PUSH ERROR ${e.toString()}");
    }
    _messageServices.getMessages();
    KeyboardVisibilityController().onChange.listen((event) {
      setState(() {
        _isVisible = event;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return StreamBuilder<List>(
        stream: messageStreamServices.subject,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              return true;
            },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80), // here the desired height
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius:
                            3.0, // has the effect of softening the shadow
                        spreadRadius:
                            1.0, // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          3.5, // vertical, move down 10
                        ),
                      )
                    ],
                  ),
                  child: SafeArea(
                    child: Center(
                      child: Row(
                        children: [
                          PageBackButton(
                            isMessage: true,
                          ),
                          !snapshot.hasData
                              ? _shimmeringLoader.pageLoader(
                                  radius: 1000, width: 55, height: 55)
                              : Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(1000),
                                      image: messageStreamServices
                                                  .currentcoach["logo"] ==
                                              null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/icons/no_profile.png"))
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  messageStreamServices
                                                      .currentcoach["logo"]))),
                                ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              !snapshot.hasData
                                  ? _shimmeringLoader.pageLoader(
                                      radius: 5, width: 180, height: 20)
                                  : Text(
                                      messageStreamServices
                                          .currentcoach["full_name"],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "AppFontStyle"),
                                    ),
                              SizedBox(
                                height: 2,
                              ),
                              !snapshot.hasData
                                  ? _shimmeringLoader.pageLoader(
                                      radius: 5, width: 120, height: 15)
                                  : Row(
                                      children: [
                                        Text(
                                          "MON ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.pinkColor,
                                              fontFamily: "AppFontStyle"),
                                        ),
                                        Text(
                                          "COACH",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.pinkColor,
                                              fontFamily: "AppFontStyle",
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          Spacer(),
                          !snapshot.hasData
                              ? Container()
                              : IconButton(
                                  icon: Image(
                                    width: 20,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    color: AppColors.appmaincolor,
                                    image: AssetImage("assets/icons/pin.png"),
                                  ),
                                  onPressed: () {
                                    _routes.navigator_push(
                                        context,
                                        PinMessages(messageStreamServices
                                            .currentcoach));
                                  },
                                ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/important_assets/heart_icon.png"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView(
                          controller: _scrollController,
                          reverse: true,
                          padding: EdgeInsets.only(bottom: 15, top: 25),
                          children: [
                            if (!snapshot.hasData) ...{
                              MessageShimmerLoader()
                            } else if (snapshot.data!.isEmpty) ...{
                              Padding(
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 40,
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                color: Colors.grey[300],
                                                image: Auth.loggedUser![
                                                            "logo"] ==
                                                        null
                                                    ? DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "assets/icons/my_profile.png"))
                                                    : DecorationImage(
                                                        fit: BoxFit.fitWidth,
                                                        image: NetworkImage(
                                                            Auth.loggedUser![
                                                                "logo"]))),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(1000),
                                              image: messageStreamServices
                                                              .currentcoach[
                                                          "logo"] ==
                                                      null
                                                  ? DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/icons/no_profile.png"))
                                                  : DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          messageStreamServices
                                                                  .currentcoach[
                                                              "logo"]))),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Vous pouvez maintenant commencer la conversation avec ${messageStreamServices.currentcoach["full_name"]}.",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "AppFontStyle",
                                          color: Colors.grey[600]),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 30),
                              ),
                            } else ...{
                              _sending == null
                                  ? Container()
                                  : Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          _sending!,
                                          _fileImages.length == 0
                                              ? SizedBox(
                                                  height: 8,
                                                )
                                              : SizedBox(
                                                  height: _fileImages[0]
                                                          .toString()
                                                          .contains(".pdf")
                                                      ? 0
                                                      : 8,
                                                ),
                                          Text(
                                            "Envoi en cours",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                              for (var x = 0;
                                  x < snapshot.data!.length;
                                  x++) ...{
                                snapshot.data![snapshot.data!.length - x - 1]
                                            ["sender_type"] ==
                                        "client"
                                    ? SentDesign(
                                        details: snapshot.data![
                                            snapshot.data!.length - x - 1],
                                      )
                                    : RecievedDesign(
                                        details: snapshot.data![
                                            snapshot.data!.length - x - 1],
                                      )
                              },
                            },
                          ],
                        )),
                        SafeArea(
                          child: Column(
                            children: [
                              !_showFilePopup
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.only(top: 10),
                                      width: double.infinity,
                                      height: 85,
                                      alignment: Alignment.bottomCenter,
                                      color: Colors.white,
                                      child: ListView(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          for (var x = 0;
                                              x < _fileImages.length;
                                              x++) ...{
                                            Stack(
                                              children: [
                                                _fileImages[x]
                                                        .toString()
                                                        .contains(".pdf")
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: 5),
                                                        width: 70,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Image(
                                                              width: 45,
                                                              color: AppColors
                                                                  .appmaincolor,
                                                              image: AssetImage(
                                                                  "assets/icons/pdf.png"),
                                                            ),
                                                            Text(_pdfNames[x],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    fontFamily:
                                                                        "AppFontStyle"),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis)
                                                          ],
                                                        ),
                                                      )
                                                    : _fileImages[x]
                                                            .toString()
                                                            .contains(".mp4")
                                                        ? Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            width: 70,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[200],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Center(
                                                              child: Image(
                                                                width: 45,
                                                                color: AppColors
                                                                    .appmaincolor,
                                                                image: AssetImage(
                                                                    "assets/icons/video.png"),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            width: 70,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: FileImage(
                                                                        _fileImages[
                                                                            x]))),
                                                          ),
                                                Container(
                                                  width: 70,
                                                  child: InkWell(
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 18,
                                                        color: Colors.white,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .appmaincolor
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      1000)),
                                                      padding:
                                                          EdgeInsets.all(3),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        _fileImages.remove(
                                                            _fileImages[x]);
                                                        if (_pdfNames.length !=
                                                            0) {
                                                          _pdfNames.remove(
                                                              _pdfNames[x]);
                                                        }
                                                        if (_fileImages
                                                                .length ==
                                                            0) {
                                                          _showFilePopup =
                                                              false;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  alignment: Alignment.topRight,
                                                )
                                              ],
                                            )
                                          }
                                        ],
                                      ),
                                    ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: double.infinity,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 15),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.appmaincolor),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                maxLines: null,
                                                controller: _controller,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                          vertical: 10),
                                                  border: InputBorder.none,
                                                  hintText: "Écrire ici…",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    _message = text;
                                                  });
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible: !_isVisible,
                                              child: InkWell(
                                                child: Icon(
                                                  Icons.image,
                                                  size: 27,
                                                  color: AppColors.appmaincolor,
                                                ),
                                                onTap: () {
                                                  _pickImage(context);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: !_isVisible ?  10 : 0,
                                            ),
                                            Visibility(child: InkWell(
                                              child: Icon(
                                                Icons.file_present,
                                                size: 25,
                                                color: AppColors
                                                    .appmaincolor,
                                              ),
                                              onTap: () {
                                                _pickFiles();
                                              },
                                            ),visible: !_isVisible,),
                                            SizedBox(
                                              width: _isVisible ? 0 : 10,
                                            ),
                                            Visibility(child: InkWell(
                                              child: Icon(
                                                Icons.play_circle,
                                                size: 25,
                                                color: AppColors
                                                    .appmaincolor,
                                              ),
                                              onTap: () {
                                                _pickVideo();
                                              },
                                            ),visible: !_isVisible,),
                                            SizedBox(
                                              width: _isVisible ? 0 : 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            color: AppColors.pinkColor),
                                        child: Center(
                                          child: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        if(_controller.text.isNotEmpty || _fileImages.length != 0){
                                          print(_fileImages.toString());
                                          setState(() {
                                            _scrollController.animateTo(
                                              0.0,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            );
                                            _sending = _fileImages.isNotEmpty ? _fileImages[0]
                                                .toString()
                                                .contains(".pdf")
                                                ? Column(
                                              children: [
                                                for (int x = 0;
                                                x <
                                                    _fileImages
                                                        .length;
                                                x++) ...{
                                                  Container(
                                                    margin:
                                                    EdgeInsets.only(
                                                        left: 70,
                                                        bottom: 10),
                                                    height: 70,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .end,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .end,
                                                      children: [
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                          children: [
                                                            _shimmeringLoader.pageLoader(
                                                                radius:
                                                                5,
                                                                width:
                                                                180,
                                                                height:
                                                                10),
                                                            _shimmeringLoader.pageLoader(
                                                                radius:
                                                                2,
                                                                width:
                                                                130,
                                                                height:
                                                                10),
                                                            _shimmeringLoader.pageLoader(
                                                                radius:
                                                                2,
                                                                width:
                                                                150,
                                                                height:
                                                                10)
                                                          ],
                                                        ),
                                                        Image(
                                                          color: Colors
                                                              .black54,
                                                          image: AssetImage(
                                                              "assets/icons/pdf.png"),
                                                        ),
                                                      ],
                                                    ),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical:
                                                        10),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .white,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5)),
                                                  ),
                                                }
                                              ],
                                            )
                                                : _fileImages[0]
                                                .toString()
                                                .contains(".mp4")
                                                ? Container(
                                                padding:
                                                EdgeInsets.only(
                                                    left: 50),
                                                width:
                                                double.infinity,
                                                alignment: Alignment
                                                    .centerRight,
                                                child: Directionality(
                                                  textDirection: ui
                                                      .TextDirection
                                                      .rtl,
                                                  child:
                                                  GridView.count(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    crossAxisSpacing:
                                                    5,
                                                    mainAxisSpacing:
                                                    5,
                                                    crossAxisCount: 3,
                                                    childAspectRatio: (_size
                                                        .width /
                                                        2 /
                                                        (_size.height -
                                                            kToolbarHeight -
                                                            5) /
                                                        0.3),
                                                    children: <
                                                        Widget>[
                                                      for (var x = 0;
                                                      x <
                                                          _videocontroller
                                                              .length;
                                                      x++) ...{
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                color:
                                                                Colors.grey[300],
                                                                borderRadius:
                                                                BorderRadius.circular(3.5),
                                                              ),
                                                              child: _videocontroller[x].value.isInitialized
                                                                  ? VideoPlayer(
                                                                _videocontroller[x],
                                                              )
                                                                  : Container(),
                                                            ),
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                color:
                                                                Colors.white30,
                                                                borderRadius:
                                                                BorderRadius.circular(3.5),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                CircularProgressIndicator(
                                                                  strokeWidth:
                                                                  3,
                                                                  color:
                                                                  AppColors.darpinkColor,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      }
                                                    ],
                                                  ),
                                                ))
                                                : Container(
                                                padding:
                                                EdgeInsets.only(
                                                    left: 50),
                                                width:
                                                double.infinity,
                                                alignment: Alignment
                                                    .centerRight,
                                                child: Directionality(
                                                  textDirection: ui
                                                      .TextDirection
                                                      .rtl,
                                                  child:
                                                  GridView.count(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    crossAxisSpacing:
                                                    5,
                                                    mainAxisSpacing:
                                                    5,
                                                    crossAxisCount: 3,
                                                    childAspectRatio: (_size
                                                        .width /
                                                        2 /
                                                        (_size.height -
                                                            kToolbarHeight -
                                                            5) /
                                                        0.3),
                                                    children: <
                                                        Widget>[
                                                      for (var x = 0;
                                                      x <
                                                          _fileImages
                                                              .length;
                                                      x++) ...{
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                  Colors.grey[300],
                                                                  borderRadius: BorderRadius.circular(3.5),
                                                                  image: DecorationImage(fit: BoxFit.cover, image: FileImage(_fileImages[x]))),
                                                              // child: Image.memory(myImage[x]),
                                                            ),
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                color:
                                                                Colors.white30,
                                                                borderRadius:
                                                                BorderRadius.circular(3.5),
                                                              ),
                                                              child:
                                                              Center(
                                                                child:
                                                                CircularProgressIndicator(
                                                                  strokeWidth:
                                                                  3,
                                                                  color:
                                                                  AppColors.darpinkColor,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      }
                                                    ],
                                                  ),
                                                ))
                                                : Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                  color: Colors.white),
                                              child: Text(_controller.text),
                                            );
                                            _controller.text = "";
                                            _showFilePopup = false;
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            _messageServices.sendMessage(client_id: "1", message: _message.toString(), sender_type: "client", type: _fileImages.length == 0 ? "text" : "files",
                                              base64Images:
                                              _fileImages.length == 0
                                                  ? []
                                                  : _base64Images,
                                              filename: _fileImages.length == 0
                                                  ? []
                                                  : _pdfNames,
                                            )
                                                .then((value) {
                                              if (value != null) {
                                                setState(() {
                                                  _sending = null;
                                                  _fileImages.clear();
                                                  _base64Images.clear();
                                                });
                                              } else {
                                                setState(() {
                                                  _sending = null;
                                                  _fileImages.clear();
                                                  _base64Images.clear();
                                                });
                                                _snackbarMessage.snackbarMessage(
                                                    context,
                                                    message:
                                                    "Une erreur s'est produite. Veuillez réessayer.",
                                                    is_error: true);
                                              }
                                            });
                                          });
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
