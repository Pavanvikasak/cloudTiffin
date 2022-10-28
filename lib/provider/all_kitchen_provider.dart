




import 'package:cloud_tiffin/service/accepted_api.dart';
import 'package:cloud_tiffin/service/all_kitchens_api.dart';
import 'package:flutter/widgets.dart';

import '../model/NewAllKitchenModel.dart';
import '../model/all_kitchen_model.dart';


enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class AllKitchenProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<NewAllKitchenModel> services = [];
  String message = '';

  AllKitchenProvider() {
    _fetchCat();
  }

  HomeState get homeState => _homeState;

  Future<void> _fetchCat() async {
    _homeState = HomeState.loading;
    try {
      //await Future.delayed(Duration(seconds: 5));
      final apicats = await AllKitchenApi.instance.getAllKitchen();
      services = apicats!;
      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}