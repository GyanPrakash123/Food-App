import 'package:flutter/material.dart';

class SingleDeliveryItem extends StatelessWidget {
  final String? title;
  final String? address;
  final String? number;
  final String? addressType;
  SingleDeliveryItem({this.address, this.addressType, this.number, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title!),
              Container(
                height: 20,
                width: 60,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Color(0xffd1ad17),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Text(
                  addressType!,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                )),
              ),
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: Color(0xffd1ad17),
            radius: 5,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(address!),
              SizedBox(
                height: 4,
              ),
              Text(number!),
            ],
          ),
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }
}
