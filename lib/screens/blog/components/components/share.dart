// import 'package:flutter/material.dart';
// import 'package:flutter_share_me/flutter_share_me.dart';
//
// class ShareBlog extends StatefulWidget {
//   final Map blogdetail;
//   ShareBlog({required this.blogdetail});
//   @override
//   State<ShareBlog> createState() => _ShareBlogState();
// }
//
// class _ShareBlogState extends State<ShareBlog> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 240,
//       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text("Share with:",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "AppFontStyle"),),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 child: Column(
//                   children: [
//                     Icon(Icons.telegram,size: 50,color: Color.fromRGBO(40, 158, 212, 0.9),),
//                     Text("Telegram",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
//                   ],
//                 ),
//                 onTap: (){
//                   FlutterShareMe().shareToTelegram(msg: "RUN YOUR LIFE").then((value){
//                     print("RETURN ${value.toString()}");
//                   });
//                 },
//               ),
//               GestureDetector(
//                 child: Column(
//                   children: [
//                     Icon(Icons.facebook,size: 50,color: Color.fromRGBO(59, 89, 151, 0.9),),
//                     Text("Facebook",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
//                   ],
//                 ),
//                 onTap: (){
//                   FlutterShareMe().shareToFacebook(url: "https://dev-front.runyourlife.checkmy.dev/blog/${widget.blogdetail["id"].toString()}/shared_preview", msg: "RUN YOUR LIFE").then((value){
//                     print("RETURN ${value.toString()}");
//                   });
//                 },
//               ),
//               Column(
//                 children: [
//                   Image(
//                     width: 42,
//                     image: AssetImage("assets/icons/instagram.png"),
//                   ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   Text("Instagram",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Image(
//                     width: 42,
//                     image: AssetImage("assets/icons/twitter.png"),
//                   ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   Text("Twitter",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   Image(
//                     width: 42,
//                     image: AssetImage("assets/icons/messenger.png"),
//                   ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   Text("Messenger",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
//                 ],
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Column(
//                 children: [
//                   Icon(Icons.whatsapp,size: 45,color: Color.fromRGBO(59, 89, 151, 0.9),),
//                   Text("WhatsApp",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
//                 ],
//               ),
//             ],
//           ),
//           // ElevatedButton(
//           //     onPressed: (){
//           //       FlutterShareMe().share(url: "https://dev-front.runyourlife.checkmy.dev/blog/1/shared_preview", msg: "RUN YOUR LIFE").then((value){
//           //         print("RETURN ${value.toString()}");
//           //       });
//           //     },
//           //     child: Text('share to twitter')),
//         ],
//       ),
//     );
//   }
// }
