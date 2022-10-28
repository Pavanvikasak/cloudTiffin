import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KitchenProvider with ChangeNotifier{


  int _counter =0;
  int get counter => _counter;

  void _setPrefItems()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    notifyListeners();
  }
  void _getPrefItems() async{

    SharedPreferences prefs =await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    notifyListeners();
  }
  void addCounter(){
    _counter++;
    _setPrefItems();
    notifyListeners();
  }
  void removeCounter(){
    _counter--;
    _setPrefItems();
    notifyListeners();
  }
  int getCounter(){
    _getPrefItems();
    return _counter;
  }
}