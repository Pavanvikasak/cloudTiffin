import 'dart:convert';



import 'package:http/http.dart' as http;

import '../config.dart';
import '../model/completed_model.dart';



class CompletedApi {
  static late CompletedApi _instance;

  CompletedApi._();
  static CompletedApi get instance {
    _instance = CompletedApi._();
    return _instance;
  }


  Future<List<CompletedModel>?> getAllCompleted(String user_id) async {
    print('helloooooooooo completed api');

    var response = await  http.post(
      Uri.parse('${Config.BASEURL}user/completed_list'),
      // Uri.parse('https://thesoftwareplanet.com/blossom/flutter_api/user/completed_list'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$user_id",
      }),
    );


    final data = json.decode(response.body);

    final  List responseBody = data['bookinginfo'];
    print(responseBody);
    return responseBody.map((e) => CompletedModel.fromJson(e)).toList();

    //   }

  }
}