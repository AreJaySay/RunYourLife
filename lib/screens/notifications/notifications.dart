import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/screens/notifications/search_notification.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/services/stream_services/screens/notifications.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final AppBars _appBars = new AppBars();
  final ProfileServices _profileServices = new ProfileServices();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  final Routes _routes = new Routes();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileServices.getProfile(clientid: Auth.loggedUser!["id"].toString(), relation: "notifications");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars.bluegradient(context,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: BackButton(
              color: Colors.white,
            ),
          ),
          Text("NOTIFICATIONS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,fontFamily: "AppFontStyle"),),
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,size: 25,),
            onPressed: (){
              _routes.navigator_push(context, SearchNotification(notifications: notificationServices.current));
            },
          )
        ],
      ),),
      body: StreamBuilder<List>(
        stream: notificationServices.subject,
        builder: (context, snapshot) {
          return !snapshot.hasData ?
          Column(
            children: [
              for(int x = 0; x < 2; x++)...{
                Container(
                  padding: EdgeInsets.only(right: 20,left: 20,bottom: 15,top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmeringLoader.pageLoader(radius: 5, width: 150, height: 20),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(child: _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 20)),
                          SizedBox(
                            width: 20,
                          ),
                          _shimmeringLoader.pageLoader(radius: 5, width: 80, height: 20)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 20),
                      SizedBox(
                        height: 10,
                      ),
                      _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 20),
                      SizedBox(
                        height: 10,
                      ),
                      _shimmeringLoader.pageLoader(radius: 5, width: double.infinity, height: 20),
                      SizedBox(
                        height: 10,
                      ),
                      _shimmeringLoader.pageLoader(radius: 5, width: 300, height: 20),
                      SizedBox(
                        height: 20,
                      ),
                      _shimmeringLoader.pageLoader(radius: 5, width: 150, height: 20),
                    ],
                  ),
                ),
              }
            ],
          ) : snapshot.data!.isEmpty ?
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: NoDataFound(firstString: "AUCUNE", secondString: "NOTIFICATION TROUVÉE", thirdString: "Toutes les notifications que vous avez reçues, vous les trouverez ici."),
              )
              :
          GroupedListView<dynamic, String>(
            stickyHeaderBackgroundColor: Colors.transparent,
            elements: snapshot.data!,
            groupBy: (element) => DateFormat("yyyy-MM-dd","fr").format(DateTime.parse(element['updated_at'].toString())),
            groupComparator: (value1, value2) => value2.compareTo(value1),
            // itemComparator: (item1, item2) =>
            //     item1['name'].compareTo(item2['name']),
            order: GroupedListOrder.ASC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
              padding: EdgeInsets.only(right: 20,left: 20,bottom: 15,top: 25),
              child: Text(
                DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value)).inDays == 0 ?
                "AUJOURD'HUI" :
                DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value)).inDays == 1 ?
                "HIER" :
                DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value)).inDays > 1 && DateTime.now().toUtc().add(Duration(hours: 2)).difference(DateTime.parse(value)).inDays < 7 ?
                "IL Y A UNE SEMAINE" :
                DateFormat.yMMMd("fr").format(DateTime.parse(value.toString())),
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontFamily: "AppFontStyle"),
              ),
            ),
            itemBuilder: (c, element) {
              return ZoomTapAnimation(
                end: 0.99,
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 2),
                  color: Colors.white,
                  child: element['table_type'] == "macro" ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(element['title'],style: TextStyle(fontFamily: "AppFontStyle",fontSize: 16,color: AppColors.appmaincolor)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(element['table_type'],style: TextStyle(fontFamily: "AppFontStyle")),
                    ],
                  ) :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(element['title'],style: TextStyle(fontFamily: "AppFontStyle",fontSize: 15.5,color: AppColors.appmaincolor))),
                          Text(DateFormat("HH:mm","fr").format(DateTime.parse(element['updated_at'])),style: TextStyle(fontFamily: "AppFontStyle")),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(element['message'],style: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey[700]),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(element['table_type'],style: TextStyle(fontFamily: "AppFontStyle",color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
