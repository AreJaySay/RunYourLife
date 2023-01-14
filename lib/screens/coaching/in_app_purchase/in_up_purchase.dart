import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../services/apis_services/screens/coaching.dart';
import '../../../utils/palettes/app_colors.dart';
import '../../../utils/palettes/app_gradient_colors.dart';
import '../page_loader/shimmer.dart';
import 'consumable_store.dart';

const String _macroSolo = 'macro_solo_subs';
const String _accompagned = 'accompagned_subs';
const List<String> _kProductIds = <String>[
  _macroSolo,
  _accompagned,
];

class InAppPurchasePage extends StatefulWidget {
  @override
  State<InAppPurchasePage> createState() => _InAppPurchasePageState();
}

class _InAppPurchasePageState extends State<InAppPurchasePage> {
  final CoachingServices _coachingServices = new CoachingServices();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          // handle error here.
        });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final List<String> consumables = await NonConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: <Widget>[
            _buildProductList(),
            _buildRestoreButton(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: const <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }
    return Stack(
      children: stack
    );
    // return ListView(
    //   children: <Widget>[
    //     for(int x = 0; x < _products.length; x++)...{
    //       ZoomTapAnimation(
    //         end: 0.99,
    //         child: _products[x].id != _macroSolo ?
    //         Container(
    //           margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
    //           width: double.infinity,
    //           height: 200,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10),
    //             gradient: AppGradientColors.gradient,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.grey.shade300,
    //                 blurRadius: 3.0, // has the effect of softening the shadow
    //                 spreadRadius: 1.0, // has the effect of extending the shadow
    //                 offset: Offset(
    //                   0.0, // horizontal, move right 10
    //                   1.0, // vertical, move down 10
    //                 ),
    //               )
    //             ],
    //           ),
    //           child: Stack(
    //             children: [
    //               Image(
    //                 color: Colors.white,
    //                 width: double.infinity,
    //                 alignment: Alignment.topRight,
    //                 image: AssetImage("assets/important_assets/coaching_back.png"),
    //               ),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                       width: double.infinity,
    //                       alignment: Alignment.centerLeft,
    //                       child: Row(
    //                         children: [
    //                           Text("PACK",style: TextStyle(color: Colors.white,fontSize: 17.5,fontFamily: "AppFontStyle"),),
    //                           Expanded(child: Text(" ${_products[x].title}".toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 17.5,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"))),
    //                         ],
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                       ),
    //                       padding: EdgeInsets.only(left: 20,right: 20,top: 30)
    //                   ),
    //                   Container(
    //                     padding: EdgeInsets.only(left: 20,right: 20,top: 15),
    //                     child: Text(_products[x].description,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
    //                   ),
    //                   Spacer(),
    //                   Align(
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                           color: Colors.white,
    //                           borderRadius: BorderRadius.only(
    //                               topLeft: Radius.circular(20),
    //                               bottomRight: Radius.circular(10)
    //                           )
    //                       ),
    //                       child: _products[x].price == null ? Container() :
    //                       RichText(
    //                         text: TextSpan(
    //                           text: _products[x].price.toString(),
    //                           style: TextStyle(color: AppColors.appmaincolor,fontSize: 19,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),
    //                           children: <TextSpan>[
    //                             TextSpan(text: '/mois', style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 14)),
    //                           ],
    //                         ),
    //                       ),
    //                       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
    //                     ),
    //                     alignment: Alignment.centerRight,
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ) : Container(
    //           margin: EdgeInsets.only(left: 20,right: 20,bottom: 25),
    //           width: double.infinity,
    //           height: 200,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10),
    //             color: Colors.white,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.grey.shade300,
    //                 blurRadius: 3.0, // has the effect of softening the shadow
    //                 spreadRadius: 1.0, // has the effect of extending the shadow
    //                 offset: Offset(
    //                   0.0, // horizontal, move right 10
    //                   1.0, // vertical, move down 10
    //                 ),
    //               )
    //             ],
    //           ),
    //           child: Column(
    //             children: [
    //               Container(
    //                   width: double.infinity,
    //                   alignment: Alignment.centerLeft,
    //                   child: Row(
    //                     children: [
    //                       Text("PACK",style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontFamily: "AppFontStyle"),),
    //                       Expanded(child: Text(" ${_products[x].title}".toString().toUpperCase(),style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,)),
    //                     ],
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                   ),
    //                   padding: EdgeInsets.only(left: 20,right: 20,top: 30)
    //               ),
    //               Container(
    //                 width: double.infinity,
    //                 padding: EdgeInsets.only(left: 20,right: 20,top: 15),
    //                 child: Text(_products[x].description,maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
    //               ),
    //               Spacer(),
    //               Align(
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       color: AppColors.pinkColor,
    //                       borderRadius: BorderRadius.only(
    //                           topLeft: Radius.circular(20),
    //                           bottomRight: Radius.circular(10)
    //                       )
    //                   ),
    //                   child: _products[x].price == null ? Container() :
    //                   RichText(
    //                     text: TextSpan(
    //                       text: _products[x].price.toString(),
    //                       style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),
    //                       children: <TextSpan>[
    //                         TextSpan(text: '/mois', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14)),
    //                       ],
    //                     ),
    //                   ),
    //                   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
    //                 ),
    //                 alignment: Alignment.centerRight,
    //               )
    //             ],
    //           ),
    //         ),
    //         onTap: (){
    //           final Map<String, PurchaseDetails> purchases =
    //           Map<String, PurchaseDetails>.fromEntries(
    //               _purchases.map((PurchaseDetails purchase) {
    //                 if (purchase.pendingCompletePurchase) {
    //                   _inAppPurchase.completePurchase(purchase);
    //                 }
    //                 return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    //               }));
    //           final PurchaseDetails? previousPurchase = purchases[_products[x].id];
    //           if(previousPurchase != null){
    //             confirmPriceChange(context);
    //           }else{
    //             late PurchaseParam purchaseParam;
    //             purchaseParam = PurchaseParam(
    //               productDetails: _products[x],
    //             );
    //             if (Platform.isAndroid) {
    //               final GooglePlayPurchaseDetails? oldSubscription =
    //               _getOldSubscription(_products[x], purchases);
    //
    //               purchaseParam = GooglePlayPurchaseParam(
    //                   productDetails: _products[x],
    //                   changeSubscriptionParam: (oldSubscription != null)
    //                       ? ChangeSubscriptionParam(
    //                     oldPurchaseDetails: oldSubscription,
    //                     prorationMode:
    //                     ProrationMode.immediateWithTimeProration,
    //                   )
    //                       : null);
    //             } else {
    //               purchaseParam = PurchaseParam(
    //                 productDetails: _products[x],
    //               );
    //             }
    //             _inAppPurchase.buyNonConsumable(
    //                 purchaseParam: purchaseParam);
    //           }
    //         },
    //       )
    //     },
    //     _buildRestoreButton(),
    //   ],
    // );
  }
  //
  Widget _buildProductList() {
    if (!_loading) {
      return CoachingShimmerLoader();
    }
    if (!_isAvailable) {
      return Container();
    }
    const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<Widget> productList = <Widget>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    final Map<String, PurchaseDetails> purchases =
    Map<String, PurchaseDetails>.fromEntries(
        _purchases.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
        }));
    productList.addAll(_products.map(
          (ProductDetails productDetails) {
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return ZoomTapAnimation(end: 0.99,
          child: productDetails.id != _macroSolo ?
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
            width: double.infinity,
            height: 200,
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
                            Text("PACK",style: TextStyle(color: Colors.white,fontSize: 17.5,fontFamily: "AppFontStyle"),),
                            Expanded(child: Text(" ${productDetails.title}".toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 17.5,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"))),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        padding: EdgeInsets.only(left: 20,right: 20,top: 30)
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                      child: Text(productDetails.description,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "AppFontStyle"),),
                    ),
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
                        child: productDetails.price == null ? Container() :
                        RichText(
                          text: TextSpan(
                            text: productDetails.price.toString(),
                            style: TextStyle(color: AppColors.appmaincolor,fontSize: 19,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),
                            children: <TextSpan>[
                              TextSpan(text: '/mois', style: TextStyle(color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 14)),
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
          ) : Container(
            margin: EdgeInsets.only(left: 20,right: 20,bottom: 25),
            width: double.infinity,
            height: 200,
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
                        Text("PACK",style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontFamily: "AppFontStyle"),),
                        Expanded(child: Text(" ${productDetails.title}".toString().toUpperCase(),style: TextStyle(color: AppColors.pinkColor,fontSize: 17.5,fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    padding: EdgeInsets.only(left: 20,right: 20,top: 30)
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                  child: Text(productDetails.description,maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: "AppFontStyle"),),
                ),
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
                    child: productDetails.price == null ? Container() :
                    RichText(
                      text: TextSpan(
                        text: productDetails.price.toString(),
                        style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w600,fontFamily: "AppFontStyle"),
                        children: <TextSpan>[
                          TextSpan(text: '/mois', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14)),
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
          onTap: (){
            print(productDetails.description);
            // if(previousPurchase != null){
            //   confirmPriceChange(context);
            // }else{
            //   late PurchaseParam purchaseParam;
            //   purchaseParam = PurchaseParam(
            //     productDetails: productDetails,
            //   );
            //   if (Platform.isAndroid) {
            //     final GooglePlayPurchaseDetails? oldSubscription =
            //     _getOldSubscription(productDetails, purchases);
            //
            //     purchaseParam = GooglePlayPurchaseParam(
            //         productDetails: productDetails,
            //         changeSubscriptionParam: (oldSubscription != null)
            //             ? ChangeSubscriptionParam(
            //           oldPurchaseDetails: oldSubscription,
            //           prorationMode:
            //           ProrationMode.immediateWithTimeProration,
            //         )
            //             : null);
            //   } else {
            //     purchaseParam = PurchaseParam(
            //       productDetails: productDetails,
            //     );
            //   }
            //   _inAppPurchase.buyNonConsumable(
            //       purchaseParam: purchaseParam);
            // }
          },
        );
        // return ListTile(
        //   title: Text(
        //     productDetails.title,
        //   ),
        //   subtitle: Text(
        //     productDetails.description,
        //   ),
        //   trailing: previousPurchase != null
        //       ? IconButton(
        //       onPressed: () => confirmPriceChange(context),
        //       icon: const Icon(Icons.upgrade))
        //       : TextButton(
        //     style: TextButton.styleFrom(
        //       backgroundColor: Colors.green[800],
        //       primary: Colors.white,
        //     ),
        //     onPressed: () {
        //       late PurchaseParam purchaseParam;
        //       purchaseParam = PurchaseParam(
        //         productDetails: productDetails,
        //       );
        //       // if (Platform.isAndroid) {
        //       //   final GooglePlayPurchaseDetails? oldSubscription =
        //       //   _getOldSubscription(productDetails, purchases);
        //       //
        //       //   purchaseParam = GooglePlayPurchaseParam(
        //       //       productDetails: productDetails,
        //       //       changeSubscriptionParam: (oldSubscription != null)
        //       //           ? ChangeSubscriptionParam(
        //       //         oldPurchaseDetails: oldSubscription,
        //       //         prorationMode:
        //       //         ProrationMode.immediateWithTimeProration,
        //       //       )
        //       //           : null);
        //       // } else {
        //       //   purchaseParam = PurchaseParam(
        //       //     productDetails: productDetails,
        //       //   );
        //       // }
        //
        //       if (productDetails.id == _macroSolo) {
        //         _inAppPurchase.buyConsumable(
        //             purchaseParam: purchaseParam,
        //             autoConsume: _kAutoConsume);
        //       } else {
        //         _inAppPurchase.buyNonConsumable(
        //             purchaseParam: purchaseParam);
        //       }
        //     },
        //     child: Text(productDetails.price),
        //   ),
        // );
      },
    ));

    return Card(
        child: Column(
            children: <Widget>[productHeader, const Divider()] + productList));
  }

  Widget _buildRestoreButton() {
    if (_loading) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              // TODO(darrenaustin): Migrate to new API once it lands in stable: https://github.com/flutter/flutter/issues/105724
              // ignore: deprecated_member_use
              primary: Colors.white,
            ),
            onPressed: () => _inAppPurchase.restorePurchases(),
            child: const Text('Restore purchases'),
          ),
        ],
      ),
    );
  }

  Future<void> consume(String id) async {
    await NonConsumableStore.consume(id);
    final List<String> consumables = await NonConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _macroSolo) {
      await NonConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await NonConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (purchaseDetails.productID == _macroSolo) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            _inAppPurchase.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final BillingResultWrapper priceChangeConfirmationResult =
      await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                'Price change failed with code ${priceChangeConfirmationResult.responseCode}',
          ),
        ));
      }
    }
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    GooglePlayPurchaseDetails? oldSubscription;
    oldSubscription = purchases[_accompagned]! as GooglePlayPurchaseDetails;
    return oldSubscription;
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}