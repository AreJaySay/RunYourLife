import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:run_your_life/services/apis_services/subscriptions/choose_plan.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:rxdart/rxdart.dart';

class RecoverSubscription extends StatefulWidget {
  const RecoverSubscription({Key? key}) : super(key: key);

  @override
  State<RecoverSubscription> createState() => _RecoverSubscriptionState();
}

class _RecoverSubscriptionState extends State<RecoverSubscription> {
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  final AppBars _appBars = AppBars();
  late final StreamSubscription<List<PurchaseDetails>> _subsStream;
  final BehaviorSubject<List<PurchaseDetails>> _subject =
      BehaviorSubject<List<PurchaseDetails>>();
  Stream<List<PurchaseDetails>> get stream => _subject.stream;
  Future<void> getpastPurchases() async {
    try {
      await inAppPurchase.restorePurchases();
    } catch (e, s) {
      print("ERROR: $e");
      print("Stacktrace ; $s");
      return;
    }
  }

  final ChoosePlanService _service = ChoosePlanService();
  Future<void> recover(PurchaseDetails details) async {
    /* Ikaw nala bag-o san mga data didi basta asya iton nga details an kukuhaan 
      an ig supply pag mag stream kana sana nga [stream] na akon gin himo
      ig padayon nala iton, asya man iton imo pag subscribe
    */
    // await _service.choosePlan(context, planid: planid, purchaseToken: details.verificationData.serverVerificationData, type: type, transacId: transacId)
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

  /// an sa pag himo design lands bisan ig listtile mo nala
  /// tas an ig butang la kay [TRANSACTIONDATE]
  /// naka epoch iton an transaction date [ADD_THE_CODE_BELOW]
  /// DateFormat(
  //     "d, MMMM yyyy HH:mm",
  //     'fr_FR')
  // .format(
  //   DateTime.fromMillisecondsSinceEpoch(
  //       (_pastPurchases[index]
  //                       .transactionDate !=
  //                   null
  //               ? int.parse(
  //                   _pastPurchases[
  //                           index]
  //                       .transactionDate!)
  //               : 0) *
  //           1),
  // )
  // .toUpperCase(),
  /// para ini sa transaction date
  ///
  /// tas ig convert nala an subscription name asya iton an productID
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.whiteappbar(
        context,
        title: "Récupération Achat (Sync)",
      ),
    );
  }
}
