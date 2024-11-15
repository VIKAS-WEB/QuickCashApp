class ChatDetail {
  final String? fromSide;
  final String? toSide;
  final String? message;
  final String? attachment;
  final String? date;

  ChatDetail({
    this.fromSide,
    this.toSide,
    this.message,
    this.attachment,
    this.date,
  });

  factory ChatDetail.fromJson(Map<String, dynamic> json) {
    return ChatDetail(
      fromSide: json['from'] as String?,
      toSide: json['to'] as String?,
      message: json['message'] as String?,
      attachment: json['attachment'] as String?,
      date: json['createdAt'] as String?,
    );
  }
}

class ChatHistoryResponse {
  final String? status;
  final List<ChatDetail>? chatDetails; // List of AccountDetail

  ChatHistoryResponse({
    this.status,

    this.chatDetails,
  });

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ChatHistoryResponse(
      status: json['data']?['status'] as String?,

      chatDetails: (json['data']?['chat'] as List<dynamic>?)
          ?.map((item) => ChatDetail.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
