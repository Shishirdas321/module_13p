import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:module_13p/ui/screens/update_product_screen.dart';

import '../../models/product.dart';



class ProductItem extends StatefulWidget {  //widget abstraction
  const ProductItem({super.key, required this.product,});

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
     leading: Image(
       height: 100,
       width: 40,
       image: NetworkImage('${widget.product.image}'),
     errorBuilder: (context,error,stackTrace){
         return Image.network('https://static.thenounproject.com/png/1211233-200.png');
     },
     ),
      title:  Text(widget.product.productName ??'Unknown'),
      subtitle:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${widget.product.productCode ?? 'Unknown'}'),
          Text('Quantity: ${widget.product.quantity ?? 'Unknown'}'),
          Text('Price: ${widget.product.unitPrice ?? 'Unknown'}'),
          Text('Total Price: ${widget.product.totalPrice ?? 'Unknown'}',
            style: const TextStyle(color: Colors.blue),),
          const Divider(height: 8,thickness: 3,),
        ],
      ),

      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
             // _deleteItemDialog();
              _deleteProduct();

            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, UpdateProductScreen.name,arguments: widget.product,);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  /*void _deleteItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure? Will you delete this product?'),
          backgroundColor: Colors.white,
          content: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(color: Colors.grey)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Image(
                    height: 100,
                    width: 70,
                    image: NetworkImage('${widget.product.image}'),
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                          'https://static.thenounproject.com/png/1211233-200.png');
                    },
                  ),
                  title: Text(widget.product.productName ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Code: ${widget.product.productCode ?? ''}'),
                      Text('Quantity:  ${widget.product.quantity ?? ''}'),
                      Text('Price:  ${widget.product.unitPrice ?? ''}'),
                      Text('Total Price:  ${widget.product.totalPrice ?? ''}'),
                    ],
                  ),
                  tileColor: Colors.white,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.grey)),
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _deleteProduct();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'YES',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        );
      },
    );
  }*/

Future<void> _deleteProduct ()async{
    Uri uri=Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/${widget.product.id}');
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200) {
      // final decodedData = jsonDecode(response.body);
      // if(decodedData['status']==true){
      //   print('deleted');
      // }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted!'),
        ),
      );

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('failed! try again.'),
        ),
      );
    }

}
}