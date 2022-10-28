import 'package:cloud_tiffin/service/quick_category_api.dart';
import 'package:flutter/widgets.dart';

import '../model/Quick_category_model.dart';
import '../model/cart_models.dart';
import '../service/new_cart_api.dart';
import '../service/new_removecart_api.dart';

// import '../aaa/Seller_model.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class NewRemoveCartProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<CartModel> RemovedCart = [];
  String message = '';

  // String vendorid = '';

  // var catid = '';
  NewRemoveCartProvider() {}

  NewRemoveCartProvider.initial(
      {String? productId,
        String? userid,
        String? vendorid,
        String? qty,
       }) {
    // print(vendorid);
    _fetchShop(productId!, userid!, vendorid!, qty!,
        );
  }

  HomeState get homeState => _homeState;

  Future<void> _fetchShop(String productId, String userid, String vendorid, String qty,) async {
    _homeState = HomeState.loading;
    try {
      final QuickCatApi = await NewRemoveCartApi.instance.put(productId, userid, vendorid, qty);
      RemovedCart = QuickCatApi;

      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}


