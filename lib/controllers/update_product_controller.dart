
import 'dart:convert';
import 'package:crud_api_app/models/add_new_product.dart';
import 'package:http/http.dart' as http;
import 'package:crud_api_app/models/product.dart'; // একই ফাইল থেকে মডেল নিতে হবে
import 'package:crud_api_app/controllers/update_product_controller.dart';


class UpdateProductController {
  Future<bool> updateProduct(ProductModel product) async {
    final String url = 'https://crud.teamrabbil.com/api/v1/UpdateProduct/${product.id}';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product.toJson()), // toJson দিয়ে ডেটা পাঠাচ্ছি
      );

      if (response.statusCode == 200) {
        print("✅ Product Updated Successfully");
        return true;
      } else {
        print(" Failed to update product: ${response.body}");
        return false;
      }
    } catch (e) {
      print(" Error: $e");
      return false;
    }
  }
}
