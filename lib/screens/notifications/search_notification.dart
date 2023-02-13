import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/services/apis_services/screens/profile.dart';
import 'package:run_your_life/services/stream_services/screens/notifications.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/widgets/no_data.dart';
import 'package:run_your_life/widgets/shimmering_loader.dart';
import 'package:run_your_life/widgets/textfields.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SearchNotification extends StatefulWidget {
  List notifications;
  SearchNotification({required this.notifications});
  @override
  State<SearchNotification> createState() => _SearchNotificationState();
}

class _SearchNotificationState extends State<SearchNotification> {
  final AppBars _appBars = new AppBars();
  final TextEditingController _controller = new TextEditingController();
  final ProfileServices _profileServices = new ProfileServices();
  final ShimmeringLoader _shimmeringLoader = new ShimmeringLoader();
  String dropdownValue = 'Android';
  List? _local;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _local = widget.notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              SizedBox(
                height: 10,
              ),
              TextFields(_controller, hintText: "Recherche notifications",onChanged: (text){
                setState(() {
                  widget.notifications = _local!.where((s){
                    return s['title'].toString().toLowerCase().contains(text) || s['table_type'].toString().toLowerCase().contains(text) || s['message'].toString().toLowerCase().contains(text);
                  }).toList();
                });
              },),
              SizedBox(
                height: 10,
              ),
              widget.notifications.isEmpty ?
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: NoDataFound(firstString: "AUCUN", secondString: "RECHERCHE TROUVÉE", thirdString: "Veuillez vérifier l'orthographe ou essayer d'autres mots-clés."),
              )
                  :
              Expanded(
                child: GroupedListView<dynamic, String>(
                  stickyHeaderBackgroundColor: Colors.transparent,
                  elements: widget.notifications,
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
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
