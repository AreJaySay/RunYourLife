import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:run_your_life/services/apis_services/subscriptions/choose_plan.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

class RecoverSubscription extends StatefulWidget {
  @override
  State<RecoverSubscription> createState() => _RecoverSubscriptionState();
}

class _RecoverSubscriptionState extends State<RecoverSubscription> {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  final AppBars _appBars = AppBars();
  late final StreamSubscription<List<PurchaseDetails>> _subsStream;
  final BehaviorSubject<List<PurchaseDetails>> _subject = BehaviorSubject<List<PurchaseDetails>>();
  Stream<List<PurchaseDetails>> get stream => _subject.stream;
  final ChoosePlanService _service = ChoosePlanService();

  Future<void> getpastPurchases() async {
    try {
      await inAppPurchase.restorePurchases();
    } catch (e, s) {
      print("ERROR: $e");
      print("Stacktrace ; $s");
      return;
    }
  }

  Future<void> recover(PurchaseDetails details) async {
    print("NASUOLOD DDI");
    print(details.verificationData.serverVerificationData);
    print(details.verificationData.source);
    print(details.status);
    print(details.purchaseID);
    print(details.productID);
    print(details.transactionDate);
    await _service.choosePlan(context, planid: details.productID == "accompagned_subs" ? "3" : "4", purchaseToken: details.verificationData.serverVerificationData, type: details.verificationData.source == "google_play" ? "playstore" : "applestore", transacId: details.productID);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getpastPurchases();
    });
    final Stream purchaseUpdated = inAppPurchase.purchaseStream;
    _subsStream = purchaseUpdated.listen(
      (purchaseDetailsList) async {
        _subject.add(purchaseDetailsList);
      },
      onDone: () async {
        _subsStream.cancel();
      },
      cancelOnError: true,
    ) as StreamSubscription<List<PurchaseDetails>>;

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PurchaseDetails>>(
      stream: _subject.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: _appBars.whiteappbar(
            context,
            title: "Récupération Achat (Sync)",
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: !snapshot.hasData ?
            Center(
              child: CircularProgressIndicator(color: AppColors.appmaincolor,),
            ) :
            Column(
              children: [
                 for(int x = 0; x < snapshot.data!.length; x++)...{
                   ListTile(
                     tileColor: Colors.white,
                     title: Text(DateFormat("d, MMMM yyyy HH:mm", 'fr_FR').format(DateTime.fromMillisecondsSinceEpoch(
                         (snapshot.data![x]
                             .transactionDate !=
                             null
                             ? int.parse(
                             snapshot.data![x]
                                 .transactionDate!)
                             : 0) *
                             1),).toString()),
                   )
                 }
              ],
            ),
          ),
        );
      }
    );
  }
}
