import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> search = [];
  /////////////Herbs Products Data ko Firebase se Fetch krne ka /////////////////////////
  List<ProductModel> herbsProductList = [];
  ProductModel? productModel;
  fetchHerbsProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();
    value.docs.forEach(
      (element) {
        productModel = ProductModel(
          productImage: element.get("productImage"),
          productName: element.get("productName"),
          productPrice: element.get("productPrice"),
          productId: element.get("productId"),
          productQuantity: element.get("productQuantity"),
          productUnit: element.get("productUnit"),
        );
        newList.add(productModel!);
        search.add(productModel!);
      },
    );
    herbsProductList = newList;
    //provider me set state ke taur pe use hota hai ye
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductData {
    return herbsProductList;
  }

  ///////////////////////Fresh Products ka data fetch karna hai firebase se/////////////////////
  ///
  List<ProductModel> fruitsProductList = [];
  ProductModel? fruitproductModel;
  fetchFruitsProductData() async {
    List<ProductModel> newList1 = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FruitProducts").get();
    value.docs.forEach(
      (element) {
        fruitproductModel = ProductModel(
          productImage: element.get("productImage"),
          productName: element.get("productName"),
          productPrice: element.get("productPrice"),
          productId: element.get("productId"),
          productQuantity: element.get("productQuantity"),
          productUnit: element.get("productUnit"),
        );
        newList1.add(fruitproductModel!);
        search.add(fruitproductModel!);
      },
    );
    fruitsProductList = newList1;
    //provider me set state ke taur pe use hota hai ye
    notifyListeners();
  }

  List<ProductModel> get getFruitsProductData {
    return fruitsProductList;
  }

////////////////All Search Item///////////
  List<ProductModel> get getAllSearchProduct {
    return search;
  }
}
