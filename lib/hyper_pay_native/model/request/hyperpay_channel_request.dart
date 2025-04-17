class HyperpayChannelRequest {


  String? shopperResultUrl;
  String? merchantId;
  String? checkoutId;
  bool isTest = true;
  double? amount;
  String? brandName;


  Map<String, dynamic> toJson() {
    return {
      'shopperResultUrl': shopperResultUrl,
      'merchantId': merchantId,
      'checkoutId': checkoutId,
      'isTest': isTest,
      'amount': amount,
      'brandName': brandName,
      "isMada" : isMada()
    };
  }

  bool isMada() {
    return brandName?[0] ==   "MADA";
  }


}