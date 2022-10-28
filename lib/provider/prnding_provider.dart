
import 'package:flutter/widgets.dart';

import '../model/pending_model.dart';
import '../service/pending_api.dart';


enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class PendingProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<PendingModel> pendingModel = [];
  String message = '';
  String vendorid ='';
  PendingtProvider() {
    //  _fetchPending();
  }
  PendingProvider.initial({ String? userid}) {
    print(userid);
    _fetchPending(userid!);
  }


  HomeState get homeState => _homeState;

  Future<void> _fetchPending(String userid) async {
    print("hello pending");
    _homeState = HomeState.loading;
    try {
      //await Future.delayed(Duration(seconds: 5));
      final apiPending = await PendingApi.instance.getAllPending(userid);
      pendingModel = apiPending!;

      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}