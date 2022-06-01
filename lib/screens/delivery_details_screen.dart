import 'package:flutter/material.dart';
import 'package:food_app/items/single_delivery_items.dart';
import 'package:food_app/model/delivery_address_model.dart';
import 'package:food_app/provider/check_out_provider.dart';
import 'package:food_app/screens/add_delivery_address_screen.dart';
import 'package:food_app/screens/payment_screen.dart';
import 'package:provider/provider.dart';

class DeliveryDetailScreen extends StatefulWidget {
  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  DeliveryAddressModel? value;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd1ad17),
        title: Text(
          "Delivery Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDeliveryAddressScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xffd1ad17),
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MaterialButton(
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddDeliveryAddressScreen()))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                              deliveryList: value!,
                            )));
          },
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Text(
                  "Add new address",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              : Text(
                  "Payment Summary",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
          color: Color(0xffd1ad17),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Delivery To"),
            leading: Image.asset(
              "assets/location.png",
              height: 30,
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey.shade400,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Container(
                  child: Center(
                    child: Text(
                      "No Data",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                )
              : Column(
                  children:
                      deliveryAddressProvider.getDeliveryAddressList.map((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItem(
                      address:
                          "society-${e.society} ,street-${e.street} ,landmark-${e.landmark} ,city-${e.city} ,area-${e.area} ,pincode-${e.pincode}",
                      addressType: e.addressType == "AddressType.Other"
                          ? "Other"
                          : e.addressType == "AddressType.Home"
                              ? "Home"
                              : "Work",
                      number: e.mobileNumber,
                      title: "${e.firstName} ${e.lastName}",
                    );
                  }).toList(),
                ),
          // Column(
          //   children: [
          //     deliveryAddressProvider.getDeliveryAddressList.isEmpty
          //         ? Container(
          //             child: Center(
          //               child: Text(
          //                 "No Data",
          //                 style: TextStyle(
          //                     color: Colors.black87,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 25),
          //               ),
          //             ),
          //           )
          //         : SingleDeliveryItem(
          //             address:
          //                 "Rani Road Bhuda Near G.N College,Dhanbad Jharkhand,PinCode-826001",
          //             addressType: "Home",
          //             number: "9031163242",
          //             title: "Gyan Prakash",
          //           ),
          //   ],
          // )
        ],
      ),
    );
  }
}
