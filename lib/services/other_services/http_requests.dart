import 'dart:io';
import '../../../models/auths_model.dart';

class HttpRequest {
  final Auth _auth = new Auth();
  /// initializing constructor
  HttpRequest._privateConstructor();

  /// creating private instance of class.
  static final HttpRequest _instance = HttpRequest._privateConstructor();

  /// get instance
  static HttpRequest get instance => _instance;

  final Map<String, String>? defaultHeader = {"Accept": "application/json"};
  final Map<String, String>? headerWithToken = {
    HttpHeaders.authorizationHeader: "Bearer ${Auth.accessToken}",
    "Accept": "application/json"
  };
}