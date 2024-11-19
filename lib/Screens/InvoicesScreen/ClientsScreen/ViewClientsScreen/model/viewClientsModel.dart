
class ViewClientsResponse {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? mobile;
  final String? country;
  final String? postalCode;
  final String? address;
  final String? notes;
  final String? lastUpdate;
  final String? profilePhoto;

  ViewClientsResponse({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.country,
    this.postalCode,
    this.address,
    this.notes,
    this.lastUpdate,
    this.profilePhoto,
  });

  factory ViewClientsResponse.fromJson(Map<String, dynamic> json) {
    return ViewClientsResponse(
      firstName: json['data']?['firstName'] as String?,
      lastName: json['data']?['lastName'] as String?,
      email: json['data']?['email'] as String?,
      mobile: json['data']?['mobile'] as int?,
      country: json['data']?['country'] as String?,
      postalCode: json['data']?['postalCode'] as String?,
      address: json['data']?['address'] as String?,
      notes: json['data']?['notes'] as String?,
      lastUpdate: json['data']?['updatedAt'] as String?,
      profilePhoto: json['data']?['profilePhoto'] as String?,



      /*viewClientList: (json['data'] as List<dynamic>? )
          ?.map((item) => ViewClientsData.fromJson(item as Map<String, dynamic>))
          .toList(),*/
    );
  }
}
