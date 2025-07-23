import 'package:crud_api_app/controllers/delete_controller.dart';
import 'package:crud_api_app/models/add_new_product.dart' show ProductModel;
import 'package:crud_api_app/models/product.dart';
import 'package:crud_api_app/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //  leading: Image.network(product.image ?? '', width: 40),
      title: Text(product.ProductName ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.ProductCode ?? 'Unknown'}'),
          Text('Quantity: ${product.Qty ?? 'Unknown'}'),
          Text('Price: ${product.UnitPrice ?? 'Unknown'}'),
          Text('Total Price: ${product.TotalPrice ?? 'Unknown'}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () async {
              bool success =
                  await DeleteProductController().deleteProduct(product.id!);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(success ? 'Product Deleted' : 'Delete Failed'),
                  ),
                );

                if (success) {
                  Navigator.pop(context);
                }
              }
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UpdateProductScreen.name,
                arguments: product,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
