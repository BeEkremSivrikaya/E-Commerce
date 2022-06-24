import 'package:e_commerce_app/components/categories_list.dart';
import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:flutter/material.dart';

class ProductUpdate extends StatelessWidget {
  Product? product;
  ProductUpdate({this.product});

  onCategoryChange(String category){
    product!.category = category;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              product!.name = value.toString();
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: product!.name.toString(),
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              product!.description = value.toString();
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: product!.description.toString(),
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              product!.price = double.tryParse(value.toString());
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: product!.price.toString(),
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          CategoriesList(onChange: onCategoryChange,),
          ElevatedButton(onPressed: ()=>{
            FirebaseHelper().updateProduct(product!),
            Navigator.pop(context),
          }, child: Text("Update"))
          
        ],
      ),
    );
  }
}
