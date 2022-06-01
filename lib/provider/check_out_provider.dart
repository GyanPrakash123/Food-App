import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/model/delivery_address_model.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier {
  bool isLoading = false;
  TextEditingController? firstName = TextEditingController();
  TextEditingController? lastName = TextEditingController();
  TextEditingController? mobileNumber = TextEditingController();
  TextEditingController? alternateMobile = TextEditingController();
  TextEditingController? society = TextEditingController();
  TextEditingController? street = TextEditingController();
  TextEditingController? landmark = TextEditingController();
  TextEditingController? city = TextEditingController();
  TextEditingController? area = TextEditingController();
  TextEditingController? pinCode = TextEditingController();
  LocationData? setLocation;

  void Validator(context, myType) async {
    if (firstName!.text.isEmpty) {
      Fluttertoast.showToast(msg: "FirstName is Empty");
    } else if (lastName!.text.isEmpty) {
      Fluttertoast.showToast(msg: "LastName is Empty");
    } else if (mobileNumber!.text.isEmpty) {
      Fluttertoast.showToast(msg: "MobileNumber is Empty");
    } else if (alternateMobile!.text.isEmpty) {
      Fluttertoast.showToast(msg: "AlternateMobile is Empty");
    } else if (society!.text.isEmpty) {
      Fluttertoast.showToast(msg: "Society is Empty");
    } else if (street!.text.isEmpty) {
      Fluttertoast.showToast(msg: "Street is Empty");
    } else if (landmark!.text.isEmpty) {
      Fluttertoast.showToast(msg: "Landmark is Empty");
    } else if (city!.text.isEmpty) {
      Fluttertoast.showToast(msg: "City is Empty");
    } else if (area!.text.isEmpty) {
      Fluttertoast.showToast(msg: "Area is Empty");
    } else if (pinCode!.text.isEmpty) {
      Fluttertoast.showToast(msg: "PinCode is Empty");
    } else if (setLocation == null) {
      Fluttertoast.showToast(msg: "SetLocation is Empty");
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliveryAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": firstName!.text,
        "lastName": lastName!.text,
        "mobileNumber": mobileNumber!.text,
        "alternateMobile": alternateMobile!.text,
        "society": society!.text,
        "street": street!.text,
        "landmark": landmark!.text,
        "city": city!.text,
        "area": area!.text,
        "pinCode": pinCode!.text,
        "addressType": myType.toString(),
        "latitude": setLocation!.latitude,
        "longitude": setLocation!.longitude,
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Delivery Address is Added");
        Navigator.pop(context);
        notifyListeners();
      });
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel? deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliveryAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstName"),
        lastName: _db.get("lastName"),
        landmark: _db.get("landmark"),
        mobileNumber: _db.get("mobileNumber"),
        alternateMobile: _db.get("alternateMobile"),
        society: _db.get("society"),
        street: _db.get("street"),
        city: _db.get("city"),
        addressType: _db.get("addressType"),
        area: _db.get("area"),
        pincode: _db.get("pinCode"),
      );
      newList.add(deliveryAddressModel);
    }
    deliveryAddressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }
}
