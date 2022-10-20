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

  // Future<void> initPlatformState() async {
  //   String? platformVersion;
  //   try {
  //
  //     // platformVersion = await FlutterImagesPicker.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //
  //   if (!mounted) return;
  // }

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
    // List<File?> images = await FlutterImagesPicker.pickImages(maxImages: 1,).then((value)async{
    //   for(int x = 0; x < value.length; x++){
    //     setState(() {
    //       _fileImages.add(File(value[x].path));
    //     });
    //     Navigator.of(context).pop();
    //     _routes.navigator_push(context, DescribePhoto(File(value[x].path)), transitionType: PageTransitionType.rightToLeftWithFade);
    //   }
    //   return value;
    // });
    // Navigator.of(context).pop();
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
      await _pickImage(context);
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
            // FadeInImage(
            //   fit: BoxFit.cover,
            //   placeholder: MemoryImage(kTransparentImage),
            //   image: ThumbnailProvider(
            //     mediumId: "photos",
            //     mediumType: MediumType.image,
            //     width: 128,
            //     height: 128,
            //     highQuality: true,
            //   ),
            // ),
            // GridView.count(
            //   padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 200),
            //   primary: false,
            //   shrinkWrap: true,
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   crossAxisCount: DeviceModel.isMobile ? 3 : 4,
            //   children: <Widget>[
            //     InkWell(
            //       onTap: (){
            //         _pickImage(context);
            //       },
            //       child: Container(
            //         decoration: BoxDecoration(
            //           color: AppColors.pinkColor,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Center(
            //           child: Icon(Icons.camera_alt,color: Colors.white,size: 30,),
            //         ),
            //       ),
            //     ),
            //     for(var x = 0; x < _fileImages.length; x++)...{
            //       InkWell(
            //         onTap: (){
            //           _routes.navigator_push(context, DescribePhoto(_fileImages[x]), transitionType: PageTransitionType.rightToLeftWithFade);
            //         },
            //         child: Container(
            //           decoration: BoxDecoration(
            //               color: Colors.grey[300],
            //               borderRadius: BorderRadius.circular(10),
            //               image: DecorationImage(
            //                   fit: BoxFit.cover,
            //                   image: FileImage(_fileImages[x])
            //               )
            //           ),
            //         ),
            //       )
            //     }
            //    ],
            // ),
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
