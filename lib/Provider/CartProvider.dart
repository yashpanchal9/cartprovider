import 'dart:developer';
import 'dart:io';
import 'package:cartprovider/model/ProductModelClass.dart';
import 'package:cartprovider/Repo/Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Repo/DBHelper.dart';
import '../common.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();

  int _counter = 0;

  int get counter => _counter;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  late Future<List<DataList>> _cart;

  Future<List<DataList>> get cart => _cart;

  Future<List<DataList>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removerCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  List<DataList> product = [];
  bool isLoading = true;


  Future<void> getProductData(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        dynamic headers = {
          'Authorization':
              "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"
        };

        dynamic bodyToSend = {
          "page": "2",
          "perPage": "4",
        };

        CartListModelClass productList = await ProductRepository()
            .productDataList(ProductRepository.userUrl, bodyToSend, headers);

        if (productList.status == 200) {
          product = productList.data!;
          notifyListeners();
          isLoading = false;
        } else {
          isLoading = false;
          log("error");
        }
      }
    } catch (e) {
      log(e.toString());

      CommonWidget().neterrorDialog(context);
    }
  }
}
