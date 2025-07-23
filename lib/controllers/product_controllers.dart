import 'dart:convert';
import 'package:crud_api_app/app_urls.dart' show AppUrls;
import 'package:crud_api_app/models/add_new_product.dart';
import 'package:crud_api_app/models/product.dart' show ProductModel;
import 'package:http/http.dart' as http;

class ProductController {
  static Future<bool> addProduct(ProductModel product) async {
    final url = Uri.parse(AppUrls.addNewProduct);  // ঠিক url বসাতে হবে
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Add product failed: ${response.body}');
      return false;
    }
  }

}
