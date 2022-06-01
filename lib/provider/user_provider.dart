import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    User? currentUser,
    String? userName,
    String? userImage,
    String? userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("userData")
        .doc(currentUser!.uid)
        .set({
      "userName": userName,
      "userEmail": userEmail,
      "userImage": userImage,
      "userUid": currentUser.uid,
    });
  }

  UserModel? currData;
  void getUserData() async {
    UserModel? userModel;
    var value = await FirebaseFirestore.instance
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("userEmail"),
        userImage: value.get("userImage"),
        userName: value.get("userName"),
        userUid: value.get("userUid"),
      );
      // print(userModel.userEmail);
      // print(userModel.userUid);
      // print(userModel.userName);
      // print(userModel.userImage);
      currData = userModel;

      notifyListeners();
    }
  }

  UserModel get getCurrentUserData {
    return currData!;
  }
}
