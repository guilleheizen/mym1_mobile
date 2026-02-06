class RemoteConfig {
  final String code;
  final String value;
  final String description;
  final DateTime created;
  final DateTime updated;

  const RemoteConfig({
    required this.code,
    required this.value,
    required this.description,
    required this.created,
    required this.updated,
  });

  factory RemoteConfig.fromJson(Map<String, dynamic> json) {
    return RemoteConfig(
      code: json['code'] as String,
      value: json['value'] == null ? '' : json['value'] as String,
      description: json['description'] == null ? '' : json['description'] as String,
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'value': value,
        'description': description,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
      };

  RemoteConfig copyWith({
    String? code,
    String? value,
    String? description,
    DateTime? created,
    DateTime? updated,
  }) {
    return RemoteConfig(
      code: code ?? this.code,
      value: value ?? this.value,
      description: description ?? this.description,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemoteConfig &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          value == other.value &&
          description == other.description &&
          created == other.created &&
          updated == other.updated;

  @override
  int get hashCode => code.hashCode ^ value.hashCode ^ description.hashCode ^ created.hashCode ^ updated.hashCode;

  @override
  String toString() {
    return 'RemoteConfig(code: $code, value: $value, description: $description, created: $created, updated: $updated)';
  }
}
