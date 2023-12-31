import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/screens/coaching/page_loader/shimmer.dart';
import 'package:run_your_life/services/apis_services/screens/coaching.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/coaching.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../functions/loaders.dart';
import '../../services/apis_services/subscriptions/choose_plan.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'components/view_details.dart';

class Coaching extends StatefulWidget {
  @override
  _CoachingState createState() => _CoachingState();
}

class _CoachingState extends State<Coaching> {
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final AppBars _appBars = new AppBars();
  final Routes _routes = new Routes();
  final CoachingServices _coachingServices = new CoachingServices();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ChoosePlanService _choosePlanService = new ChoosePlanService();
  Map? planDetails;
  // IN APP PURCHASE
  final InAppPurchase _iap = InAppPurchase.instance;
  bool _isAvailable = false;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  late StreamSubscription _subscription;
  bool _isLoader = true;
  int _coins = 0;


  // INITIALIZE
  Future<void> _initialize() async {
    _isAvailable = await _iap.isAvailable();
    if(_isAvailable){
      await _getUserProducts();
      // await _getPastPurchases();
      _verifyPurchases();
      _subscription = _iap.purchaseStream.listen((data)=> setState((){
        _purchases.addAll(data);
        _verifyPurchases();
      }));

    }
  }

  // GET USER PRODUCTS
  Future<void> _getUserProducts() async {
    Set<String> ids = Platform.isIOS ? {"macroSolo_subs","accompagned_subs"} : {"macro_solo_subs","accompagned_subs"};
    ProductDetailsResponse response = await _iap.queryProductDetails(ids).whenComplete((){});
    print("PRODUCTS ${response.productDetails.toString()}");
    setState(() {
      _products = response.productDetails;
      _isLoader = false;
    });
  }
  // checks if a user has purchased a certain product
  PurchaseDetails _hasUserPurchased(String productID){
    return _purchases.firstWhere((purchase) => purchase.productID == productID);
  }
  void _verifyPurchases(){
    PurchaseDetails purchase = _hasUserPurchased("accompagned_subs");
    if(purchase.status == PurchaseStatus.purchased){
      _coins = 10;
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
    _coachingServices.getplans();
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _iap
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: coachingStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          appBar:  _appBars.preferredSize(height: DeviceModel.isMobile ? 60 : 80,logowidth: DeviceModel.isMobile ? 90 : 110),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: _isLoader || !snapshot.hasData ?
            CoachingShimmerLoader() :
            ListView(
              padding: EdgeInsets.symmetric(vertical: 25),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("LES ABONNEMENTS",style: TextStyle(color: AppColors.appmaincolor,fontSize: DeviceModel.isMobile ? 22 : 26,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                ),
                SizedBox(
                  height: 23,
                ),
                for(int x = 0; x < _products.length; x++)...{
                  if(_products[x].id.toString() != "macroSolo_subs" && _products[x].id.toString() != "macro_solo_subs")...{
                    ZoomTapAnimation(
                      end: 0.99,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                        width: double.infinity,
                        height: DeviceModel.isMobile ? 400 : 250,
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text("PACK",style: TextStyle(color: Colors.white,fontSize: DeviceModel.isMobile ? 17.5 : 23,fontFamily: "AppFontStyle"),),
                                        Expanded(child: Text(" ${snapshot.data![0]["name"]}".toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: DeviceModel.isMobile ? 17.5 : 23,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"))),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                    padding: EdgeInsets.only(left: 20,right: 20,top: 30)
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                                  child: Text("Questionnaire d’entrée personnalisé \nCalcul des besoins en macro-nutriments par son coach \nProgression individualisée grâce : \n   • À un appel hebdomadaire avec son coach \n   • À des ressources individualisées chaque semaine \n    • À des objectifs individualisés par son coach \n    • À échange illimité avec son coach (chat : de 9h à 18h) \nSuivi de ses données au jour le jour via l’application \nSuivi de l’évolution de sa courbe de poids et mesures",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                                //   child: Text(snapshot.data![0]["description"].toString().replaceAll("Ressources", "\nRessources").replaceAll("Feedback", "\nFeedback").replaceAll("Appel", "\nAppel"),style: TextStyle(fontSize: DeviceModel.isMobile ? 15 : 18,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                                // ),
                                Spacer(),
                                Align(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(10)
                                        )
                                    ),
                                    child: snapshot.data![0]["prices"].toString() == "[]" ? Container() :
                                    RichText(
                                      text: TextSpan(
                                        text: _products[x].price.toString(),
                                        style: TextStyle(color: AppColors.appmaincolor,fontSize: DeviceModel.isMobile ? 19 : 23,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),
                                        children: <TextSpan>[
                                          TextSpan(text: '/mois', style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: DeviceModel.isMobile ? 14 : 19)),
                                        ],
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                                  ),
                                  alignment: Alignment.centerRight,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: ()async{
                        _routes.navigator_push(context, ViewCoachingDetails(planDetails: snapshot.data![0],productDetails: _products[x],price: _products[x].price.toString(),));
                      },
                    ),
                  }else...{
                    ZoomTapAnimation(end: 0.99,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20,bottom: 25),
                        width: double.infinity,
                        height: 370,
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
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text("PACK",style: TextStyle(color: AppColors.pinkColor,fontSize: DeviceModel.isMobile ? 17.5 : 23,fontFamily: "AppFontStyle"),),
                                    Expanded(child: Text(" ${snapshot.data![1]["name"]}".toString().toUpperCase(),style: TextStyle(color: AppColors.pinkColor,fontSize: DeviceModel.isMobile ? 17.5 : 23,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                padding: EdgeInsets.only(left: 20,right: 20,top: 30)
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                              child: Text("Questionnaire d’entrée personnalisé \nCalcul des besoins en macro-nutriments par un coach \nProgression autonome grâce : \n   • À un parcours éducatif automatisé quotidien \n   • À de nouveaux objectifs automatisés chaque jour \nSuivi de ses données au jour le jour via l’application \nSuivi de l’évolution de sa courbe de poids et mesures \nAppel groupé des abonnés « Macro solos » mensuel d’une heure",style: TextStyle(color: Colors.black,fontFamily: "AppFontStyle"),),
                            ),
                            // Container(
                            //   width: double.infinity,
                            //   padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                            //   child: Text(snapshot.data![1]["description"].toString().replaceAll("Accès", "\nAccès"),maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: DeviceModel.isMobile ? 15 : 18,color: Colors.black,fontFamily: "AppFontStyle"),),
                            // ),
                            Spacer(),
                            Align(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.pinkColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(10)
                                    )
                                ),
                                child: snapshot.data![1]["prices"].toString() == "[]" ? Container() :
                                RichText(
                                  text: TextSpan(
                                    text: _products[x].price,
                                    style: TextStyle(color: Colors.white,fontSize: DeviceModel.isMobile ? 19 : 23,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),
                                    children: <TextSpan>[
                                      TextSpan(text: '/mois', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: DeviceModel.isMobile ? 14 : 19)),
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                              ),
                              alignment: Alignment.centerRight,
                            )
                          ],
                        ),
                      ),
                      onTap: ()async{
                        _routes.navigator_push(context, ViewCoachingDetails(planDetails: snapshot.data![1]!, productDetails: _products[x],price: _products[x].price.toString(),));
                      },
                    ),
                  }
                },
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Pas de minimum d'engagement",style: TextStyle(color: Colors.grey[500],fontFamily: "AppFontStyle",fontSize: DeviceModel.isMobile ? 15 : 20),),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Prix préferentiel via le site internet",style: TextStyle(color: Colors.grey[500],fontFamily: "AppFontStyle",fontSize: DeviceModel.isMobile ? 15 : 20),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
