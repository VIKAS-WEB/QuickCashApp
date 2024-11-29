class CryptoBuyRequest {
  final int amount;
  final String coinType;
  final String currencyType;
  final String sideType;

  CryptoBuyRequest({
    required this.amount,
    required this.coinType,
    required this.currencyType,
    required this.sideType,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'coin': coinType,
      'currency': currencyType,
      'side': sideType,
    };
  }
}


class CryptoBuyResponse {
  final int status;
  final String message;
  final CryptoBuyData data;

  CryptoBuyResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CryptoBuyResponse.fromJson(Map<String, dynamic> json) {
    return CryptoBuyResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: CryptoBuyData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class CryptoBuyData {
  final double rate;
  final double numberofCoins;
  final int fees;
  final int cryptoFees;
  final int exchangeFees;

  CryptoBuyData({
    required this.rate,
    required this.numberofCoins,
    required this.fees,
    required this.cryptoFees,
    required this.exchangeFees,
  });

  factory CryptoBuyData.fromJson(Map<String, dynamic> json) {
    return CryptoBuyData(
      rate: json['rate'] as double,
      numberofCoins: json['numberofCoins'] as double,
      fees: json['fees'] as int,
      cryptoFees: json['cryptoFees'] as int,
      exchangeFees: json['exchangeFees'] as int,
    );
  }
}

