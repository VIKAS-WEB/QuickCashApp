// login_model.dart
class DocumentsRequest {

  DocumentsRequest();

}

class DocumentsDetail {
  final String? documentsType;
  final String? documentsName;
  final String? documentPhotoFront;

  DocumentsDetail({
    this.documentsType,
    this.documentsName,
    this.documentPhotoFront,

  });

  factory DocumentsDetail.fromJson(Map<String, dynamic> json) {
    return DocumentsDetail(
      documentsType: json['documentType'] as String?,
      documentsName: json['documentNumber'] as String?,
      documentPhotoFront: json['documentPhotoFront'] as String?,
    );
  }
}

class DocumentsResponse {
  final List<DocumentsDetail>? documentsDetails; // List of AccountDetail

  DocumentsResponse({
    this.documentsDetails,
  });

  factory DocumentsResponse.fromJson(Map<String, dynamic> json) {
    return DocumentsResponse(
      documentsDetails: (json['data']?['kycDetails'] as List<dynamic>?)
          ?.map((item) => DocumentsDetail.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
