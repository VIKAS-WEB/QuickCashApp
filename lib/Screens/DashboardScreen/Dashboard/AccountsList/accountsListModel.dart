class AccountsList {
  final String? country;
  final String? currency;
  final String? amount;
  final String? ibanText;
  final String? status;

  AccountsList({
    this.country,
    this.currency,
    this.amount,
    this.ibanText,
    this.status,
  });

  factory AccountsList.fromJson(Map<String, dynamic> json) {
    return AccountsList(
      country: json['country'] as String?,
      currency: json['currency'] as String?,
      amount: json['amount'] as String?,
      ibanText: json['ibanText'] as String?,
      status: json['status'] as String?,
    );
  }
}

class AccountListResponse {
  final List<AccountsList>? accountsList;

  AccountListResponse({
    this.accountsList,
  });

  factory AccountListResponse.fromJson(Map<String, dynamic> json) {
    return AccountListResponse(
      accountsList: (json['data'] as List<dynamic>? )
          ?.map((item) => AccountsList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
