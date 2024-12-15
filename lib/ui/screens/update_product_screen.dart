import 'dart:convert';

import 'package:crud_api_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String name = '/update_product';
  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
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
    _quantityTEControllar.text = widget.product.quantity ?? '';
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
          child: _buildProductForm(),
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
      //TODO: Complete form validation
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEControllar,
            decoration:
                InputDecoration(hintText: 'Name', labelText: 'Product Name'),
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
                InputDecoration(hintText: 'Price', labelText: 'Product Price'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product price';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _totalPriceTEControllar,
            decoration: InputDecoration(
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
            decoration: InputDecoration(
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
                InputDecoration(hintText: 'Code', labelText: 'Product code'),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter product code';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imageTEControllar,
            decoration: InputDecoration(
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
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(
              onPressed: () {
                //TODO: check form validation
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
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');

    Map<String, dynamic> requestBody = {
      "Img": _imageTEControllar.text.trim(),
      "ProductCode": _codeTEControllar.text.trim(),
      "ProductName": _nameTEControllar.text.trim(),
      "Qty": _quantityTEControllar.text.trim(),
      "TotalPrice": _totalPriceTEControllar.text.trim(),
      "UnitPrice": _priceTEControllar.text.trim(),
    };

    Response response = await post(
        uri,
      headers: {
          'Content-type': 'application/json'
      },
        body: jsonEncode(requestBody),
    );
    print(response.statusCode);
    print(response.body);
    _updateProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product has been updated!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product has been failed! Try again.'),
        ),
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
