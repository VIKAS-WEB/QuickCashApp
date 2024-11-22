class QuoteData {
  final String? id;
  final String? user;
  final String? account;
  final String? userId;
  final String? reference;
  final String? url;
  final List<OtherInfo>? othersInfo;
  final String? quoteNumber;
  final String? invoiceDate;
  final String? dueDate;
  final String? status;
  final String? invoiceCountry;
  final String? currency;
  final List<ProductInfo>? productsInfo;
  final double? discount;
  final String? discountType;
  final List<dynamic>? tax; // Assuming the response doesn't provide detailed tax structure
  final double? subTotal;
  final double? subDiscount;
  final double? subTax;
  final double? total;
  final String? note;
  final String? terms;
  final String? currencyText;
  final String? createdAt;
  final String? updatedAt;

  QuoteData({
    this.id,
    this.user,
    this.account,
    this.userId,
    this.reference,
    this.url,
    this.othersInfo,
    this.quoteNumber,
    this.invoiceDate,
    this.dueDate,
    this.status,
    this.invoiceCountry,
    this.currency,
    this.productsInfo,
    this.discount,
    this.discountType,
    this.tax,
    this.subTotal,
    this.subDiscount,
    this.subTax,
    this.total,
    this.note,
    this.terms,
    this.currencyText,
    this.createdAt,
    this.updatedAt,
  });

  factory QuoteData.fromJson(Map<String, dynamic> json) {
    return QuoteData(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      account: json['account'] as String?,
      userId: json['userid'] as String?,
      reference: json['reference'] as String?,
      url: json['url'] as String?,
      othersInfo: (json['othersInfo'] as List<dynamic>?)
          ?.map((item) => OtherInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
      quoteNumber: json['quote_number'] as String?,
      invoiceDate: json['invoice_date'] as String?,
      dueDate: json['due_date'] as String?,
      status: json['status'] as String?,
      invoiceCountry: json['invoice_country'] as String?,
      currency: json['currency'] as String?,
      productsInfo: (json['productsInfo'] as List<dynamic>?)
          ?.map((item) => ProductInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
      discount: (json['discount'] as num?)?.toDouble(),
      discountType: json['discount_type'] as String?,
      tax: json['tax'] as List<dynamic>?,
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      subDiscount: (json['sub_discount'] as num?)?.toDouble(),
      subTax: (json['sub_tax'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      note: json['note'] as String?,
      terms: json['terms'] as String?,
      currencyText: json['currency_text'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class OtherInfo {
  final String? name;
  final String? email;
  final String? address;

  OtherInfo({
    this.name,
    this.email,
    this.address,
  });

  factory OtherInfo.fromJson(Map<String, dynamic> json) {
    return OtherInfo(
      name: json['name'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
    );
  }
}

class ProductInfo {
  final String? productName;
  final String? productId;
  final String? qty;
  final double? price;
  final double? tax;
  final double? taxValue;
  final double? amount;

  ProductInfo({
    this.productName,
    this.productId,
    this.qty,
    this.price,
    this.tax,
    this.taxValue,
    this.amount,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      productName: json['productName'] as String?,
      productId: json['productId'] as String?,
      qty: json['qty'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      taxValue: (json['taxValue'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
    );
  }
}

class QuoteResponse {
  final List<QuoteData>? quoteList;

  QuoteResponse({
    this.quoteList,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) {
    return QuoteResponse(
      quoteList: (json['data'] as List<dynamic>?)
          ?.map((item) => QuoteData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
