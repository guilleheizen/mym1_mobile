import 'package:intl/intl.dart';
import 'package:mym1_mobile/env/env.dart';

class Product {
  final String code;
  final String sku;
  final String name;
  final String description;
  final String image;
  final double price;
  final double? compareAtPrice;
  final String currency;
  final int stock;
  final String brandCode;
  final String brandName;
  final String categoryCode;
  final String categoryName;

  Product({
    required this.code,
    required this.sku,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.compareAtPrice,
    required this.currency,
    required this.stock,
    required this.brandCode,
    required this.brandName,
    required this.categoryCode,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) {
      if (v is int) return v;
      if (v is String) return int.tryParse(v) ?? 0;
      return 0;
    }

    double parseDouble(dynamic v) {
      if (v is double) return v;
      if (v is String) return double.tryParse(v) ?? 0;
      return 0;
    }

    return Product(
      code: json['code']?.toString() ?? '',
      sku: json['sku']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: parseDouble(json['price']),
      compareAtPrice: parseDouble(json['compareAtPrice']),
      currency: json['currency']?.toString() ?? '',
      stock: parseInt(json['stock']),
      brandCode: json['brandCode']?.toString() ?? '',
      brandName: json['brandName']?.toString() ?? '',
      categoryCode: json['categoryCode']?.toString() ?? '',
      categoryName: json['categoryName']?.toString() ?? '',
    );
  }

  String getImage() {
    return '${Env.fullImageUrl}$image';
  }

  String getThumbnail() {
    return '${Env.thumbnailImageUrl}$image';
  }

  String getPrice() {
    if (currency == 'PYG') {
      final formattedPrice = NumberFormat('###,###', "es-py").format(price);
      return '$formattedPrice G\$';
    }

    if (currency == 'USD') {
      final formattedPrice = NumberFormat('#,##0.00', 'en_US').format(price);
      return '$formattedPrice \$';
    }

    return 'NOT SUPPORTED PRICE';
  }

  @override
  String toString() => 'Product(code: $code, sku: $sku, name: $name)';
}
