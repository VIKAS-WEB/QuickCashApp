// login_model.dart
class UserProfileRequest {


  UserProfileRequest();

}

class AccountDetail {
  final String? id;
  final String? name;
  final String? iban;
  final int? bicCode;
  final String? country;
  final String? currency;
  final double? amount;
  final bool? status;

  AccountDetail({
    this.id,
    this.name,
    this.iban,
    this.bicCode,
    this.country,
    this.currency,
    this.amount,
    this.status,
  });

  factory AccountDetail.fromJson(Map<String, dynamic> json) {
    return AccountDetail(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      iban: json['iban'] as String?,
      bicCode: json['bic_code'] as int?,
      country: json['country'] as String?,
      currency: json['currency'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as bool?,
    );
  }
}

class UserProfileResponse {
  final String? name;
  final String? email;
  final String? mobile;
  final String? country;
  final String? defaultCurrency;
  final String? address;
  final List<AccountDetail>? accountDetails; // List of AccountDetail

  UserProfileResponse({
    this.name,
    this.email,
    this.mobile,
    this.country,
    this.defaultCurrency,
    this.address,
    this.accountDetails,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      name: json['data']?['name'] as String?,
      email: json['data']?['email'] as String?,
      mobile: json['data']?['mobile']?.toString(), // Convert mobile to String
      country: json['data']?['country'] as String?,
      defaultCurrency: json['data']?['defaultCurrency'] as String?,
      address: json['data']?['address'] as String?,
      accountDetails: (json['data']?['accountDetails'] as List<dynamic>?)
          ?.map((item) => AccountDetail.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
