import 'package:flutter/material.dart';
import 'package:grouped_scroll_view/grouped_scroll_view.dart';
import 'package:run_your_life/models/screens/checkin/photos.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/view_photo.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/widgets/no_data.dart';
import '../../../../../models/auths_model.dart';
import '../../../../../models/device_model.dart';
import '../../../../../utils/palettes/app_colors.dart';

class GridViewDesign extends StatefulWidget {
  final List photos;
  final int index;
  GridViewDesign({required this.photos, required this.index});
  @override
  _GridViewDesignState createState() => _GridViewDesignState();
}

class _GridViewDesignState extends State<GridViewDesign> {
  final Routes _routes = new Routes();

  @override
  Widget build(BuildContext context) {
    return widget.photos.isEmpty ?
    Padding(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      child: NoDataFound(firstString: "PAS DE PHOTOS ", secondString: "TROUVÉES ICI...", thirdString: widget.index == 3 ? "Tu n’as pas encore ajouté de photos." : "Vous n'avez pas encore ajouté de photos !"),
    ) :
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GroupedScrollView.grid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 5, crossAxisSpacing: 7, crossAxisCount: 3),
        groupedOptions: GroupedScrollViewOptions(
            itemGrouper: (s) {
              return DateFormat("MMMM yyyy","fr_FR").format(DateTime.parse((s as Map<String, dynamic>)['created_at'].toString()));
              // return (s as Map<String, dynamic>)['created_at'];
            },
            stickyHeaderBuilder: (BuildContext context, object, int groupedIndex) => Padding(
              padding: EdgeInsets.only(top: 20,bottom: 5),
              child: Text(
                object.toString().toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15),
              ),
            )
        ),
        itemBuilder: (BuildContext context, item) {
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://api.runyourlife.fr/images/clients/${Auth.loggedUser!['id'].toString()}/${(item as Map<String, dynamic>)['file_name']}")
                  )
              ),
            ),
            onTap: (){
              _routes.navigator_push(context, ViewPhoto(item,is_share: item["sharable"] == 1 ? true : false));
            },
          );
        },
        data: widget.photos,
      ),
    );
    // ListView(
    //   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
    //   children: [
    //     for(int x = 0; x < photos.dates.length; x++)...{
    //       Text(photos.dates[x].split("/")[0].toString().toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15),),
    //       SizedBox(
    //         height: 15,
    //       ),
    //       GridView.count(
    //         primary: false,
    //         shrinkWrap: true,
    //         crossAxisSpacing: 15,
    //         mainAxisSpacing: 15,
    //         crossAxisCount: DeviceModel.isMobile ? 3 : 4,
    //         children: <Widget>[
    //           for(var d = 0; d < widget.photos.length; d++)...{
    //             InkWell(
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     color: Colors.grey[300],
    //                     borderRadius: BorderRadius.circular(5),
    //                     image: DecorationImage(
    //                         fit: BoxFit.cover,
    //                         image: NetworkImage("https://api.runyourlife.fr/images/clients/${Auth.loggedUser!['id'].toString()}/${widget.photos[d]["file_name"]}")
    //                     )
    //                 ),
    //               ),
    //               onTap: (){
    //                 print(widget.photos[x]);
    //                 // _routes.navigator_push(context, ViewPhoto(widget.photos[x],is_share: widget.photos[x]["sharable"] == 1 ? true : false));
    //               },
    //             )
    //           }
    //         ],
    //       )
    //     }
    //   ],
    // );
  }
}
