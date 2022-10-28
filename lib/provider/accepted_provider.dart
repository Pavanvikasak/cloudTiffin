

import 'package:flutter/widgets.dart';

import '../model/accepted_model.dart';
import '../service/accepted_api.dart';


enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class AcceptedProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  var acceptedModel = [];
  String message = '';
  String vendorid ='';
  AcceptedProvider() {
    //  _fetchPending();
  }
  AcceptedProvider.initial({ String? userid}) {
    print(userid);
    _fetchPending(userid!);
  }


  HomeState get homeState => _homeState;

  Future<void> _fetchPending(String userid) async {
    print("hello pending");
    _homeState = HomeState.loading;
    try {
      //await Future.delayed(Duration(seconds: 5));
      final apiPending = await AcceptedApi.instance.getAllAccepted(userid);
      acceptedModel = apiPending!;

      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}