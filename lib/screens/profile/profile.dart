import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/profile/components/appbar.dart';
import 'package:run_your_life/screens/profile/components/shimmer.dart';
import 'package:run_your_life/screens/profile/components/not_subscribed.dart';
import 'package:run_your_life/services/apis_services/screens/coaching.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step1subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/step7subs.dart';
import 'package:run_your_life/services/apis_services/subscriptions/subscriptions.dart';
import 'package:run_your_life/services/stream_services/subscriptions/update_data.dart';
import '../../widgets/appbar.dart';
import 'components/general/general.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final Step1Service _step1service = new Step1Service();
  final Step7Service _step7service = new Step7Service();
  final SubscriptionServices _subscriptionServices = new SubscriptionServices();
  final CoachingServices _coachingServices = new CoachingServices();
  TabController? _controller;
  final AppBars _appBars = new AppBars();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();
    _subscriptionServices.getInfos();
    _coachingServices.getplans();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map>(
      stream: subStreamServices.subject,
      builder: (context, snapshot) {
        return Scaffold(
          body: ListView(
            shrinkWrap: true,
            children: [
              ProfileAppBar(),
              Auth.isNotSubs! ? ProfileNotSubscribed() : !snapshot.hasData ? ShimmerLoader() : ProfileGeneral(formInfo: snapshot.data!,),
            ],
          ),
        );
      }
    );
  }
}
