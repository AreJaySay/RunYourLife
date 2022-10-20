import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/messages/messages.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/notification_notify.dart';

class MessageNotifier extends StatefulWidget {
  @override
  State<MessageNotifier> createState() => _MessageNotifierState();
}

class _MessageNotifierState extends State<MessageNotifier> {
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: notificationNotifyStreamServices.subject,
      builder: (context, snapshot) {
        return InkWell(
          onTap: (){
            _routes.navigator_push(context, Messages());
            notificationNotifyStreamServices.update(data: false);
          },
          child: Stack(
            children: [
              Image(
                color: Colors.white,
                width: 30,
                image: AssetImage("assets/icons/chat.png"),
              ),
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
  }
}
