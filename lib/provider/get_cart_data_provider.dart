import 'package:flutter/widgets.dart';

import '../model/cart_models.dart';
import '../service/get_data_api.dart';

import 'new_cart_provider.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class GetCartProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<CartModel> cartDetails = [];
  String message = '  ';

  GetCartProvider() {}

  GetCartProvider.initial({String? userid}){_fetchShop(userid);}

  HomeState get homeState => _homeState;

  Future<void> _fetchShop(String? userid) async {
    _homeState = HomeState.loading;
    try {
      final getcartApi = await GetCartApi.instance.getAllCart(userid!);
      cartDetails = getcartApi!;

      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }


}
