
class AccountsListsData {
  final String? country;
  final String? currency;
  final String? iban;
  final bool? status;
  final double? amount;

  AccountsListsData({
    this.country,
    this.currency,
    this.iban,
    this.status,
    this.amount,
  });

  factory AccountsListsData.fromJson(Map<String, dynamic> json) {
    return AccountsListsData(
      country: json['country'] as String?,
      currency: json['currency'] as String?,
      iban: json['ibanText'] as String?,
      status: json['status'] as bool?,
      amount: (json['amount'] is int
          ? (json['amount'] as int).toDouble()
          : json['amount']) as double?,
    );
  }
}

class AccountListResponse {
  final List<AccountsListsData>? accountsList;

  AccountListResponse({
    this.accountsList,
  });

  factory AccountListResponse.fromJson(Map<String, dynamic> json) {
    return AccountListResponse(
      accountsList: (json['data'] as List<dynamic>? )
          ?.map((item) => AccountsListsData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
