import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  String? productImage;
  String? productName;
  String? productId;
  int? productQuantity;
  int? productPrice;
  var productUnit;
  Count(
      {this.productId,
      this.productUnit,
      this.productImage,
      this.productName,
      this.productPrice,
      this.productQuantity});

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int cartQuantity = 1;
  bool isAdd = false;

  void getAddAndQuantity() async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        cartQuantity = value.get("cartQuantity");
                        isAdd = value.get("isAdd");
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);

    getAddAndQuantity();
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      height: 30,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: /*isAdd == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (cartQuantity == 1) {
                      setState(() {
                        isAdd = false;
                      });
                      reviewCartProvider!
                          .reviewCartDataDelete(widget.productId);
                    } else if (cartQuantity > 1) {
                      setState(() {
                        cartQuantity--;
                      });

                      reviewCartProvider!.updateReviewCartData(
                        CartId: widget.productId,
                        CartImage: widget.productImage,
                        CartName: widget.productName,
                        CartPrice: widget.productPrice,
                        CartQuantity: cartQuantity,
                        isAdd: true,
                      );
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    size: 15,
                    color: Colors.orange,
                  ),
                ),
                Text("$cartQuantity"),
                InkWell(
                  onTap: () {
                    setState(() {
                      cartQuantity++;
                    });
                    reviewCartProvider!.updateReviewCartData(
                      CartId: widget.productId,
                      CartImage: widget.productImage,
                      CartName: widget.productName,
                      CartPrice: widget.productPrice,
                      CartQuantity: cartQuantity,
                      isAdd: true,
                    );
                  },
                  child: Icon(
                    Icons.add,
                    size: 15,
                    color: Colors.orange,
                  ),
                ),
              ],
            )
          :*/
          Center(
        child: InkWell(
          onTap: () {
            if (isAdd == false) {
              setState(() {
                isAdd = true;
                Fluttertoast.showToast(msg: "Product is Added on Cart");
              });
            } else {
              Fluttertoast.showToast(msg: "Product is Present on Cart");
            }
            reviewCartProvider.addReviewCartData(
              CartId: widget.productId,
              CartImage: widget.productImage,
              CartName: widget.productName,
              CartPrice: widget.productPrice,
              CartQuantity: cartQuantity,
              CartUnit: widget.productUnit,
            );
          },
          child: Text(
            "ADD",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
