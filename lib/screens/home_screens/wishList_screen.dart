import 'package:flutter/material.dart';
import 'package:food_app/items/search_items.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/model/review_cart_model.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  WishListScreen({Key? key}) : super(key: key);

  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        wishListProvider!.wishListDataDelete(delete.productId);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WishList Product"),
      content: Text("Would you like to continue to deleting?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  WishListProvider? wishListProvider;
  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider!.getWishListData();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xffd1ad17),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "WishList",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: wishListProvider!.getWishList.length,
          itemBuilder: (context, index) {
            ProductModel data = wishListProvider!.getWishList[index];
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SearchItem(
                  isBool: false,
                  productId: data.productId,
                  productImage: data.productImage,
                  productName: data.productName,
                  productPrice: data.productPrice,
                  productQuantity: 2,
                  productUnit: "50 Gram",
                  onDelete: () {
                    showAlertDialog(context, data);
                  },
                ),
              ],
            );
          }),
    );
  }
}
