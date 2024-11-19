class Category {
  final String? id;
  final String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );
  }
}

class ProductData {
  final String? id;
  final String? productName;
  final List<Category>? categoryDetails;  // Updated to a List<Category>
  final String? date;
  final int? unitPrice;
  final String? productCode;  // Added to match the response
  final String? user;  // Added user field
  final bool? status;  // Added status field

  ProductData({
    this.id,
    this.productName,
    this.categoryDetails,
    this.date,
    this.unitPrice,
    this.productCode,
    this.user,
    this.status,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['_id'] as String?,
      productName: json['name'] as String?,
      categoryDetails: (json['categoryDetails'] as List<dynamic>?)
          ?.map((item) => Category.fromJson(item as Map<String, dynamic>))
          .toList(),
      date: json['createdAt'] as String?,
      unitPrice: json['unitPrice'] as int?,
      productCode: json['productCode'] as String?,
      user: json['user'] as String?,
      status: json['status'] as bool?,
    );
  }
}

class ProductResponse {
  final List<ProductData>? categoriesList;

  ProductResponse({
    this.categoriesList,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      categoriesList: (json['data'] as List<dynamic>?)
          ?.map((item) => ProductData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
