import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  String? productImage;
  String? productName;
  int? productPrice;
  String? productUnit;
  int? productQuantity;
  OrderItem(
      {this.productImage,
      this.productQuantity,
      this.productName,
      this.productPrice,
      this.productUnit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        productImage!,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            productName!,
            style: TextStyle(color: Colors.grey[400]),
          ),
          Text(
            productUnit!,
            style: TextStyle(color: Colors.grey[400]),
          ),
          Text(
            "\$${productPrice!}",
          ),
        ],
      ),
      subtitle: Text(
        "${productQuantity!}",
        style: TextStyle(color: Colors.grey[400]),
      ),
    );
  }
}
