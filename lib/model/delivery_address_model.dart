class DeliveryAddressModel {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? alternateMobile;
  String? society;
  String? street;
  String? landmark;
  String? city;
  String? area;
  String? pincode;
  String? addressType;
  DeliveryAddressModel(
      {this.addressType,
      this.alternateMobile,
      this.area,
      this.city,
      this.firstName,
      this.landmark,
      this.lastName,
      this.mobileNumber,
      this.pincode,
      this.society,
      this.street});
}
