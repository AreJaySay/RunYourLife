import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';
import '../../stream_services/screens/blogs.dart';

class BlogServices{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future getblogs()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/blogs"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          blogStreamServices.updateBlogs(data: data['data']);
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  Future add_favorite(context,{required String id})async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/blogs/add_favorite/$id"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return respo.body;
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  Future get_favorites()async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/blogs/favorite"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        if (respo.statusCode == 200 || respo.statusCode == 201){
          return data;
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }
}