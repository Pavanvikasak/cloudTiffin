// import 'package:demo/service/all_shop_api.dart';
import 'package:cloud_tiffin/service/quick_category_api.dart';
import 'package:flutter/widgets.dart';

import '../model/Quick_category_model.dart';

// import '../aaa/Seller_model.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class QuickProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.initial;
  List<QuickCategoryModel> allShopList = [];
  String message = '';
  String vendorid = '';

  // var catid = '';
  QuickProvider(){



  }

  QuickProvider.initial(
      {String? catid, String? distance}) {

    // print(vendorid);
    _fetchShop(catid!, distance!);
    print(catid);

    print(distance);

  }

  HomeState get homeState => _homeState;

  Future<void> _fetchShop(
      String catid, String distance) async {
    _homeState = HomeState.loading;
    try {
      final QuickCatApi = await QuickCategoryApi.instance
          .getAllShop(catid,distance);
      allShopList = QuickCatApi;

      _homeState = HomeState.loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}
