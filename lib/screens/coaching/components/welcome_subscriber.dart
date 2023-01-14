// import 'package:flutter/material.dart';
// import 'package:run_your_life/functions/loaders.dart';
// import 'package:run_your_life/models/auths_model.dart';
// import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/presentation/main_page.dart';
// import 'package:run_your_life/screens/coaching/subscription/pack_solo/presentation/main_page.dart';
// import 'package:run_your_life/services/apis_services/credentials/auths.dart';
// import 'package:run_your_life/services/apis_services/screens/profile.dart';
// import 'package:run_your_life/services/apis_services/subscriptions/step3subs.dart';
// import 'package:run_your_life/services/apis_services/subscriptions/step5subs.dart';
// import 'package:run_your_life/services/apis_services/subscriptions/step6subs.dart';
// import 'package:run_your_life/services/apis_services/subscriptions/step7subs.dart';
// import 'package:run_your_life/utils/palettes/app_colors.dart';
// import 'package:run_your_life/services/other_services/routes.dart';
// import 'package:run_your_life/widgets/appbar.dart';
// import 'package:run_your_life/widgets/materialbutton.dart';
// class SubscriberWelcome extends StatefulWidget {
//   final Map choosenSubs, planDetails;
//   SubscriberWelcome({required this.choosenSubs, required this.planDetails});
//   @override
//   _SubscriberWelcomeState createState() => _SubscriberWelcomeState();
// }
//
// class _SubscriberWelcomeState extends State<SubscriberWelcome> {
//   final Materialbutton _materialbutton = new Materialbutton();
//   final ProfileServices _profileServices = new ProfileServices();
//   final Step5Service _step5service = new Step5Service();
//   final Step6Service _step6service = new Step6Service();
//   final Step7Service _step7service = new Step7Service();
//   final ScreenLoaders _screenLoaders = new ScreenLoaders();
//   final Routes _routes = new Routes();
//   final AppBars _appBars = AppBars();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBars.preferredSize(height: 56,logowidth: 95),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("BIENVENUE",style: TextStyle(fontSize: 29,color: AppColors.appmaincolor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
//             Text(Auth.loggedUser!["full_name"].toString().toUpperCase(),style: TextStyle(fontSize: 29,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
//             SizedBox(
//               height: 30,
//             ),
//             Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
//             style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Text("QUESTIONNAIRE",style: TextStyle(fontSize: 19,color: AppColors.pinkColor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
//             SizedBox(
//               height: 5,
//             ),
//             Text(widget.planDetails['name'].toString().toUpperCase(),style: TextStyle(fontSize: 19,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
//             SizedBox(
//               height: 5,
//             ),
//             Text("10 minutes",style: TextStyle(color: Colors.grey,fontFamily: "AppFontStyle"),),
//             Spacer(),
//             _materialbutton.materialButton("COMMENCER", () {
//               if(widget.planDetails["id"] == 2){
//                 _screenLoaders.functionLoader(context);
//                 _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString()).then((result){
//                   if(result != null){
//                     Navigator.of(context).pop(null);
//                     _routes.navigator_pushreplacement(context, PresentationMainPage(),);
//                   }else{
//                     Navigator.of(context).pop(null);
//                   }
//                 });
//               }else{
//                 _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString()).then((result){
//                   if(result != null){
//                     Navigator.of(context).pop(null);
//                     _routes.navigator_pushreplacement(context, PackSoloPresentationMainPage(),);
//                   }else{
//                     Navigator.of(context).pop(null);
//                   }
//                 });
//               }
//             }),
//             SizedBox(
//               height: 15,
//             ),
//             InkWell(
//               child: Container(
//                 width: double.infinity,
//                 height: 55,
//                 child: Center(
//                   child: Text("PLUS TARD",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600),),
//                 ),
//               ),
//               onTap: (){
//                 Navigator.of(context).pop(null);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
