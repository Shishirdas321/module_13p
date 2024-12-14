import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  static const String name = '/add-new-product';

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  bool _addNewProductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Add New Product'),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              controller: _nameTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:   InputDecoration(
                hintText: 'Name',
                labelText: 'Product name',
                 border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(16.0),
                   ),
              ),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter product name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _priceTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration:   InputDecoration(
                hintText: 'Price',
                labelText: 'Product price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter product price';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField( controller: _totalTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration:    InputDecoration(
                hintText: 'Total price',
                labelText: 'Product Total price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter product Total price';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField( controller: _quantityTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration:   InputDecoration(
                hintText: 'Quantity',
                labelText: 'Product quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter product quantity';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField( controller: _codeTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:   InputDecoration(
                hintText: 'Code',
                labelText: 'Product code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter product code';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField( controller: _imageTEController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:   InputDecoration(
                hintText: 'Image url',
                labelText: 'Product Image',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter product image url';
                }
                return null;
              },),
            const SizedBox(height: 16,
            ),
            Visibility(
              visible: _addNewProductInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  _addNewProduct();
                }
              },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.teal,
                    side: const BorderSide(color: Colors.grey)),
                child:const Text('Add Product'),),
            ),
          ],
        ),
      );
  }
  
  Future<void> _addNewProduct() async{
    _addNewProductInProgress =true;
    setState(() {});
    Uri uri =Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Map<String,dynamic> requestBody ={
      "ProductName": _nameTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "Img": _imageTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalTEController.text.trim(),

    };
    Response response =await post(uri,
      headers: {
      'Content-type' : 'application/json'
      },
      body: jsonEncode(requestBody),);
    print(response.statusCode);
    print(response.body);
    _addNewProductInProgress =false;
    setState(() {});
    if(response.statusCode == 200){
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New product added'),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New product add failed! Try again.'),
        ),
      );
    }
  }

  void _clearTextFields(){
    _nameTEController.clear();
    _codeTEController.clear();
    _priceTEController.clear();
    _totalTEController.clear();
    _quantityTEController.clear();
    _imageTEController.clear();
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _codeTEController.dispose();
    _priceTEController.dispose();
    _totalTEController.dispose();
    _quantityTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
