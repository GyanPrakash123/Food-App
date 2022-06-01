import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/provider/wishlist_provider.dart';
import 'package:food_app/screens/home_screens/review_cart_screen.dart';
import 'package:food_app/widgets/count.dart';
import 'package:provider/provider.dart';

enum SiginCharacter { fill, outline }

class ProductOverviewScreen extends StatefulWidget {
  final String? productName;
  final String? productImage;
  int? productQuantity;
  final String? productId;
  final int? productPrice;
  ProductModel? productUnit;
  ProductOverviewScreen(
      {this.productQuantity,
      this.productUnit,
      this.productName,
      this.productImage,
      this.productId,
      this.productPrice});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  SiginCharacter? _character = SiginCharacter.fill;
  WishListProvider? wishListProvider;

  Widget bottomNavigatorBar({
    Color? iconColor,
    Color? backgroundColor,
    Color? color,
    String? title,
    IconData? icon,
    void Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(children: [
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title!,
              style: TextStyle(color: color),
            )
          ]),
        ),
      ),
    );
  }

  bool wishListBool = false;
  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishListData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishListData")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted && value.exists)
                {
                  setState(() {
                    wishListBool = value.get("WishList");
                  }),
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    getWishListBool();
    return Scaffold(
      bottomNavigationBar: Row(children: [
        bottomNavigatorBar(
            backgroundColor: Color(0xffd1ad17),
            color: Colors.white70,
            iconColor: Colors.grey,
            title: "Add to Wishlist",
            icon:
                wishListBool == false ? Icons.favorite_outline : Icons.favorite,
            onTap: () {
              setState(() {
                wishListBool = !wishListBool;
              });
              if (wishListBool == true) {
                wishListProvider!.addWishListData(
                  WishListId: widget.productId,
                  WishListImage: widget.productImage,
                  WishListName: widget.productName,
                  WishListPrice: widget.productPrice,
                  WishListQuantity: 2,
                );
              } else {
                wishListProvider!.wishListDataDelete(widget.productId);
              }
            }),
        bottomNavigatorBar(
            backgroundColor: Colors.black,
            color: Colors.white70,
            iconColor: Colors.grey,
            title: "Go to Cart",
            icon: Icons.shop_outlined,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReviewCart()));
            }),
      ]),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffd1ad17),
        title: Text(
          "Product Overview",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.productName!),
                    subtitle: Text("${widget.productPrice}\$"),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(40),
                    child: Image.asset(
                      widget.productImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Available Options",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              value: SiginCharacter.fill,
                              groupValue: _character,
                              activeColor: Colors.green[700],
                              onChanged: (value) {
                                setState(() {
                                  _character = value as SiginCharacter?;
                                });
                              },
                            ),
                          ],
                        ),
                        Text("${widget.productPrice}\$"),
                        Count(
                          productId: widget.productId,
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productQuantity: widget.productQuantity,
                          productPrice: widget.productPrice,
                          productUnit: widget.productUnit,
                        ),
                        /*Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 17, color: Colors.orange),
                                Text(
                                  "ADD",
                                  style: TextStyle(color: Colors.orange),
                                )
                              ]),
                        ),*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About This Product",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Bubby’s opened on Thanksgiving Day 1990. Chef / Owner Ron Silver began baking pies and selling them to restaurants and his neighbors out of a small kitchen at the corner of Hudson and North Moore St. in Tribeca. Today, NYC’s beloved restaurant and pie shop celebrates 27 years of classic, made from scratch American cooking.",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
