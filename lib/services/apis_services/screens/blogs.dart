import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:run_your_life/models/screens/blog/blog.dart';
import 'package:run_your_life/services/stream_services/screens/favorites.dart';
import 'package:run_your_life/utils/network_util.dart';
import '../../../models/auths_model.dart';
import '../../stream_services/screens/blogs.dart';

class BlogServices{
  final NetworkUtility _networkUtility = new NetworkUtility();

  Future getblogs({required String page, bool isPaginate = false})async{
    try {
      return await http.post(Uri.parse("${_networkUtility.url}/user/api/blogs/search?page=$page"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("BLOG ${data['data'].length.toString()}");
        if (respo.statusCode == 200 || respo.statusCode == 201){
          if(!isPaginate){
            blogStreamServices.updateBlogs(data: data['data']);
          }else{
            blogStreamServices.pagination(data: data['data']);
          }
          return data['total'];
        }else{
          return null;
        }
      });
    } catch (e) {
      print("ERROR GET BLOGS ${e.toString()}");
    }
  }

  Future blogDetails({required String blog_id})async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/blogs/${blog_id}"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        var data = json.decode(respo.body);
        print("BLOG ${data.toString()}");
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

  Future add_favorite(context,{required String id})async{
    try {
      return await http.get(Uri.parse("${_networkUtility.url}/user/api/blogs/add_favorite/$id"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
          "Accept": "application/json"
        },
      ).then((respo) async {
        print(respo.body.toString());
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
          favoriteStreamServices.update(data: data);
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