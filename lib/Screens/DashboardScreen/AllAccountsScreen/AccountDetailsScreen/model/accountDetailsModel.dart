class AccountDetailsResponse {
  final String? name;
  final double? amount; // Change to double to match API response
  final String? accountNo;
  final int? ifscCode;
  final String? currency;

  AccountDetailsResponse({
    this.name,
    this.amount,
    this.accountNo,
    this.ifscCode,
    this.currency,
  });

  factory AccountDetailsResponse.fromJson(Map<String, dynamic> json) {
    return AccountDetailsResponse(
      name: json['data']?['name'] as String?,
      amount: json['data']?['amount'] as double?, // Ensure amount is mapped as double
      accountNo: json['data']?['iban']?.toString(), // Ensure accountNo is string
      ifscCode: json['data']?['bic_code'] as int?,
      currency: json['data']?['currency'] as String?,
    );
  }
}
