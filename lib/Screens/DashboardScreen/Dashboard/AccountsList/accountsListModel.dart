class AccountsList {
  final String? transactionDate;
  final String? transactionId;
  final String? transactionType;
  final String? transactionAmount;
  final double? balance;  // Change from int? to double?
  final String? transactionStatus;

  AccountsList({
    this.transactionDate,
    this.transactionId,
    this.transactionType,
    this.transactionAmount,
    this.balance,
    this.transactionStatus,
  });

  factory AccountsList.fromJson(Map<String, dynamic> json) {
    return AccountsList(
      transactionDate: json['createdAt'] as String?,
      transactionId: json['trx'] as String?,
      transactionType: json['trans_type'] as String?,
      transactionAmount: json['amountText'] as String?,
      // Safely cast to double
      balance: (json['postBalance'] is int
          ? (json['postBalance'] as int).toDouble()
          : json['postBalance']) as double?,
      transactionStatus: json['status'] as String?,
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
