import 'package:flutter/material.dart';
import 'package:food_app/items/search_items.dart';
import 'package:food_app/model/product_model.dart';

class SearchPageScreen extends StatefulWidget {
  final List<ProductModel>? search;
  SearchPageScreen({this.search});

  @override
  State<SearchPageScreen> createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  String query = "";
  List<ProductModel> SearchFood(String query) {
    List<ProductModel> searchFood = widget.search!.where((element) {
      return element.productName!.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = SearchFood(query);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Color(0xffd1ad17),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Items"),
          ),
          Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (Value) {
                setState(() {
                  query = Value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                fillColor: Color(0xffc2c2c2),
                filled: true,
                hintText: "Search for item in the store",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: _searchItem
                .map(
                  (e) => SearchItem(
                    isBool: true,
                    productId: e.productId,
                    productImage: e.productImage,
                    productName: e.productName,
                    productPrice: e.productPrice,
                    productQuantity: 5,
                    productUnit: "500 Gram",
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
