import 'dart:convert';





import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/accepted_model.dart';

class AcceptedApi {
  static late AcceptedApi _instance;

  AcceptedApi._();
  static AcceptedApi get instance {
    _instance = AcceptedApi._();
    return _instance;
  }


  Future<List<AcceptedModel>?> getAllAccepted(String user_id) async {
    print('helloooooooooo Accepetd api');
    SharedPreferences prefs = await SharedPreferences.getInstance();



    var response = await  http.post(
      Uri.parse('${Config.BASEURL}user/all_accepted_list'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': user_id,
      }),
    );

    //  if (response.statusCode == 200) {



    final data = json.decode(response.body);

    final  List responseBody = data['bookinginfo'];
    print(responseBody);
    return responseBody.map((e) => AcceptedModel.fromJson(e)).toList();

    //   }

  }
}