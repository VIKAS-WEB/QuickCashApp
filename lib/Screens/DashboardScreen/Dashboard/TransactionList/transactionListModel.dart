class TransactionListDetails {
  final String? transactionDate;
  final String? transactionId;
  final String? transactionType;
  final String? transactionAmount;
  final String? trxId;
  final double? balance;  // Change from int? to double?
  final String? transactionStatus;

  TransactionListDetails({
    this.transactionDate,
    this.transactionId,
    this.transactionType,
    this.transactionAmount,
    this.trxId,
    this.balance,
    this.transactionStatus,
  });

  factory TransactionListDetails.fromJson(Map<String, dynamic> json) {
    return TransactionListDetails(
      transactionDate: json['createdAt'] as String?,
      transactionId: json['trx'] as String?,
      transactionType: json['trans_type'] as String?,
      transactionAmount: json['amountText'] as String?,
      trxId: json['_id'] as String?,
      // Safely cast to double
      balance: (json['postBalance'] is int
          ? (json['postBalance'] as int).toDouble()
          : json['postBalance']) as double?,
      transactionStatus: json['status'] as String?,
    );
  }
}

class TransactionListResponse {
  final List<TransactionListDetails>? transactionList;

  TransactionListResponse({
    this.transactionList,
  });

  factory TransactionListResponse.fromJson(Map<String, dynamic> json) {
    return TransactionListResponse(
      transactionList: (json['data'] as List<dynamic>? )
          ?.map((item) => TransactionListDetails.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
