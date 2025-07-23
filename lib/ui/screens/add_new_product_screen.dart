import 'dart:convert';
import 'package:crud_api_app/app_urls.dart' show AppUrls;
import 'package:crud_api_app/models/add_new_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  static const String name = '/add_new_product';

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameTEControllar = TextEditingController();
  final TextEditingController _priceTEControllar = TextEditingController();
  final TextEditingController _totalPriceTEControllar = TextEditingController();
  final TextEditingController _quantityTEControllar = TextEditingController();
  final TextEditingController _imageTEControllar = TextEditingController();
  final TextEditingController _codeTEControllar = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new product'),
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
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEControllar,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            visible:_addNewProductInProgress == false,
            replacement:const Center(
              child: CircularProgressIndicator(),
            ) ,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addNewProduct();
                }
              },
              child: const Text('Add Product'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _addNewProduct() async {
    _addNewProductInProgress = true;
    setState(() {});

    // 1. TextField থেকে ডেটা নিয়ে Model বানাই
    ProductModel newProduct = ProductModel(
      ProductName: _nameTEControllar.text.trim(),
      ProductCode: _codeTEControllar.text.trim(),
      image: _imageTEControllar.text.trim(),
      UnitPrice: _priceTEControllar.text.trim(),
      Qty: _quantityTEControllar.text.trim(),
      TotalPrice: _totalPriceTEControllar.text.trim(),
    );

    try {
      final response = await post(
        Uri.parse(AppUrls.addNewProduct), // 2. URL নিয়ে গেলাম AppUrls থেকে
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newProduct.toJson()), // 3. Model কে JSON বানায় পাঠাই
      );

      _addNewProductInProgress = false;
      setState(() {});

      if (response.statusCode == 200 || response.statusCode == 201) {
        _clearTextFields();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New product added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed! (${response.statusCode})')),
        );
      }
    } catch (e) {
      _addNewProductInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  void _clearTextFields() {
    _nameTEControllar.clear();
    _codeTEControllar.clear();
    _priceTEControllar.clear();
    _totalPriceTEControllar.clear();
    _imageTEControllar.clear();
    _quantityTEControllar.clear();
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
