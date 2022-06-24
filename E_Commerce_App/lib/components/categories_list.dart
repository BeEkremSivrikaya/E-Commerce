import 'package:e_commerce_app/views/e_commerce.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  Function? onChange;
  CategoriesList({this.onChange});

  @override
  State<CategoriesList> createState() => _CategoriesListState(onChange: onChange);
}

class _CategoriesListState extends State<CategoriesList> {
  String? name = ECommerce.categories.first;
  List<String> categoryList = ECommerce.categories.sublist(1);
  Function? onChange;
  _CategoriesListState({this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: name,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          name=newValue;
        });
        
        widget.onChange!(newValue);
      },
      items: categoryList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}