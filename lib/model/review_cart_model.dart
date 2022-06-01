class ReviewCartModel {
  String? CartId;
  String? CartImage;
  String? CartName;
  int? CartPrice;
  int? CartQuantity;
  var CartUnit;
  ReviewCartModel(
      {this.CartId,
      this.CartUnit,
      this.CartImage,
      this.CartName,
      this.CartPrice,
      this.CartQuantity});
}
