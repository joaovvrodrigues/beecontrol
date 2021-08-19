import 'dart:convert';

import 'package:flutter/foundation.dart';

class Hive {
  final String name;
  final List<String> situation;
  final List<String> production;
  final bool orphan;
  final num? motherHive;
  final DateTime? dateOrphan;

  Hive({
    required this.name,
    required this.situation,
    required this.production,
    this.orphan = false,
    this.motherHive,
    this.dateOrphan,
  });


  Hive copyWith({
    String? name,
    List<String>? situation,
    List<String>? production,
    bool? orphan,
    num? motherHive,
    DateTime? dateOrphan,
  }) {
    return Hive(
      name: name ?? this.name,
      situation: situation ?? this.situation,
      production: production ?? this.production,
      orphan: orphan ?? this.orphan,
      motherHive: motherHive ?? this.motherHive,
      dateOrphan: dateOrphan ?? this.dateOrphan,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'situation': situation,
      'production': production,
      'orphan': orphan,
      'motherHive': motherHive,
      'dateOrphan': dateOrphan,
    };
  }

  factory Hive.fromMap(Map<String, dynamic> map) {
    return Hive(
      name: map['name'],
      situation: List<String>.from(map['situation']),
      production: List<String>.from(map['production']),
      orphan: map['orphan'],
      motherHive: map['motherHive'],
      dateOrphan: DateTime.fromMillisecondsSinceEpoch(map['dateOrphan']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Hive.fromJson(String source) => Hive.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hive(name: $name, situation: $situation, production: $production, orphan: $orphan, motherHive: $motherHive, dateOrphan: $dateOrphan)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Hive &&
      other.name == name &&
      listEquals(other.situation, situation) &&
      listEquals(other.production, production) &&
      other.orphan == orphan &&
      other.motherHive == motherHive &&
      other.dateOrphan == dateOrphan;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      situation.hashCode ^
      production.hashCode ^
      orphan.hashCode ^
      motherHive.hashCode ^
      dateOrphan.hashCode;
  }
}
