class ProductModel {
  String? productName;
  String? productImage;
  int? productPrice;
  String? productId;
  int? productQuantity;
  List<dynamic>? productUnit;
  ProductModel(
      {this.productQuantity,
      this.productUnit,
      this.productImage,
      this.productName,
      this.productPrice,
      this.productId});
}
