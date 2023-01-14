import 'package:flutter/material.dart';
import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/checkin/photos.dart';
import 'package:intl/intl.dart';
import 'package:run_your_life/screens/checkin/components/my_photos/components/view_photo.dart';
import 'package:run_your_life/services/other_services/routes.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';
import 'package:run_your_life/widgets/no_data.dart';

class GridViewDesign extends StatefulWidget {
  final List photos;
  final int index;
  GridViewDesign({required this.photos, required this.index});
  @override
  _GridViewDesignState createState() => _GridViewDesignState();
}

class _GridViewDesignState extends State<GridViewDesign> {
  final Routes _routes = new Routes();

  void sort(){
    widget.photos.sort((a,b) => a['created_at'].compareTo(b['created_at']));
    if(widget.photos.isNotEmpty){
      for(int x = 0;x < widget.photos.length; x++){
        if(!photos.dates.contains(DateFormat("MMMM/yyyy","fr").format(DateTime.parse(widget.photos[x]["created_at"].toString())))){
          photos.dates.add(DateFormat("MMMM/yyyy","fr").format(DateTime.parse(widget.photos[x]["created_at"].toString())));
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sort();
  }

  @override
  Widget build(BuildContext context) {
    return widget.photos.isEmpty ?
    Padding(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      child: NoDataFound(firstString: "PAS DE PHOTOS ", secondString: "TROUVÉES ICI...", thirdString: widget.index == 3 ? "Tu n’as pas encore ajouté de photos." : "Vous n'avez pas encore ajouté de photos !"),
    ) :
    ListView(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
      children: [
        for(int x = 0; x < photos.dates.length; x++)...{
          Text(photos.dates[x].split("/")[0].toString().toUpperCase(),style: TextStyle(fontFamily: "AppFontStyle",color: AppColors.appmaincolor,fontWeight: FontWeight.w600,fontSize: 15),),
          SizedBox(
            height: 15,
          ),
          GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: DeviceModel.isMobile ? 3 : 4,
            children: <Widget>[
              for(var x = 0; x < widget.photos.length; x++)...{
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("https://api.runyourlife.fr/images/clients/${Auth.loggedUser!['id'].toString()}/${widget.photos[x]["file_name"]}")
                        )
                    ),
                  ),
                  onTap: (){
                    _routes.navigator_push(context, ViewPhoto(widget.photos[x],is_share: widget.photos[x]["sharable"] == 1 ? true : false));
                  },
                )
              }
            ],
          )
        }
      ],
    );
  }
}
