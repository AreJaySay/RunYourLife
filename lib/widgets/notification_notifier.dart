import 'package:flutter/material.dart';
import 'package:run_your_life/screens/notifications/notifications.dart';
import 'package:run_your_life/services/other_services/routes.dart';

import '../services/stream_services/screens/notification_notify.dart';

class NotificationNotifier extends StatefulWidget {
  @override
  State<NotificationNotifier> createState() => _NotificationNotifierState();
}

class _NotificationNotifierState extends State<NotificationNotifier> {
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: notificationNotifyStreamServices.notify,
        builder: (context, snapshot) {
          return InkWell(
            onTap: (){
              _routes.navigator_push(context, Notifications());
              notificationNotifyStreamServices.updateNotic(data: false);
            },
            child: Stack(
              children: [
                Icon(Icons.notifications_rounded,size: 30,color: Colors.white,),
                !snapshot.hasData ? SizedBox() : snapshot.data! ? Positioned(
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
    // return InkWell(
    //   onTap: (){
    //     _routes.navigator_push(context, Notifications());
    //   },
    //   child: Stack(
    //     children: [
    //       Icon(Icons.notifications_rounded,size: 30,color: Colors.white,),
    //       Positioned(
    //         right: 0,
    //         child: Container(
    //           padding: EdgeInsets.all(1),
    //           decoration: new BoxDecoration(
    //             color: Colors.red,
    //             borderRadius: BorderRadius.circular(6),
    //           ),
    //           constraints: BoxConstraints(
    //             minWidth: 12,
    //             minHeight: 12,
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
