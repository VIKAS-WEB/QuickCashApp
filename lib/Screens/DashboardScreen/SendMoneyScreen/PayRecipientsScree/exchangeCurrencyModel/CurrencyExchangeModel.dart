/// Request model to encapsulate the parameters for currency conversion.
class ExchangeCurrencyRequestnew {
  final String fromCurrency;
  final String toCurrency; // Dynamic currency selected by the user.
  final double amount;

  ExchangeCurrencyRequestnew( {
    required this.fromCurrency,
    required this.amount,
    required this.toCurrency
  });

  /// Convert request data to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'from': fromCurrency,
      'to': toCurrency, // Fixed target currency.
      'amount': amount,
    };
  }
}

/// Model representing the conversion result.
class ExchangeResult {
  final String from;
  final String to;
  final double amountToConvert;
  final double convertedAmount;

  ExchangeResult({
    required this.from,
    required this.to,
    required this.amountToConvert,
    required this.convertedAmount,
  });

  factory ExchangeResult.fromJson(Map<String, dynamic> json) {
    return ExchangeResult(
      from: json['from'] as String,
      to: json['to'] as String,
      amountToConvert: (json['amountToConvert'] as num).toDouble(),
      convertedAmount: (json['convertedAmount'] as num).toDouble(),
    );
  }
}

/// Response model for the currency conversion.
class ExchangeResponse {
  final bool success;
  final List<dynamic> validationMessage;
  final ExchangeResult result;

  ExchangeResponse({
    required this.success,
    required this.validationMessage,
    required this.result,
  });

  factory ExchangeResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeResponse(
      success: json['success'] as bool,
      validationMessage: json['validationMessage'] ?? [],
      result: ExchangeResult.fromJson(json['result'] as Map<String, dynamic>),
    );
  }
}