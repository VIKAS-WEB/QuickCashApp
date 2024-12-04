class TransactionListDetails {
  final String? transactionDate;
  final String? transactionId;
  final String? transactionType;
  final String? transactionAmount;
  final String? trxId;
  final double? balance;
  final String? transactionStatus;
  final double? amount;
  final double? fees;
  final String? fromCurrency;

  TransactionListDetails({
    this.transactionDate,
    this.transactionId,
    this.transactionType,
    this.transactionAmount,
    this.trxId,
    this.balance,
    this.transactionStatus,
    this.amount,
    this.fees,
    this.fromCurrency,
  });

  factory TransactionListDetails.fromJson(Map<String, dynamic> json) {
    return TransactionListDetails(
      transactionDate: json['createdAt'] as String?,
      transactionId: json['trx'] as String?,
      transactionType: json['trans_type'] as String?,
      transactionAmount: json['amountText'] as String?,
      trxId: json['_id'] as String?,
      balance: (json['postBalance'] is int
          ? (json['postBalance'] as int).toDouble()
          : json['postBalance']) as double?,
      transactionStatus: json['status'] as String?,
      amount: (json['amount'] is int
          ? (json['amount'] as int).toDouble()
          : json['amount']) as double?,
      fees: (json['fee'] is int
          ? (json['fee'] as int).toDouble()
          : json['fee']) as double?,
      fromCurrency: json['from_currency'] as String?,
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
      transactionList: (json['data'] as List<dynamic>?)
          ?.map((item) => TransactionListDetails.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
