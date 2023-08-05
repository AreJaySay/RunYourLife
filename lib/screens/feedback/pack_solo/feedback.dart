import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/services/apis_services/screens/feedback.dart';
import 'package:run_your_life/services/apis_services/screens/home.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/widgets/notification_notifier.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../functions/loaders.dart';
import '../../../models/screens/feedback/feedback.dart';
import '../../../services/apis_services/subscriptions/choose_plan.dart';
import '../../../services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import '../../../services/stream_services/screens/coaching.dart';
import '../../../services/stream_services/screens/feedback.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/message_notifier.dart';
import '../../coaching/subscription/pack_accompanied/presentation/main_page.dart';
import '../../profile/components/subscription_modal.dart';
import '../components/coach/listview_widget.dart';
import '../components/shimmer_loader.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class PackSoloFeedback extends StatefulWidget {
  @override
  State<PackSoloFeedback> createState() => _PackSoloFeedbackState();
}

class _PackSoloFeedbackState extends State<PackSoloFeedback> {
  final List<String> _firstchar = ["CETTE","LA","LA"];
  final List<String> _secondchar = ["SEMAINE","DERNIÈRE","SEMAINE DY 11/04"];
  final FeedbackServices _feedbackServices = new FeedbackServices();
  final Routes _routes = new Routes();
  final HomeServices _homeServices = new HomeServices();
  ScrollController _scrollController = new ScrollController();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ChoosePlanService _choosePlanService = new ChoosePlanService();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
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
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            _screenLoaders.functionLoader(context);
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
    _homeServices.getSchedule();
    _feedbackServices.getTime(date: DateFormat("yyyy-MM-dd","fr_FR").format(DateTime.now().toUtc().add(Duration(hours: 2))), coach_id: subscriptionDetails.currentdata[0]['coach_id'].toString());
    _feedbackServices.getFeedback().then((value){
      for(int x = 0; x < value.length; x++){
        if(DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays <= 7){
          if(!coachFeedBack.currentWeek.toString().contains(value[x].toString())){
            coachFeedBack.currentWeek.add(value[x]);
          }
        }else if(DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays > 7 && DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value[x]["created_at"])).inDays <= 14){
          if(!coachFeedBack.lastWeek.toString().contains(value[x].toString())){
            coachFeedBack.lastWeek.add(value[x]);
          }
        }else{
          if(!coachFeedBack.otherWeek.toString().contains(value[x].toString())){
            coachFeedBack.otherWeek.add(value[x]);
          }
        }
      }
    });
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
      stream: feedbackStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          body: Stack(
            children: [
              Image(
                width: double.infinity,
                fit: BoxFit.cover,
                image: AssetImage("assets/important_assets/heart_icon.png"),
              ),
              DefaultTabController(
                length: 5,
                child: AbsorbPointer(
                  absorbing: false,
                  child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                              pinned: false,
                              backgroundColor: AppColors.appmaincolor,
                              snap: false,
                              floating: true,
                              expandedHeight: 56.0,
                              automaticallyImplyLeading: false,
                              flexibleSpace: Container(
                                decoration: BoxDecoration(
                                  gradient: AppGradientColors.gradient,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 3.0, // has the effect of softening the shadow
                                      spreadRadius: 1.0, // has the effect of extending the shadow
                                      offset: Offset(
                                        5.0, // horizontal, move right 10
                                        3.5, // vertical, move down 10
                                      ),
                                    )
                                  ],
                                ),
                                child: SafeArea(
                                  child: Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          children: [
                                            Text("FEEDBACK",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily: "AppFontStyle"),),
                                            Spacer(),
                                            NotificationNotifier(),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            MessageNotifier()
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              )
                          ),
                          SliverPadding(
                            padding:  EdgeInsets.only(bottom: 5,),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                SizedBox(
                                  height: 30,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      width: double.infinity,
                                      alignment: Alignment.bottomRight,
                                      child: Image(
                                        image: AssetImage("assets/icons/lock.png"),
                                        width: 50,
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      width: double.infinity,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("PROCHAIN RENDEZ-VOUS",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                subscriptionDetails.currentdata[0]["stripe_id"].toString().contains("mobile-subs") ? Container() :
                                ZoomTapAnimation(
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
                                    // setState(() {
                                    //   planDetails = coachingStreamServices.currentdata[1];
                                    // });
                                    // if(Platform.isIOS){
                                    //   var paymentWrapper = SKPaymentQueueWrapper();
                                    //   var transactions = await paymentWrapper.transactions();
                                    //   transactions.forEach((transaction) async {
                                    //     await paymentWrapper.finishTransaction(transaction);
                                    //   });
                                    // }
                                    // _buyProduct(_products[_products.length - 1]);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    width: double.infinity,
                                    height: 70,
                                    decoration: Auth.isNotSubs! ?
                                    BoxDecoration(
                                        color: AppColors.appmaincolor.withOpacity(0.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.6),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                            offset: Offset(0, 2), // Shadow position
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10)
                                    ) :
                                    BoxDecoration(
                                        gradient: AppGradientColors.gradient,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.6),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                            offset: Offset(0, 0), // Shadow position
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
                                              Text("UPGRADER",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "AppFontStyle"),),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text("Laissez-vous porter !",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ];
                      },
                      body: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          if(!snapshot.hasData)...{
                            FeedbackShimmerLoader()
                          }else if(snapshot.data!.isEmpty)...{
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text("Cet abonnement ne vous permet pas d'obtenir un feedback de votre coach. Cependant, vous pouvez vous rendre sur la page de votre profil en bas de page et mettre à niveau votre abonnement pour que le mois prochain vous puissiez bénéficier d'un suivi 100% personnalisé et d'un contact permanent avec un coach !",style: TextStyle(fontSize: 15.5,color: Colors.black,fontFamily: "AppFontStyle"),textAlign: TextAlign.center,),
                              ),
                            )
                          }else...{
                            // CURRENT WEEK
                            if(coachFeedBack.currentWeek.isNotEmpty)...{
                              Row(
                                children: [
                                  Text("SEMAINE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" EN COURS",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.currentWeek.length; x++)...{
                                SizedBox(
                                    height: 17
                                ),
                                CoachListViewWidget(coachFeedBack.currentWeek[x],isMacroSolo: true,),
                              }
                            },
                            // LAST WEEK
                            if(coachFeedBack.lastWeek.isNotEmpty)...{
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  Text("SEMAINE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" DERNIERE",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.lastWeek.length; x++)...{
                                SizedBox(
                                    height: 17
                                ),
                                CoachListViewWidget(coachFeedBack.lastWeek[x],isMacroSolo: true,),
                              }
                            },
                            if(coachFeedBack.otherWeek.isNotEmpty)...{
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  Text("AUTRES",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle"),),
                                  Text(" SEMAINES PASSÉES",style: TextStyle(fontSize: 15,color: AppColors.pinkColor,fontFamily: "AppFontStyle",fontWeight: FontWeight.w600),),
                                ],
                              ),
                              for(var x = 0; x < coachFeedBack.otherWeek.length; x++)...{
                                SizedBox(
                                    height: 17
                                ),
                                CoachListViewWidget(coachFeedBack.otherWeek[x],isMacroSolo: true,),
                              }
                            },
                          }
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}