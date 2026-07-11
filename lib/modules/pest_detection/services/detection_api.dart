import 'dart:convert';

import 'package:http/http.dart' as http;

class DetectionService {

  static const String baseUrl =
      "http://192.168.110.209:5000";

  Future<Map<String,dynamic>> detect(
      String imagePath) async {

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/detect"),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        "image",
        imagePath,
      ),
    );

    final streamed =
        await request.send();

    final response =
        await http.Response.fromStream(streamed);

    if(response.statusCode==200){

      return jsonDecode(response.body);

    }else{

      throw Exception(response.body);

    }

  }

}