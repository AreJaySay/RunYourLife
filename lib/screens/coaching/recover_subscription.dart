import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:run_your_life/services/apis_services/subscriptions/choose_plan.dart';
import 'package:run_your_life/services/stream_services/subscriptions/subscription_details.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RecoverSubscription extends StatefulWidget {
  @override
  State<RecoverSubscription> createState() => _RecoverSubscriptionState();
}

class _RecoverSubscriptionState extends State<RecoverSubscription> {
  final AppBars _appBars = AppBars();

  // final InAppPurchase inAppPurchase = InAppPurchase.instance;
  // late final StreamSubscription<List<PurchaseDetails>> _subsStream;
  // final BehaviorSubject<List<PurchaseDetails>> _subject = BehaviorSubject<List<PurchaseDetails>>();
  // Stream<List<PurchaseDetails>> get stream => _subject.stream;
  // final ChoosePlanService _service = ChoosePlanService();
  //
  // Future<void> getpastPurchases() async {
  //   try {
  //     await inAppPurchase.restorePurchases();
  //   } catch (e, s) {
  //     print("ERROR: $e");
  //     print("Stacktrace ; $s");
  //     return;
  //   }
  // }
  //
  // Future<void> recover(PurchaseDetails details) async {
  //   print("NASUOLOD DDI");
  //   print(details.verificationData.serverVerificationData);
  //   print(details.verificationData.source);
  //   print(details.status);
  //   print(details.purchaseID);
  //   print(details.productID);
  //   print(details.transactionDate);
  //   await _service.choosePlan(context, planid: details.productID == "accompagned_subs" ? "3" : "4", purchaseToken: details.verificationData.serverVerificationData, type: details.verificationData.source == "google_play" ? "playstore" : "applestore", transacId: details.productID);
  // }
  //
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await getpastPurchases();
  //   });
  //   final Stream purchaseUpdated = inAppPurchase.purchaseStream;
  //   _subsStream = purchaseUpdated.listen(
  //     (purchaseDetailsList) async {
  //       _subject.add(purchaseDetailsList);
  //     },
  //     onDone: () async {
  //       _subsStream.cancel();
  //     },
  //     cancelOnError: true,
  //   ) as StreamSubscription<List<PurchaseDetails>>;
  //
  //   // TODO: implement initState
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: subscriptionDetails.subject,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70), // here the desired height
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3.0, // has the effect of softening the shadow
                    spreadRadius: 1.0, // has the effect of extending the shadow
                    offset: const Offset(
                      5.0, // horizontal, move right 10
                      3.5, // vertical, move down 10
                    ),
                  )
                ],
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: AppGradientColors.gradient,
                            borderRadius: BorderRadius.circular(1000)),
                        child: Center(
                          child: Platform.isAndroid
                              ? const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 22,
                          )
                              : const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(null);
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Mon abonnement",
                      style: TextStyle(
                          color: AppColors.appmaincolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "AppFontStyle"),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: !snapshot.hasData ?
            Center(
              child: CircularProgressIndicator(color: AppColors.appmaincolor,),
            ) :
            ListView(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              children: [
                 for(int x = 0; x < snapshot.data!.length; x++)...{
                   Text(DateFormat("d, MMMM yyyy HH:mm", 'fr_FR').format(DateTime.parse(snapshot.data![x]["updated_at"])).toString().toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15),),
                   SizedBox(
                     height: 5,
                   ),
                   snapshot.data![x]["name"].toString().contains("100% accompagne") ? Container(
                     margin: EdgeInsets.only(bottom: 20),
                     width: double.infinity,
                     height: 120,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       gradient: AppGradientColors.gradient,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.shade300,
                           blurRadius: 3.0, // has the effect of softening the shadow
                           spreadRadius: 1.0, // has the effect of extending the shadow
                           offset: Offset(
                             0.0, // horizontal, move right 10
                             1.0, // vertical, move down 10
                           ),
                         )
                       ],
                     ),
                     child: Stack(
                       children: [
                         Image(
                           color: Colors.white,
                           width: double.infinity,
                           alignment: Alignment.topRight,
                           image: AssetImage("assets/important_assets/coaching_back.png"),
                         ),
                         Padding(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   Text("PACK",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "AppFontStyle"),),
                                   Expanded(child: Text(" ${snapshot.data![x]["plan"]["name"]}".toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"))),
                                 ],
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                               ),
                               SizedBox(
                                 height: 7,
                               ),
                               Text(snapshot.data![x]["plan"]["description"].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                             ],
                           ),
                           padding: EdgeInsets.symmetric(horizontal: 20),
                         ),
                       ],
                     ),
                   ) : Container(
                     margin: EdgeInsets.only(bottom: 20),
                     width: double.infinity,
                     height: 120,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.shade300,
                           blurRadius: 3.0, // has the effect of softening the shadow
                           spreadRadius: 1.0, // has the effect of extending the shadow
                           offset: Offset(
                             0.0, // horizontal, move right 10
                             1.0, // vertical, move down 10
                           ),
                         )
                       ],
                     ),
                     child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: 20),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Text("PACK",style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontFamily: "AppFontStyle"),),
                               Expanded(child: Text(" ${snapshot.data![x]["plan"]["name"]}".toString().toUpperCase(),style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                             ],
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                           ),
                           SizedBox(
                             height: 7,
                           ),
                           Text(snapshot.data![x]["plan"]["description"],maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
                         ],
                       ),
                     ),
                   ),
                   // ListTile(
                   //   tileColor: Colors.white,
                   //   title: Text(DateFormat("d, MMMM yyyy HH:mm", 'fr_FR').format(DateTime.fromMillisecondsSinceEpoch(
                   //       (snapshot.data![x]
                   //           .transactionDate !=
                   //           null
                   //           ? int.parse(
                   //           snapshot.data![x]
                   //               .transactionDate!)
                   //           : 0) *
                   //           1),).toString()),
                   // )
                 }
              ],
            ),
          ),
        );
      }
    );
  }
}
