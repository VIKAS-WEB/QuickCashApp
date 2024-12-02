class ExchangeMoneyRequest {
  final String userId;
  final String amount;
  final String fromCurrency;
  final String toCurrency;


  ExchangeMoneyRequest({
    required this.userId,
    required this.amount,
    required this.fromCurrency,
    required this.toCurrency,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'amount': amount,
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
    };
  }
}

class ExchangeMoneyResponse {
  final int status;
  final String message;
  final ExchangeMoneyData data;

  ExchangeMoneyResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ExchangeMoneyResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeMoneyResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: ExchangeMoneyData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class ExchangeMoneyData {
  final double rate;
  final double totalFees;
  final String totalCharge;
  final double convertedAmount;
  final double sourceAccountBalance;
  final String sourceAccountCountryCode;
  final String sourceAccountNo;
  final String transferAccountCountryCode;
  final String transferAccountNo;

  ExchangeMoneyData({
    required this.rate,
    required this.totalFees,
    required this.totalCharge,
    required this.convertedAmount,
    required this.sourceAccountBalance,
    required this.sourceAccountCountryCode,
    required this.sourceAccountNo,
    required this.transferAccountCountryCode,
    required this.transferAccountNo,
  });

  factory ExchangeMoneyData.fromJson(Map<String, dynamic> json) {
    return ExchangeMoneyData(
      rate: _parseDouble (json['rate']) as double,
      totalFees: _parseDouble (json['totalFees']) as double,
      totalCharge: json['totalCharge'] as String,
      convertedAmount: _parseDouble (json['convertedAmount']) as double,
      sourceAccountBalance: _parseDouble (json['sourceAccountBalance']) as double,
      sourceAccountCountryCode: json['sourceAccuntCountryCode'] as String,
      sourceAccountNo: json['sourceAccountNo'] as String,
      transferAccountCountryCode: json['transferAccountCountryCode'] as String,
      transferAccountNo: json['transferAccountNo'] as String,
    );
  }

  // Helper function to handle the type conversion for fees
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    }
    return null;  // Return null if the value is neither int nor double
  }

}
