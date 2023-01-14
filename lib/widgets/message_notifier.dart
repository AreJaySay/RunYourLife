import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:run_your_life/functions/loaders.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/screens/messages/messages.dart';
import 'package:run_your_life/services/apis_services/subscriptions/choose_plan.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/coaching.dart';
import 'package:run_your_life/services/stream_services/screens/notification_notify.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/utils/palettes/app_gradient_colors.dart';
import 'package:run_your_life/utils/snackbars/snackbar_message.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../screens/coaching/components/view_details.dart';
import '../screens/coaching/subscription/pack_accompanied/presentation/main_page.dart';
import '../services/stream_services/subscriptions/subscription_details.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import 'finish_questioner_popup.dart';

class MessageNotifier extends StatefulWidget {
  @override
  State<MessageNotifier> createState() => _MessageNotifierState();
}

class _MessageNotifierState extends State<MessageNotifier> {
  final Routes _routes = new Routes();
  final SnackbarMessage _snackbarMessage = new SnackbarMessage();
  final ScreenLoaders _screenLoaders = new ScreenLoaders();
  final ChoosePlanService _choosePlanService = new ChoosePlanService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: notificationNotifyStreamServices.subject,
      builder: (context, snapshot) {
        return InkWell(
          onTap: ()async{
            if(subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo")){
              if(subscriptionDetails.currentdata[0]["macro_status"] == false){
                await showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                    isScrollControlled: true,
                    context: context, builder: (context){
                  return FinishQuestionerPopup();
                });
              }else{
                await showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
                    isScrollControlled: true,
                    context: context, builder: (context){
                  return FinishQuestionerPopup(isComplete: false,);
                });
              }
            }else{
              _routes.navigator_push(context, Messages());
              notificationNotifyStreamServices.update(data: false);
            }
          },
          child: subscriptionDetails.currentdata[0]["subscription_name"].toString().contains("macro solo") ?
          Center(
            child: Image(
              color: Colors.white,
              width: 30,
              image: AssetImage("assets/icons/chat.png"),
            ),
          ) :
          Stack(
            children: [
              Image(
                color: Colors.white,
                width: 30,
                image: AssetImage("assets/icons/chat.png"),
              ),
              !snapshot.hasData ? SizedBox() : snapshot.data! ?
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                ),
              ) : SizedBox()
            ],
          ),
        );
      }
    );
  }
}
