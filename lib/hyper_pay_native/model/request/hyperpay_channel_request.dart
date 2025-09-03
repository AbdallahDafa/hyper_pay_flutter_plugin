class HyperpayChannelRequest {


  String? shopperResultUrl;
  String? merchantId;
  String? checkoutId;
  bool isTest = true;
  double? amount;
  String? brandName;
  String? itemName;


  Map<String, dynamic> toJson() {
    return {
      'shopperResultUrl': shopperResultUrl,
      'merchantId': merchantId,
      'checkoutId': checkoutId,
      'isTest': isTest,
      'amount': amount,
      'brandName': _getBrandNameOrAutoDetect(),
      "isMada" : isMada(),
      "itemName" : itemName,
    };
  }

  bool isMada() {
    return brandName?[0] ==   "MADA";
  }

  _getBrandNameOrAutoDetect() {
    if(brandName == null || brandName == "" ) return "auto";
    return brandName;
  }


}