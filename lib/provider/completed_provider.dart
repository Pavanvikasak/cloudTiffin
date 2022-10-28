
import 'package:flutter/widgets.dart';

import '../model/completed_model.dart';
import '../service/completed_api.dart';


enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class CompletedProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<CompletedModel> completedModel = [];
  String message = '';
  String vendorid ='';
  CompletedProvider() {
    // _fetchCompleted();
  }
  CompletedProvider.initial({ String? userid}) {
    print(userid);
    _fetchCompleted(userid!);
  }



  HomeState get homeState => _homeState;

  Future<void> _fetchCompleted(String userid) async {
    // print(catid);
    _homeState = HomeState.loading;
    try {
      //await Future.delayed(Duration(seconds: 5));
      final apicompleted = await CompletedApi.instance.getAllCompleted(userid);
      completedModel = apicompleted!;

      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}