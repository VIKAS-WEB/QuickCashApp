class UserProfileRequest {
  UserProfileRequest();
}

class SenderDetail {
  final String? senderName;
  final String? senderAccountNumber;
  final String? senderAddress;

  SenderDetail({
    this.senderName,
    this.senderAccountNumber,
    this.senderAddress,
  });

  factory SenderDetail.fromJson(Map<String, dynamic> json) {
    return SenderDetail(
      senderName: json['name'] as String?,
      senderAccountNumber: json['iban'] as String?,
      senderAddress: json['address'] as String?,
    );
  }
}

class ReceiverDetail {
  final String? receiverName;
  final String? receiverAccountNumber;
  final String? receiverAddress;

  ReceiverDetail({
    this.receiverName,
    this.receiverAccountNumber,
    this.receiverAddress,
  });

  factory ReceiverDetail.fromJson(Map<String, dynamic> json) {
    return ReceiverDetail(
      receiverName: json['name'] as String?,
      receiverAccountNumber: json['iban'] as String?,
      receiverAddress: json['address'] as String?,
    );
  }
}

class TransactionDetailsListResponse {
  final String? trx;
  final String? requestedDate;
  final String? amountText; // Change to String to handle "$10.00"
  final int? fee;
  final int? billAmount;
  final String? transactionType;
  final String? extraType;
  final List<SenderDetail>? senderDetail;
  final List<ReceiverDetail>? receiverDetail;

  TransactionDetailsListResponse({
    this.trx,
    this.requestedDate,
    this.amountText,
    this.fee,
    this.billAmount,
    this.transactionType,
    this.extraType,
    this.senderDetail,
    this.receiverDetail,
  });

  factory TransactionDetailsListResponse.fromJson(Map<String, dynamic> json) {
    // Parsing `data` field (list of transaction records)
    var data = json['data'] as List<dynamic>;

    return TransactionDetailsListResponse(
      trx: data[0]['trx'] as String?, // Extract trx from the first object in the list
      requestedDate: data[0]['createdAt'] as String?,
      fee: data[0]['fee'] as int?,
      billAmount: data[0]['amount'] as int?,
      amountText: data[0]['amountText'] as String?, // Capture as String
      transactionType: data[0]['trans_type'] as String?,
      extraType: data[0]['extraType'] as String?,

      senderDetail: (data[0]['senderAccountDetails'] as List<dynamic>?)
          ?.map((item) => SenderDetail.fromJson(item as Map<String, dynamic>))
          .toList(),
      receiverDetail: (data[0]['transferAccountDetails'] as List<dynamic>?)
          ?.map((item) => ReceiverDetail.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
