import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_app/items/order_item.dart';
import 'package:food_app/items/single_delivery_items.dart';
import 'package:food_app/model/delivery_address_model.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/screens/add_delivery_address_screen.dart';
import 'package:food_app/screens/mygoogle_pay.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final DeliveryAddressModel deliveryList;
  PaymentScreen({required this.deliveryList});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum PaymentType {
  Home,
  OnlinePayment,
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    double discount = 30;
    double totalPrice = reviewCartProvider.getTotalPrice();
    double disCountValue = 0;
    double total = 0;
    if (totalPrice > 300) {
      disCountValue = (totalPrice * discount) / 100;
      total = totalPrice - disCountValue;
    }

    var myType = PaymentType.OnlinePayment;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd1ad17),
        title: Text(
          "Payment Summary",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "\$${total == 0 ? totalPrice + 5 : total + 5}",
          style:
              TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              // myType == PaymentType.OnlinePayment
              //     ? Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => MyGooglePay(
              //                 total:
              //                     "\$${total == 0 ? totalPrice + 5 : total + 5}")))
              //     : Container();
            },
            child: Text(
              "Place Order",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            color: Color(0xffd1ad17),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) => Column(
            children: [
              SingleDeliveryItem(
                address:
                    "society-${widget.deliveryList.society} ,street-${widget.deliveryList.street} ,landmark-${widget.deliveryList.landmark} ,city-${widget.deliveryList.city} ,area-${widget.deliveryList.area} ,pincode-${widget.deliveryList.pincode}",
                addressType:
                    widget.deliveryList.addressType == "AddressType.Other"
                        ? "Other"
                        : widget.deliveryList.addressType == "AddressType.Home"
                            ? "Home"
                            : "Work",
                number: widget.deliveryList.mobileNumber,
                title:
                    "${widget.deliveryList.firstName} ${widget.deliveryList.lastName}",
              ),
              Divider(),
              ExpansionTile(
                title: Text(
                    "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                children: reviewCartProvider.getReviewCartDataList.map((e) {
                  return OrderItem(
                    productImage: e.CartImage,
                    productName: e.CartName,
                    productPrice: e.CartPrice,
                    productUnit: e.CartUnit,
                    productQuantity: e.CartQuantity,
                  );
                }).toList(),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  "SubTotal",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "\$${reviewCartProvider.getTotalPrice()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green[900]),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  "Shipping Charge",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: Text(
                  "\$5",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green[900]),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  "Discount",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: Text(
                  "\$${disCountValue}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green[900]),
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Payment Options"),
              ),
              RadioListTile(
                  value: PaymentType.Home,
                  groupValue: myType,
                  title: Text("Home"),
                  secondary: Icon(
                    Icons.home,
                    color: Color(0xffd1ad17),
                  ),
                  onChanged: (PaymentType? value) {
                    setState(() {
                      myType = value!;
                    });
                  }),
              RadioListTile(
                  value: PaymentType.OnlinePayment,
                  groupValue: myType,
                  title: Text("Online Payment"),
                  secondary: Icon(
                    Icons.payment,
                    color: Color(0xffd1ad17),
                  ),
                  onChanged: (PaymentType? value) {
                    setState(() {
                      myType = value!;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
