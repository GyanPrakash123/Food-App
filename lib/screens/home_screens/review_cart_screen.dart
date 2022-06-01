import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/items/search_items.dart';
import 'package:food_app/model/review_cart_model.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/screens/delivery_details_screen.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatelessWidget {
  ReviewCart({Key? key}) : super(key: key);

  ReviewCartProvider? reviewCartProvider;

  //Alert Box
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
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
        reviewCartProvider!.reviewCartDataDelete(delete.CartId);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
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

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of(context);
    reviewCartProvider!.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "\$${reviewCartProvider!.getTotalPrice()}",
          style:
              TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              if (reviewCartProvider!.getReviewCartDataList.isEmpty) {
                Fluttertoast.showToast(msg: "No Cart Data Found");
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeliveryDetailScreen()));
              }
            },
            child: Text("Submit"),
            color: Color(0xffd1ad17),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xffd1ad17),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Review Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: reviewCartProvider!.getReviewCartDataList.isEmpty
          ? Center(child: Text("No Data"))
          : ListView.builder(
              itemCount: reviewCartProvider!.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider!.getReviewCartDataList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SearchItem(
                      isBool: true,
                      productId: data.CartId,
                      productImage: data.CartImage,
                      productName: data.CartName,
                      productPrice: data.CartPrice,
                      productQuantity: data.CartQuantity,
                      productUnit: data.CartUnit,
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
