import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/add_photo_components/describe_photo.dart';
import 'package:run_your_life/services/apis_services/screens/checkin.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';

import '../../../../../widgets/image_picker.dart';

class AddPhotos extends StatefulWidget {
  @override
  _AddPhotosState createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  final Materialbutton _materialbutton = new Materialbutton();
  final CheckinServices _checkinServices = new CheckinServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final Routes _routes = new Routes();
  final AppBars _appBars = AppBars();
  List<File> _fileImages = [];
  void takeImage(BuildContext context) async {
    await FilePicker.platform.pickFiles(
          type: FileType.image,
          // allowedExtensions: [
          //   'jpg',
          //   'jpeg',
          //   'png',
          //   'gif',
          //   "tiff",
          //   "eps",
          //   "raw"
          // ],
          allowMultiple: false,
        )
        .then((value) {
          if(value != null && value.paths.isNotEmpty){
            final File file = File(value.paths[0]!);
            setState(() {
              _fileImages.add(file);
            });
            Navigator.of(context).pop();
            _routes.navigator_push(context, DescribePhoto(file), transitionType: PageTransitionType.rightToLeftWithFade);
          }else{
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
    });
  }

  Future _pickImage(BuildContext context) async {
    var isPopup = false;

    await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          if (!isPopup) {
            isPopup = true;
            takeImage(context);
          }
          return const Center();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
          context: context, builder: (context){
        return ImagePicker();
      }).then((value)async{
        setState((){
          if(value != null){
            final File file = File(value.path);
            setState(() {
              _fileImages.add(file);
            });
            Navigator.of(context).pop();
            _routes.navigator_push(context, DescribePhoto(file), transitionType: PageTransitionType.rightToLeftWithFade);
          }else{
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        });
      });
    });
    super.initState();
    // initPlatformState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.whiteappbar(context, title: "AJOUTER UNE PHOTO"),
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        5.0, // horizontal, move right 10
                        0.0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _materialbutton.materialButton("VALIDER", () {
                      _screenLoaders.functionLoader(context);
                      _checkinServices.getPhotos(context).whenComplete(() {
                        Navigator.of(context).pop(null);
                        Navigator.of(context).pop(null);

                      });
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      child:  Container(
                        width: double.infinity,
                        height: 55,
                        child: Center(
                          child: Text(
                            "ANNULER",
                            style: TextStyle(
                                fontFamily: "AppFontStyle",
                                color: AppColors.darpinkColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(null);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
