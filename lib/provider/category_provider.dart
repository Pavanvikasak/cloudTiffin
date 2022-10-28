import 'package:flutter/material.dart';

import '../model/CategoryModel.dart';
import '../service/category_api.dart';

enum HomeState { initial, loading, loaded, error }

class CategoryProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<CategoryModel> services = [];
  String message = "";

  CategoryProvider() {
    _fechCategory();
  }

  HomeState get homeState => _homeState;

  Future<void> _fechCategory() async {
    _homeState = HomeState.loading;
    try {
      final apiCategory = await AllCategoryApi.instance.getAllCategory();
      services = apiCategory!;
      // services = apiCategory!;
      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}
