class KycStatusDetails {

  final String? kycStatus;


  KycStatusDetails({

    this.kycStatus,

  });

  factory KycStatusDetails.fromJson(Map<String, dynamic> json) {
    return KycStatusDetails(

      kycStatus: json['status'] as String?,

    );
  }
}

class KycStatusResponse {
  final int? status;
  final String? message;
  final List<KycStatusDetails>? kycStatusDetails;

  KycStatusResponse({
    this.status,
    this.message,
    this.kycStatusDetails,
  });

  factory KycStatusResponse.fromJson(Map<String, dynamic> json) {
    return KycStatusResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      kycStatusDetails: json['data'] != null
          ? (json['data'] as List)
          .map((e) => KycStatusDetails.fromJson(e as Map<String, dynamic>))
          .toList()
          : [], // Convert data into a list of KycStatusDetails
    );
  }
}
