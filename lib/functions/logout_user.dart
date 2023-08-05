import 'package:run_your_life/models/auths_model.dart';
import 'package:run_your_life/models/device_model.dart';
import 'package:run_your_life/models/screens/blog/blog.dart';
import 'package:run_your_life/models/subscription_models/step1_subs.dart';
import 'package:run_your_life/services/other_services/push_notifications.dart';
import 'package:run_your_life/services/stream_services/screens/blogs.dart';
import 'package:run_your_life/services/stream_services/screens/profile.dart';
import 'package:run_your_life/services/stream_services/subscriptions/update_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutUser{
 Future logout()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   Auth.loggedUser = null;
   Auth.email = null;
   Auth.pass = null;
   blogStreamServices.updateBlogs(data: []);
   subStreamServices.addSubs(data: {});
   Auth.accessToken = null;
   DeviceModel.devicefcmToken = null;
   prefs.remove('email');
   prefs.remove('password');
 }
}