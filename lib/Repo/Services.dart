import 'dart:convert';
import 'package:cartprovider/model/ProductModelClass.dart';
import 'package:http/http.dart'as http;


class ProductRepository {

  static String userUrl = 'http://209.182.213.242/~mobile/MtProject/public/api/product_list?page=2&perPage=4';


  Future<CartListModelClass> productDataList(
      String strUrl, dynamic bodyToSend, dynamic headers) async {
    return http.post(Uri.parse(strUrl), body: bodyToSend, headers: headers)
        .then((http.Response response) {
      return CartListModelClass.fromJson(json.decode(response.body));
    });
  }
}
