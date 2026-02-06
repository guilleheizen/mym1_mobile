import 'package:mym1_mobile/env/env.dart';

class KZBanner {
  final String code;
  final String name;
  final String description;
  final String image;
  final String type;
  final String placement;
  final String productGroupCode;
  final int position;
  final DateTime? validFrom;
  final DateTime? validTo;
  final DateTime created;
  final DateTime updated;

  const KZBanner({
    required this.code,
    required this.name,
    required this.description,
    required this.image,
    required this.type,
    required this.placement,
    required this.productGroupCode,
    required this.position,
    this.validFrom,
    this.validTo,
    required this.created,
    required this.updated,
  });

  factory KZBanner.fromJson(Map<String, dynamic> json) {
    DateTime? tryParseDate(dynamic v) {
      if (v == null) return null;
      return DateTime.parse(v.toString());
    }

    int parseInt(dynamic v) {
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? 0;
    }

    return KZBanner(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      type: json['type'] as String? ?? '',
      placement: json['placement'] as String? ?? '',
      productGroupCode: json['product_group_code'] as String? ?? '',
      position: parseInt(json['position']),
      validFrom: tryParseDate(json['validFrom']),
      validTo: tryParseDate(json['validTo']),
      created: DateTime.parse(json['created'].toString()),
      updated: DateTime.parse(json['updated'].toString()),
    );
  }

  String getImage() {
    return '${Env.fullImageUrl}$image';
  }
}
