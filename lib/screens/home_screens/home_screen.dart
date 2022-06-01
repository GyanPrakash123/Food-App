import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/provider/user_provider.dart';
import 'package:food_app/screens/home_screens/my_profile_screen.dart';
import 'package:food_app/screens/home_screens/product_overview_screen.dart';
import 'package:food_app/screens/home_screens/review_cart_screen.dart';
import 'package:food_app/screens/home_screens/search_page_screen.dart';
import 'package:food_app/screens/home_screens/wishList_screen.dart';
import 'package:food_app/widgets/count.dart';
import 'package:food_app/widgets/productUnit.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var unitData;

  Widget singleProducts(
      String? imagePath,
      String? productId,
      String? productName,
      int? quantityPrice,
      int? quantity,
      int? productQuantity,
      final ProductModel? productUnit,
      VoidCallback? onTap) {
    return Container(
      margin: EdgeInsets.only(
        left: 8,
      ),
      height: 240,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(178, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(imagePath!)),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "${quantityPrice!}\$/${unitData == null ? "50 Gram" : unitData}",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ProductUnit(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: productUnit!.productUnit!
                                          .map((data) => Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12,
                                                        vertical: 12),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          unitData = data;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        data,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffd1ad17)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                          .toList(),

                                      // children: <Widget>[
                                      //   ListTile(
                                      //     title: new Text('50 Gram'),
                                      //     onTap: () {
                                      //       Navigator.pop(context);
                                      //     },
                                      //   ),
                                      //   ListTile(
                                      //     title: new Text('500 Gram'),
                                      //     onTap: () {
                                      //       Navigator.pop(context);
                                      //     },
                                      //   ),
                                      //   ListTile(
                                      //     title: new Text('1 Kg'),
                                      //     onTap: () {
                                      //       Navigator.pop(context);
                                      //     },
                                      //   ),
                                      //   ListTile(
                                      //     title: new Text('5 Kg'),
                                      //     onTap: () {
                                      //       Navigator.pop(context);
                                      //     },
                                      //   ),
                                      // ],
                                    );
                                  });
                            },
                            title: "${unitData == null ? "50 Gram" : unitData}",
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Count(
                          productId: productId,
                          productImage: imagePath,
                          productName: productName,
                          productQuantity: productQuantity,
                          productPrice: quantityPrice,
                          productUnit: unitData == null ? "50 Gram" : unitData,
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget listTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  void initState() {
    ProductProvider initproductProvider = Provider.of(context, listen: false);
    initproductProvider.fetchHerbsProductData();
    initproductProvider.fetchFruitsProductData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    return Scaffold(
      backgroundColor: Color(0xffcbcbcb),
      drawer: Drawer(
        child: Container(
          color: Color(0xffd1ad17),
          child: ListView(
            children: [
              DrawerHeader(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.yellow,
                          backgroundImage: NetworkImage(
                              userProvider.getCurrentUserData.userImage!),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProvider.getCurrentUserData.userName!,
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(userProvider.getCurrentUserData.userEmail!),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              listTile(
                  Icons.home_outlined,
                  "Home",
                  (() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyProfile(
                            userData: userProvider.getCurrentUserData,
                          ))))),
              listTile(
                  Icons.shop_outlined,
                  "Review Cart",
                  (() => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReviewCart())))),
              listTile(
                  Icons.person_outlined,
                  "My Profile",
                  (() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyProfile(
                            userData: userProvider.getCurrentUserData,
                          ))))),
              listTile(
                  Icons.notifications_outlined,
                  "Notification",
                  (() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyProfile(
                            userData: userProvider.getCurrentUserData,
                          ))))),
              listTile(
                  Icons.star_outlined,
                  "Rating & Review",
                  (() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyProfile(
                            userData: userProvider.getCurrentUserData,
                          ))))),
              listTile(
                  Icons.favorite_outlined,
                  "Wishlist",
                  (() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WishListScreen())))),
              listTile(
                  Icons.copy_outlined,
                  "Raise a Complaint",
                  (() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyProfile(
                            userData: userProvider.getCurrentUserData,
                          ))))),
              listTile(
                  Icons.format_quote_outlined,
                  "FAQs",
                  (() => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyProfile(
                            userData: userProvider.getCurrentUserData,
                          ))))),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 350,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Support",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Call us:',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("9031163242"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            'Mail us:',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("gyan9031163242@gmail.com"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          CircleAvatar(
            backgroundColor: Color(0xffd4d181),
            radius: 18,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchPageScreen(
                          search: productProvider.getAllSearchProduct,
                        )));
              },
              icon: Icon(
                Icons.search,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReviewCart()));
              },
              child: CircleAvatar(
                backgroundColor: Color(0xffd4d181),
                radius: 18,
                child: Icon(
                  Icons.shop,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffd6b738),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/b.jpg'),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 290),
                            child: Container(
                              height: 50,
                              width: 60,
                              decoration: BoxDecoration(
                                //color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffd1ad17),
                                    blurRadius: 1,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(35),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  "Vegi",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.blue,
                                        blurRadius: 1,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 180),
                            child: Text(
                              '30% Off',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 1,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 150),
                            child: Text(
                              'On all vegetable products',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 1,
                                    offset: Offset(2, 2),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Herbs Seasonings'),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchPageScreen(
                              search: productProvider.getHerbsProductData,
                            )));
                  },
                  child: Text(
                    "view all",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productProvider.getHerbsProductData
                  .map(
                    (productData) => singleProducts(
                      productData.productImage!,
                      productData.productId!,
                      productData.productName!,
                      productData.productPrice!,
                      50,
                      productData.productQuantity!,
                      productData,
                      (() => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductOverviewScreen(
                                productId: productData.productId!,
                                productPrice: productData.productPrice!,
                                productImage: productData.productImage!,
                                productName: productData.productName!,
                                productQuantity: productData.productQuantity!,
                                productUnit: productData,
                              ),
                            ),
                          )),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fresh Fruits'),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchPageScreen(
                              search: productProvider.getFruitsProductData,
                            )));
                  },
                  child: Text(
                    "view all",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productProvider.getFruitsProductData
                  .map(
                    (productData) => singleProducts(
                      productData.productImage!,
                      productData.productId!,
                      productData.productName!,
                      productData.productPrice!,
                      50,
                      productData.productQuantity!,
                      productData,
                      (() => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductOverviewScreen(
                                productId: productData.productId!,
                                productPrice: productData.productPrice!,
                                productImage: productData.productImage!,
                                productName: productData.productName!,
                                productQuantity: productData.productQuantity!,
                                productUnit: productData,
                              ),
                            ),
                          )),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
