import 'package:crud_api_app/controllers/update_product_controller.dart';
import 'package:crud_api_app/models/add_new_product.dart' show ProductModel;
import 'package:flutter/material.dart';


class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String name = '/update_product';
  final ProductModel product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTEControllar = TextEditingController();
  final TextEditingController _priceTEControllar = TextEditingController();
  final TextEditingController _totalPriceTEControllar = TextEditingController();
  final TextEditingController _quantityTEControllar = TextEditingController();
  final TextEditingController _imageTEControllar = TextEditingController();
  final TextEditingController _codeTEControllar = TextEditingController();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTEControllar.text = widget.product.ProductName ?? '';
    _priceTEControllar.text = widget.product.UnitPrice ?? '';
    _totalPriceTEControllar.text = widget.product.TotalPrice ?? '';
    _quantityTEControllar.text = widget.product.Qty ?? '';
    _imageTEControllar.text = widget.product.image ?? '';
    _codeTEControllar.text = widget.product.ProductCode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: _buildProductForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(

      child: Column(
        children: [
          TextFormField(
            controller: _nameTEControllar,
            decoration:
                const InputDecoration(hintText: 'Name', labelText: 'Product Name'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _priceTEControllar,
            decoration:
                const InputDecoration(hintText: 'Price', labelText: 'Product Price'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product price';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _totalPriceTEControllar,
            decoration: const InputDecoration(
                hintText: 'Total Price', labelText: 'Product total price'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product total price';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _quantityTEControllar,
            decoration: const InputDecoration(
                hintText: 'Quantity', labelText: 'Product quantity'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product quantity';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _codeTEControllar,
            decoration:
                const InputDecoration(hintText: 'Code', labelText: 'Product code'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product code';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imageTEControllar,
            decoration: const InputDecoration(
                hintText: 'Image url', labelText: 'Product Image'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product image';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Visibility(
            visible: _updateProductInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate())
                _updateProduct();
              },
              child: const Text('Update Product'),
            ),
          ),
        ],
      ),
    );
  }



  Future<void> _updateProduct() async {
    setState(() {
      _updateProductInProgress = true;
    });

    ProductModel updatedProduct = ProductModel(
      id: widget.product.id,
      ProductName: _nameTEControllar.text.trim(),
      ProductCode: _codeTEControllar.text.trim(),
      image: _imageTEControllar.text.trim(),
      UnitPrice: _priceTEControllar.text.trim(),
      Qty: _quantityTEControllar.text.trim(),
      TotalPrice: _totalPriceTEControllar.text.trim(),
    );

    bool success = await UpdateProductController().updateProduct(updatedProduct);

    setState(() {
      _updateProductInProgress = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product has been updated!')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product update failed! Try again.')),
      );
    }
  }


  @override
  void dispose() {
    _nameTEControllar.dispose();
    _codeTEControllar.dispose();
    _priceTEControllar.dispose();
    _totalPriceTEControllar.dispose();
    _imageTEControllar.dispose();
    _quantityTEControllar.dispose();
    super.dispose();
  }
}
