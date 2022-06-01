import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  final void Function() onTap;
  final String title;
  ProductUnit({required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        height: 30,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 10),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
