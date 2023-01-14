import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Base64Converter{
  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    createFileFromString(base64String: base64Encode(bytes));
    return (bytes != null ? base64Encode(bytes) : null);
  }

  Future<String> createFileFromString({required String base64String, String extension = ".pdf"}) async {
    final encodedStr = base64String;
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/" + DateTime.now().toUtc().add(Duration(hours: 2)).millisecondsSinceEpoch.toString() + "$extension");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}