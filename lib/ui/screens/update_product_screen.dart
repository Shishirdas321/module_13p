import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:module_13p/models/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String name = '/update-product';

  final Product product;
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  bool _updateProductInProgress =false;

  @override
  void initState() {
    super.initState();
  _nameTEController.text = widget.product.productName ?? '';
    _priceTEController.text = widget.product.unitPrice ?? '';
    _totalTEController.text = widget.product.totalPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _imageTEController.text = widget.product.image ?? '';
    _codeTEController.text = widget.product.productCode ?? '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Update Product'),
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
    return Form(//TODO:Done
      key: _formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _nameTEController,
              decoration:   InputDecoration(
                hintText: 'Name',
                labelText: 'Product name',
                 border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _priceTEController,
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
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _totalTEController,
              decoration:   InputDecoration(
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
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _quantityTEController,
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _codeTEController,
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
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _imageTEController,
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
              visible: _updateProductInProgress== false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(
                onPressed: (){
                //TODO:check from validation done
                if(_formKey.currentState!.validate()){
                  _updateProduct();
                }
              },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                    backgroundColor: Colors.teal,
                    side: const BorderSide(color: Colors.grey)),
                child:const Text('Update Product'),

              ),
            ),
          ],
        ),
      );
  }

  Future<void> _updateProduct()async{
    _updateProductInProgress = true;
    setState(() {});
    Uri uri=Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');

    Map<String,dynamic> requestBody ={
      "ProductName": _nameTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "Img": _imageTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalTEController.text.trim(),

    };
    
   Response response =await post(
       uri,
       headers: {
         'Content-type' : 'application/json'
       },
       body: jsonEncode(requestBody));
   print(response.statusCode);
   print(response.body);
    _updateProductInProgress = false;
    setState(() {});
   if(response.statusCode == 200){
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Product has been updated!'),
         ),
     );
   }else{
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Product updated failed! try again.'),
         ),
     );
   }
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
