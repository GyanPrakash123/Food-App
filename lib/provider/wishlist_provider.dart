import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/product_model.dart';

class WishListProvider with ChangeNotifier {
  void addWishListData({
    String? WishListId,
    String? WishListImage,
    String? WishListName,
    int? WishListPrice,
    int? WishListQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection("WishListData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishListData")
        .doc(WishListId)
        .set({
      "WishListId": WishListId,
      "WishListImage": WishListImage,
      "WishListName": WishListName,
      "WishListPrice": WishListPrice,
      "WishListQuantity": WishListQuantity,
      "WishList": true,
    });
  }

  ////////////////////// Get wishList Data/////////////////
  List<ProductModel> wishList = [];
  getWishListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishListData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishListData")
        .get();
    value.docs.forEach((element) {
      ProductModel productModel = ProductModel(
        productId: element.get("WishListId"),
        productImage: element.get("WishListImage"),
        productName: element.get("WishListName"),
        productPrice: element.get("WishListPrice"),
      );
      newList.add(productModel);
    });
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishList {
    return wishList;
  }

  /////////////////// WishList Delete Function ///////////////
  wishListDataDelete(wishListId) {
    FirebaseFirestore.instance
        .collection("WishListData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishListData")
        .doc(wishListId)
        .delete();
  }
}
