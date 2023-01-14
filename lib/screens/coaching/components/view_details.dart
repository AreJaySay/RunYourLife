import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/services/apis_services/screens/parameters.dart';
import 'package:run_your_life/services/apis_services/subscriptions/choose_plan.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import '../../../models/screens/profile/parameters.dart';
import '../../../services/apis_services/screens/profile.dart';
import '../../../widgets/backbutton.dart';
import '../subscription/pack_accompanied/presentation/main_page.dart';
import '../subscription/pack_solo/presentation/main_page.dart';

class ViewCoachingDetails extends StatefulWidget {
  final Map planDetails;
  final String price;
  final ProductDetails productDetails;
  ViewCoachingDetails({required this.planDetails,required this.productDetails, required this.price});
  @override
  _ViewCoachingDetailsState createState() => _ViewCoachingDetailsState();
}

class _ViewCoachingDetailsState extends State<ViewCoachingDetails> {
  final ChoosePlanService _choosePlanService = new ChoosePlanService();
  final Materialbutton _materialbutton = new Materialbutton();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ParameterServices _parameterServices = new ParameterServices();
  final ProfileServices _profileServices = new ProfileServices();
  final Routes _routes = new Routes();
  List _bulletnames = ['Suivi débloqué','Calcul de macro','Accès à des ressources','Feedback','Appel','Objectifs et ressources hebdomadaires'];
  late StreamSubscription _subscription;
  final InAppPurchase _iap = InAppPurchase.instance;

  // PURCHASE PRODUCT
  Future _buyProduct(ProductDetails prod)async{
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }
  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }
  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  // COMPLETE PURCHASE
  Future _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList)async{
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.canceled) {
        Navigator.of(context).pop(null);
      } else if(purchaseDetails.status == PurchaseStatus.error) {
        Navigator.of(context).pop(null);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
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
            Navigator.of(context).pop(null);
            _screenLoaders.functionLoader(context);
            if(purchaseDetails.productID == "accompagned_subs"){
              _choosePlanService.choosePlan(context,planid: "3", purchaseToken: purchaseDetails.verificationData.serverVerificationData.toString(), transacId: "accompagned_subs", type: "appstore",).then((value){
                if(value != null){
                  _parameterServices.submit(context).whenComplete((){
                    if(widget.planDetails["id"] == 3){
                      _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString()).then((result){
                        if(result != null){
                          _routes.navigator_pushreplacement(context, PresentationMainPage(),);
                        }else{
                          Navigator.of(context).pop(null);
                        }
                      });
                    }else{
                      _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString()).then((result){
                        if(result != null){
                          _routes.navigator_pushreplacement(context, PackSoloPresentationMainPage(),);
                        }else{
                          Navigator.of(context).pop(null);
                        }
                      });
                    }
                  });
                }
              });
            }else{
              _choosePlanService.choosePlan(context,planid: "4", purchaseToken: purchaseDetails.verificationData.serverVerificationData.toString(), transacId: "macro_solo_subs", type: "appstore",).then((value){
                if(value != null){
                  _parameterServices.submit(context).whenComplete((){
                    if(widget.planDetails["id"] == 3){
                      _screenLoaders.functionLoader(context);
                      _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString()).then((result){
                        if(result != null){
                          Navigator.of(context).pop(null);
                          _routes.navigator_pushreplacement(context, PresentationMainPage(),);
                        }else{
                          Navigator.of(context).pop(null);
                        }
                      });
                    }else{
                      _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString()).then((result){
                        if(result != null){
                          Navigator.of(context).pop(null);
                          _routes.navigator_pushreplacement(context, PackSoloPresentationMainPage(),);
                        }else{
                          Navigator.of(context).pop(null);
                        }
                      });
                    }
                  });
                }
              });
            }
            // deliverProduct(purchaseDetails);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            widget.planDetails['name'].toString().contains("macro solo") ? Container() : Image(
              width: double.infinity,
              alignment: Alignment.topRight,
              image: AssetImage("assets/important_assets/coaching_back.png"),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageBackButton(margin: 0,),
                    SizedBox(
                      height: 30,
                    ),
                    Text("PACK",style: TextStyle(color: AppColors.appmaincolor,fontSize: 27,fontFamily: "AppFontStyle"),),
                    Text( "${widget.planDetails['name']}",style: TextStyle(color: AppColors.appmaincolor,fontSize: 27,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                    SizedBox(
                      height: 20,
                    ),
                    Text(widget.planDetails["description"].toString().replaceAll("Ressources", "\nRessources").replaceAll("Feedback", "\nFeedback").replaceAll("Appel", "\nAppel").replaceAll("Accès", "\nAccès"),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.price,style: TextStyle(fontSize: 40,color: AppColors.appmaincolor,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),),
                        Container(
                          width: 50,
                          height: 30,
                          alignment: Alignment.bottomCenter,
                          child: Text("/mois",style: TextStyle(fontSize: 17,color: AppColors.appmaincolor),),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for(var x = 0; x < _bulletnames.length;x++)...{
                      Row(
                        children: [
                           widget.planDetails['name'].toString().contains("macro solo") ? Container(
                            child: x == 4 || x == 3 || x == 5 ?
                            Icon(Icons.close_rounded,size: 23,color: Colors.grey,) :
                            Icon(Icons.check_circle,size: 23,color: AppColors.pinkColor,),
                          ) : Container(
                            child: Icon(Icons.check_circle,size: 23,color: AppColors.pinkColor,),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(_bulletnames[x],style: TextStyle(
                            color: widget.planDetails['name'].toString().contains("macro solo") ? x == 4 || x == 3 || x == 5 ? Colors.grey : Colors.black : Colors.black,
                            fontSize: 15,
                            fontWeight: x == 2 || x == 5 ? FontWeight.w500 : FontWeight.bold,
                            fontFamily: "AppFontStyle"
                          ),),
                          x == 0 || x == 2 ? Container() :
                          Text(x == 4 ? " hebdomadaire" : x == 3 ? " personnalisé" : "",style: TextStyle(
                              color:  widget.planDetails['name'].toString().contains("macro solo") ? x == 4 || x == 3 || x == 5 ? Colors.grey : Colors.black : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: "AppFontStyle"
                          ),)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    },
                    Spacer(),
                    Container(
                      child: _materialbutton.materialButton("ACHETER", ()async {
                        setState((){
                          parameters.trackings[0] = "Oui";
                          parameters.trackings[1] = "Oui";
                          parameters.trackings[2] = "Oui";
                          parameters.trackings[3] = "Oui";
                          parameters.trackings[4] = "Oui";
                          parameters.trackings[5] = "Oui";
                        });
                        if(Platform.isIOS){
                          var paymentWrapper = SKPaymentQueueWrapper();
                          var transactions = await paymentWrapper.transactions();
                          transactions.forEach((transaction) async {
                            await paymentWrapper.finishTransaction(transaction);
                          });
                        }
                        _screenLoaders.functionLoader(context);
                        _buyProduct(widget.productDetails);
                      }),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
