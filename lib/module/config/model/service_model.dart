class Service {
  final String code;
  final String endpoint;
  final String description;

  Service({
    required this.code,
    required this.endpoint,
    required this.description,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        code: json['code'] as String,
        endpoint: json['endpoint'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'endpoint': endpoint,
        'description': description,
      };

  @override
  String toString() => 'Service(code: $code, endpoint: $endpoint, description: $description)';
}
