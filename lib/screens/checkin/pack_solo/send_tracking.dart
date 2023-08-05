import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:run_your_life/screens/coaching/subscription/pack_accompanied/presentation/main_page.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../functions/loaders.dart';
import '../../../models/device_model.dart';
import '../../../services/apis_services/subscriptions/choose_plan.dart';
import '../../../services/stream_services/screens/coaching.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../utils/palettes/app_colors.dart';
import '../../../utils/palettes/app_gradient_colors.dart';
import '../../coaching/components/enter_card.dart';
import '../../coaching/components/view_details.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import '../../profile/components/subscription_modal.dart';

class SendTracking extends StatefulWidget {
  @override
  State<SendTracking> createState() => _SendTrackingState();
}

class _SendTrackingState extends State<SendTracking> {
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ChoosePlanService _choosePlanService = new ChoosePlanService();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final Routes _routes = new Routes();
  final InAppPurchase _iap = InAppPurchase.instance;
  bool _isAvailable = false;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  late StreamSubscription _subscription;
  bool _isLoader = true;
  int _coins = 0;
  Map? planDetails;
  bool _purchasePending = false;


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
  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }
  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }
  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }
  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }
  // GET USER PRODUCTS
  Future<void> _getUserProducts() async {
    Set<String> ids = {"accompagned_subs"};
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
  // PURCHASE PRODUCT
  Future _buyProduct(ProductDetails prod)async{
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }
  // COMPLETE PURCHASE
  Future _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList)async {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            _choosePlanService.choosePlan(context, planid: "3",
              purchaseToken: purchaseDetails.verificationData
                  .serverVerificationData.toString(),
              transacId: "accompagned_subs",
              type: Platform.isIOS ? "appstore" : "playstore",).then((value) {
              _subscriptionServices.cancelSubscription(context, subs_id: subscriptionDetails.currentdata[subscriptionDetails.currentdata.length - 1]["id"].toString()).then((upgrade){
                if(upgrade != null){
                  _routes.navigator_pushreplacement(context, PresentationMainPage());
                }
              });
            });
          } else {
            _handleInvalidPurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance
              .completePurchase(purchaseDetails);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _iap.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    _initialize();
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
   return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 180),
              child: Image(
                color: Colors.grey.withOpacity(0.1),
                width: 150,
                image: AssetImage("assets/icons/lock_half.png",),
                alignment: Alignment.centerLeft,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: Center(
                            child:  Platform.isAndroid ? Icon(Icons.arrow_back,color: Colors.white,size: 22,) :  Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 22,),
                          ),
                          decoration: BoxDecoration(
                            gradient: AppGradientColors.gradient,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                        onTap: (){
                          Navigator.of(context).pop(null);
                        },
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("ENVOYER VOS \nTRACKING",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: AppColors.appmaincolor,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text("Vous souhaitez avoir un \nsuivi hebdomadaire ?",style: TextStyle(fontSize: 21,color: Colors.black,fontFamily: "AppFontStyle"),),
                  SizedBox(
                    height: 50,
                  ),
                  subscriptionDetails.currentdata[0]["stripe_id"].toString().contains("mobile-subs") ? Container() : ZoomTapAnimation(
                    end: 0.99,
                    onTap: ()async{
                      if(subscriptionDetails.currentdata[0]["stripe_id"].toString().contains("mobile-subs")){
                        showModalBottomSheet(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                            isScrollControlled: true,
                            context: context, builder: (context){
                          return SubscriptionModal();
                        });
                      }else{
                        setState((){
                          planDetails = coachingStreamServices.currentdata[1];
                        });
                        if(Platform.isIOS){
                          var paymentWrapper = SKPaymentQueueWrapper();
                          var transactions = await paymentWrapper.transactions();
                          transactions.forEach((transaction) async {
                            await paymentWrapper.finishTransaction(transaction);
                          });
                        }
                        _buyProduct(_products[_products.length - 1]);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: DeviceModel.isMobile ? 130 : 160,
                      decoration: BoxDecoration(
                          gradient: AppGradientColors.gradient,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Stack(
                        children: [
                          Image(
                            color: Colors.white.withOpacity(0.1),
                            width: double.infinity,
                            image: AssetImage("assets/icons/coaching.png",),
                            fit: BoxFit.contain,
                            alignment: Alignment.centerRight,
                            filterQuality: FilterQuality.high,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("UPGRADER",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "AppFontStyle"),),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text("PACK",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: "AppFontStyle"),),
                                    Text(" 100% ACCOMPAGNÉ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "AppFontStyle"),),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("Voir des  conseils vipersonnalisés !",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
