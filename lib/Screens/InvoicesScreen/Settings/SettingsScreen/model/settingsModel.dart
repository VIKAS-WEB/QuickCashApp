class SettingsResponse {
  final String? id;
  final String? user;
  final String? invoiceCountry;
  final String? companyName;
  final String? mobile;
  final String? state;
  final String? city;
  final String? zipcode;
  final String? address;
  final String? logo;
  final String? prefix;
  final String? regardstext;
  final String? createdAt;
  final String? updatedAt;

  SettingsResponse({
    this.id,
    this.user,
    this.invoiceCountry,
    this.companyName,
    this.mobile,
    this.state,
    this.city,
    this.zipcode,
    this.address,
    this.logo,
    this.prefix,
    this.regardstext,
    this.createdAt,
    this.updatedAt,
  });

  factory SettingsResponse.fromJson(Map<String, dynamic> json) {
    return SettingsResponse(
      id: json['data']?['_id'] as String?,
      user: json['data']?['user'] as String?,
      invoiceCountry: json['data']?['invoice_country'] as String?,
      companyName: json['data']?['company_name'] as String?,
      mobile: json['data']?['mobile']?.toString(), // Convert mobile to String
      state: json['data']?['state'] as String?,
      city: json['data']?['city'] as String?,
      zipcode: json['data']?['zipcode'] as String?,
      address: json['data']?['address'] as String?,
      logo: json['data']?['logo'] as String?,
      prefix: json['data']?['prefix'] as String?,
      regardstext: json['data']?['regardstext'] as String?,
      createdAt: json['data']?['createdAt'] as String?,
      updatedAt: json['data']?['updatedAt'] as String?,
    );
  }
}
