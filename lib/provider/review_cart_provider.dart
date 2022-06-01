import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    String? CartId,
    String? CartImage,
    String? CartName,
    int? CartPrice,
    int? CartQuantity,
    var CartUnit,
    bool? isAdd,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(CartId)
        .set({
      "CartId": CartId,
      "CartImage": CartImage,
      "CartName": CartName,
      "CartPrice": CartPrice,
      "CartQuantity": CartQuantity,
      "CartUnit": CartUnit,
      "isAdd": true,
    });
  }

  void updateReviewCartData({
    String? CartId,
    String? CartImage,
    String? CartName,
    int? CartPrice,
    int? CartQuantity,
    bool? isAdd,
  }) async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(CartId)
        .update({
      "CartId": CartId,
      "CartImage": CartImage,
      "CartName": CartName,
      "CartPrice": CartPrice,
      "CartQuantity": CartQuantity,
      "isAdd": true,
    });
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .get();
    value.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        CartId: element.get("CartId"),
        CartImage: element.get("CartImage"),
        CartName: element.get("CartName"),
        CartPrice: element.get("CartPrice"),
        CartQuantity: element.get("CartQuantity"),
        CartUnit: element.get("CartUnit"),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

  ///////////Total Price///////////
  getTotalPrice() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      print(element.CartPrice);
      total = total + element.CartPrice! * element.CartQuantity!;
    });
    return total;
  }

  /////////////////// Review Cart Delete Function ///////////////
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete();
  }
}
