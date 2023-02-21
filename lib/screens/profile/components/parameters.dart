import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:page_transition/page_transition.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/profile/parameters.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/change_hours.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/settings.dart';
import 'package:run_your_life/screens/profile/components/parameter_components/unite_measures.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/other_services/push_notifications.dart';
import 'package:run_your_life/services/stream_services/screens/coaching.dart';
import 'package:run_your_life/services/stream_services/screens/parameters.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../functions/logout_user.dart';
import '../../../services/apis_services/subscriptions/choose_plan.dart';
import '../../../services/other_services/routes.dart';
import '../../../services/stream_services/subscriptions/subscription_details.dart';
import '../../../widgets/appbar.dart';
import '../../coaching/subscription/pack_accompanied/presentation/main_page.dart';
import '../../welcome.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class ParameterPage extends StatefulWidget {
  @override
  _ParameterPageState createState() => _ParameterPageState();
}

class _ParameterPageState extends State<ParameterPage> {
  final PushNotifications _notifications = new PushNotifications();
  final ParameterServices _parameterServices = new ParameterServices();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final LogoutUser _logoutUser = new LogoutUser();
  final Routes _routes = new Routes();
  final ChoosePlanService _choosePlanService = new ChoosePlanService();
  final AppBars _appBars = new AppBars();
  List<String> _type = ["Me notifier quand le coach m’a envoyé un message","Me rappeler de faire mon journal de bord journalier à","Me rappeler de faire mes tâches avant mon rendez-vous"];
  final InAppPurchase _iap = InAppPurchase.instance;
  bool _isAvailable = false;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  late StreamSubscription _subscription;
  bool _isLoader = true;
  int _coins = 0;
  Map? planDetails;
  bool _purchasePending = false;
  bool _isShown = true;

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
    _parameterServices.getSetting().then((value){
      print("NOTIFICATIONS ${value.toString()}");
      if(value.toString() != "{}"){
        if(value["notifications"].toString() != "null"){
          Parameters.notify1st = value["notifications"][0]["value"].toString() == "null" ? "" : value["notifications"][0]["value"].toString();
          Parameters.notify2nd   = value["notifications"][1]["value"].toString() == "null" ? "" : value["notifications"][1]["value"].toString();
          Parameters.notify3rd = value["notifications"][2]["value"].toString() == "null" ? "" : value["notifications"][2]["value"].toString();
          Parameters.hour1st = value["notifications"][0]["hour"].toString();
          Parameters.hour2nd = value["notifications"][1]["hour"].toString();
          Parameters.hour3rd = value["notifications"][2]["hour"].toString();
        }
      }
    });
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
    return StreamBuilder<Map>(
      stream: parameterStreamServices.subject,
      builder: (context, snapshot) {
        return Column(
          children: [
            if(!snapshot.hasData)...{
              for(int x = 0; x < 3; x++)...{
                _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 55),
                SizedBox(
                  height: 15,
                )
              },
            }else...{
              GestureDetector(
                onTap: (){
                  if(!Auth.isNotSubs!){
                    setState(() {
                      if(Parameters.notify1st == ""){
                        Parameters.notify1st = "Me notifier quand le coach m’a envoyé un message";
                        _parameterServices.submit(context).whenComplete((){
                          _parameterServices.getSetting();
                        });
                      }else{
                        Parameters.notify1st = "";
                        _parameterServices.submit(context).whenComplete((){
                          _parameterServices.getSetting();
                        });
                      }
                    });
                  }
                },
                child: ZoomTapAnimation(end: 0.99,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Auth.isNotSubs! ? Colors.grey[200] : Colors.white60,
                        border: Border.all(color: Parameters.notify1st != "" ? AppColors.appmaincolor : Colors.transparent),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Transform.scale(
                            scale: 0.9,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Checkbox(
                                checkColor: Colors.transparent,
                                activeColor: AppColors.appmaincolor,
                                value: Parameters.notify1st != "",
                                shape: CircleBorder(),
                                splashRadius: 20,
                                side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if(Parameters.notify1st == ""){
                                      Parameters.notify1st = "Me rappeler de faire mon journal de bord journalier à";
                                      _parameterServices.submit(context).whenComplete((){
                                        _parameterServices.getSetting();
                                      });
                                    }else{
                                      Parameters.notify1st = "";
                                      _parameterServices.submit(context).whenComplete((){
                                        _parameterServices.getSetting();
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child:Text(_type[0],style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  if(!Auth.isNotSubs!){
                    setState(() {
                      if(Parameters.notify2nd == ""){
                        Parameters.notify2nd = "Me rappeler de faire mon journal de bord journalier à";
                        _parameterServices.submit(context).whenComplete((){
                          _parameterServices.getSetting();
                        });
                      }else{
                        Parameters.notify2nd = "";
                        _parameterServices.submit(context).whenComplete((){
                          _parameterServices.getSetting();
                        });
                      }
                    });
                  }
                },
                child: ZoomTapAnimation(end: 0.99,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Auth.isNotSubs! ? Colors.grey[200] : Colors.white60,
                        border: Border.all(color: Parameters.notify2nd != "" ? AppColors.appmaincolor : Colors.transparent),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Transform.scale(
                            scale: 0.9,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Checkbox(
                                checkColor: Colors.transparent,
                                activeColor: AppColors.appmaincolor,
                                value: Parameters.notify2nd != "",
                                shape: CircleBorder(),
                                splashRadius: 20,
                                side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if(Parameters.notify2nd == ""){
                                      Parameters.notify2nd = "Me rappeler de faire mon journal de bord journalier à";
                                      _parameterServices.submit(context).whenComplete((){
                                        _parameterServices.getSetting();
                                      });
                                    }else{
                                      Parameters.notify2nd = "";
                                      _parameterServices.submit(context).whenComplete((){
                                        _parameterServices.getSetting();
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child:Text(_type[1],style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),),
                        SizedBox(
                          width: 5,
                        ),
                        // x == 0 ? Container() :
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 13),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Auth.isNotSubs! ? AppColors.pinkColor.withOpacity(0.4) : AppColors.pinkColor
                            ),
                            child: snapshot.data!.toString() == "{}" ?
                            Text("Régler le temps",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),) :
                            snapshot.data!["notifications"].toString() == "null" ?
                            Text("Régler le temps",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),) :
                            Parameters.hour2nd == "" || Parameters.hour2nd == "null"?
                            Text("Régler le temps",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),) :
                            Text(Parameters.hour2nd.toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "AppFontStyle"),),
                          ),
                          onTap: (){
                            if(!Auth.isNotSubs!){
                              if(Parameters.notify2nd != ""){
                               _routes.navigator_push(context, ParametersChangeHour(index: 1,));
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? Container() : SizedBox(
                height: 10,
              ),
              subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? Container() : GestureDetector(
                onTap: (){
                  if(!Auth.isNotSubs!){
                    setState(() {
                      if(Parameters.notify3rd == ""){
                        Parameters.notify3rd = "Me rappeler de faire mon journal de bord journalier à";
                        _parameterServices.submit(context).whenComplete((){
                          _parameterServices.getSetting();
                        });
                      }else{
                        Parameters.notify3rd = "";
                        _parameterServices.submit(context).whenComplete((){
                          _parameterServices.getSetting();
                        });
                      }
                    });
                  }
                },
                child: ZoomTapAnimation(end: 0.99,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Auth.isNotSubs! ? Colors.grey[200] : Colors.white60,
                        border: Border.all(color: Parameters.notify3rd != "" ? AppColors.appmaincolor : Colors.transparent),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Transform.scale(
                            scale: 0.9,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: Checkbox(
                                checkColor: Colors.transparent,
                                activeColor: AppColors.appmaincolor,
                                value: Parameters.notify3rd != "",
                                shape: CircleBorder(),
                                splashRadius: 20,
                                side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if(Parameters.notify3rd == ""){
                                      Parameters.notify3rd = "Me rappeler de faire mes tâches avant mon rendez-vous";
                                      _parameterServices.submit(context).whenComplete((){
                                        _parameterServices.getSetting();
                                      });
                                    }else{
                                      Parameters.notify3rd = "";
                                      _parameterServices.submit(context).whenComplete((){
                                        _parameterServices.getSetting();
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.4) : AppColors.appmaincolor,width: 1.5),
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Text(_type[2],style: TextStyle(color: Auth.isNotSubs! ? Colors.grey : Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),),
                        SizedBox(
                          width: 5,
                        ),
                        // x == 0 ? Container() :
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 13),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Auth.isNotSubs! ? AppColors.pinkColor.withOpacity(0.4) : AppColors.pinkColor
                            ),
                            child: snapshot.data!.toString() == "{}" ?
                            Text("Régler le temps",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),) :
                            snapshot.data!["notifications"].toString() == "null" ?
                            Text("Régler le temps",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),) :
                            Parameters.hour3rd == "" || Parameters.hour3rd == "null"?
                            Text("Régler le temps",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),) :
                            Text(Parameters.hour3rd.toString().split(",")[0].toString(),style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "AppFontStyle"),),
                          ),
                          onTap: (){
                            if(!Auth.isNotSubs!){
                              if(Parameters.notify3rd != ""){
                                _routes.navigator_push(context, ParametersChangeHour(index: 2,));
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            },
            SizedBox(
              height: 25,
            ),
            if(!snapshot.hasData)...{
              for(int x = 0; x < 5; x++)...{
                _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 55),
                SizedBox(
                  height: 15,
                )
              },
            }else...{
              UniteMeasures(details: snapshot.data!,),
            },
            SizedBox(
              height: 40,
            ),
            Container(
              child: _materialbutton.materialButton("ENREGISTRER", () {
                if(!Auth.isNotSubs!){
                  _screenLoaders.functionLoader(context);
                  _parameterServices.submit(context).then((value){
                    if(value != null){
                      _parameterServices.getSetting().whenComplete((){
                        Navigator.of(context).pop(null);
                        _snackbarMessage.snackbarMessage(context , message: "Le paramètre a été mis à jour avec succès !");
                      });
                    }else{
                      Navigator.of(context).pop(null);
                      _snackbarMessage.snackbarMessage(context, message: "Une erreur s'est produite. Veuillez réessayer !", is_error: true);
                    }
                  });
                }
              }, bckgrndColor: Auth.isNotSubs! ? AppColors.appmaincolor.withOpacity(0.5) : AppColors.appmaincolor),
            ),
            SizedBox(
              height: 30,
            ),
            DottedLine(
              dashColor: Colors.grey.shade400,
            ),
            SizedBox(
              height: 30,
            ),
            Settings(),
            Auth.loggedUser == null ? _upgrader(details: coachingStreamServices.currentdata[0]) :
            subscriptionDetails.currentdata.toString() == "[]" ? _upgrader(details: coachingStreamServices.currentdata[0]) :
            subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ? _upgrader(details: coachingStreamServices.currentdata[0]) : Container(),
            InkWell(
              onTap: (){
                _logout(context);
              },
              child: Container(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_outlined,size: 24,color: AppColors.pinkColor,),
                    SizedBox(
                      width: 7,
                    ),
                    Text("SE DÉCONNECTER",style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.darpinkColor,fontWeight: FontWeight.w600,fontSize: 15),)
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }

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
  Future _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList)async{
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
          print(purchaseDetails.verificationData.serverVerificationData);
          print(purchaseDetails.verificationData.source);
          print(purchaseDetails.status);
          print(purchaseDetails.purchaseID);
          print(purchaseDetails.productID);
          print(purchaseDetails.transactionDate);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            print(purchaseDetails.verificationData.serverVerificationData);
            print(purchaseDetails.verificationData.source);
            print(purchaseDetails.status);
            print(purchaseDetails.purchaseID);
            print(purchaseDetails.productID);
            print(purchaseDetails.transactionDate);
            _screenLoaders.functionLoader(context);
            _choosePlanService.upgrade(context,planid: "3", purchaseToken: purchaseDetails.verificationData.serverVerificationData.toString(), transacId: "accompagned_subs", type: Platform.isIOS ? "appstore" : "playstore",).then((value){
              if(value != null){
                _routes.navigator_pushreplacement(context, PresentationMainPage());
              }
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

  Widget _upgrader({required Map details}){
   return Column(
     children: [
       ZoomTapAnimation(
          end: 0.99,
          onTap: ()async{
            setState(() {
              planDetails = details;
            });
            if(Platform.isIOS){
              var paymentWrapper = SKPaymentQueueWrapper();
              var transactions = await paymentWrapper.transactions();
              transactions.forEach((transaction) async {
                await paymentWrapper.finishTransaction(transaction);
              });
            }
            _buyProduct(_products[_products.length - 1]);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: DeviceModel.isMobile ? 110 : 140,
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
                        height: 8,
                      ),
                      Text("Laissez-vous porter !",style: TextStyle(color: Colors.white,fontFamily: "AppFontStyle"),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
     ],
   );
  }
  void _logout(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: const Text('Veuillez confirmer',style: TextStyle(fontFamily: "AppFontStyle"),),
          content: const Text('Êtes-vous sûr de vouloir vous déconnecter?',style: TextStyle(fontFamily: "AppFontStyle"),),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                setState(() {
                  _screenLoaders.functionLoader(context);
                  _notifications.firebasemessaging.deleteToken().whenComplete((){
                    _logoutUser.logout().whenComplete((){
                      _isShown = false;
                      Navigator.of(context).pop(null);
                      _routes.navigator_pushreplacement(context, Welcome(), transitionType: PageTransitionType.leftToRightWithFade);
                    });
                  });
                });
              },
              child: const Text('Oui',style: TextStyle(fontFamily: "AppFontStyle"),),
              isDefaultAction: true,
              isDestructiveAction: true,
            ),
            // The "No" button
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Non',style: TextStyle(fontFamily: "AppFontStyle"),),
              isDefaultAction: false,
              isDestructiveAction: false,
            )
          ],
        );
      });
  }
}
