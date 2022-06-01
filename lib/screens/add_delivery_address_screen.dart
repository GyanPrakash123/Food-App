import 'package:flutter/material.dart';
import 'package:food_app/provider/check_out_provider.dart';
import 'package:food_app/screens/google_map_screen.dart';
import 'package:food_app/widgets/custom_textfield_widget.dart';
import 'package:provider/provider.dart';

class AddDeliveryAddressScreen extends StatefulWidget {
  const AddDeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddressScreen> createState() =>
      _AddDeliveryAddressScreenState();
}

enum AddressType {
  Home,
  WOrk,
  Other,
}

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
    AddressType? myType = AddressType.Home;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd1ad17),
        title: Text(
          "Add Delivery Address",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 48,
        child: checkOutProvider.isLoading == false
            ? MaterialButton(
                onPressed: () {
                  checkOutProvider.Validator(context, myType);
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                color: Color(0xffd1ad17),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              )
            : Center(child: CircularProgressIndicator()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomTextField(
              labelText: "First Name",
              controller: checkOutProvider.firstName,
            ),
            CustomTextField(
              labelText: "Last Name",
              controller: checkOutProvider.lastName,
            ),
            CustomTextField(
              labelText: "Mobile Number",
              controller: checkOutProvider.mobileNumber,
            ),
            CustomTextField(
              labelText: "Alternate Mobile Number",
              controller: checkOutProvider.alternateMobile,
            ),
            CustomTextField(
              labelText: "Society",
              controller: checkOutProvider.society,
            ),
            CustomTextField(
              labelText: "Street",
              controller: checkOutProvider.street,
            ),
            CustomTextField(
              labelText: "LandMark",
              controller: checkOutProvider.landmark,
            ),
            CustomTextField(
              labelText: "City",
              controller: checkOutProvider.city,
            ),
            CustomTextField(
              labelText: "Area",
              controller: checkOutProvider.area,
            ),
            CustomTextField(
              labelText: "PinCode",
              controller: checkOutProvider.pinCode,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustumGoogleMap()));
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkOutProvider.setLocation == null
                        ? Text("Set Location")
                        : Text("Done"),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Address Type"),
            ),
            StatefulBuilder(builder: (context, _setState) {
              return Column(
                children: [
                  RadioListTile(
                      value: AddressType.Home,
                      groupValue: myType,
                      title: Text("Home"),
                      secondary: Icon(
                        Icons.home,
                        color: Color(0xffd1ad17),
                      ),
                      onChanged: (AddressType? value) {
                        _setState(() {
                          myType = value;
                        });
                      }),
                  RadioListTile(
                      value: AddressType.WOrk,
                      groupValue: myType,
                      title: Text("Work"),
                      secondary: Icon(
                        Icons.work,
                        color: Color(0xffd1ad17),
                      ),
                      onChanged: (AddressType? value) {
                        _setState(() {
                          myType = value;
                        });
                      }),
                  RadioListTile(
                      value: AddressType.Other,
                      groupValue: myType,
                      title: Text("Other"),
                      secondary: Icon(
                        Icons.devices_other,
                        color: Color(0xffd1ad17),
                      ),
                      onChanged: (AddressType? value) {
                        _setState(() {
                          myType = value;
                        });
                      }),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
