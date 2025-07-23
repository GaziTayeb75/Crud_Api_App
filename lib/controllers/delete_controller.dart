// lib/controllers/delete_product_controller.dart
import 'package:http/http.dart' as http;

class DeleteProductController {
  Future<bool> deleteProduct(String id) async {
    var url = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$id");
    var response = await http.get(url); // যদি GET method হয়, নয়তো DELETE

    return response.statusCode == 200;
  }
}
