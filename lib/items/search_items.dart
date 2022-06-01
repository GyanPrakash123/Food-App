import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatefulWidget {
  bool isBool = false;
  String? productImage;
  String? productName;
  String? productId;
  int? productPrice;
  int? productQuantity;
  var productUnit;
  void Function()? onDelete;
  SearchItem(
      {required this.isBool,
      this.productUnit,
      this.productId,
      this.productImage,
      this.productName,
      this.productPrice,
      this.productQuantity,
      this.onDelete});

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  ReviewCartProvider? reviewCartProvider;
  late int count;
  getCount() {
    setState(() {
      count = widget.productQuantity!;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of(context);
    reviewCartProvider!.getReviewCartData();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: Image.asset(widget.productImage!),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.productName!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.productPrice}\$",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      widget.isBool == false
                          ? Container(
                              margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(children: [
                                Expanded(
                                  child: Text(
                                    widget.productUnit,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                                Center(child: Icon(Icons.arrow_drop_down)),
                              ]),
                            )
                          : Text(
                              widget.productUnit,
                            ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: widget.isBool == false ? 100 : 150,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 32),
                  child: widget.isBool == false
                      ? Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            border: widget.isBool == true
                                ? Border.all(color: Colors.grey)
                                : Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: widget.onDelete,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            InkWell(
                              onTap: widget.onDelete,
                              child: Icon(
                                Icons.delete,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 25,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (count == 1) {
                                          Fluttertoast.showToast(
                                              msg: "You Reach Minimum Limit");
                                        } else {
                                          setState(() {
                                            count--;
                                          });
                                          reviewCartProvider!
                                              .updateReviewCartData(
                                            CartId: widget.productId,
                                            CartImage: widget.productImage,
                                            CartName: widget.productName,
                                            CartPrice: widget.productPrice,
                                            CartQuantity: count,
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      "$count",
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (count < 10) {
                                          setState(() {
                                            count++;
                                          });
                                          reviewCartProvider!
                                              .updateReviewCartData(
                                            CartId: widget.productId,
                                            CartImage: widget.productImage,
                                            CartName: widget.productName,
                                            CartPrice: widget.productPrice,
                                            CartQuantity: count,
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              ),
      ],
    );
  }
}
