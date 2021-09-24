// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:hive/hive.dart';

part 'bee_hive.g.dart';

@HiveType(typeId: 3)
class BeeHive {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<String> situation;
  @HiveField(2)
  final List<String> production;
  @HiveField(3)
  final bool orphan;
  @HiveField(4)
  final num? motherHive;
  @HiveField(5)
  final DateTime? dateOrphan;
  @HiveField(6)
  final bool count;

  BeeHive(
      {required this.name,
      required this.situation,
      required this.production,
      this.orphan = false,
      this.motherHive,
      this.dateOrphan,
      this.count = false});

  BeeHive copyWith({
    String? name,
    List<String>? situation,
    List<String>? production,
    bool? orphan,
    num? motherHive,
    DateTime? dateOrphan,
    bool? count,
  }) {
    return BeeHive(
      name: name ?? this.name,
      situation: situation ?? this.situation,
      production: production ?? this.production,
      orphan: orphan ?? this.orphan,
      motherHive: motherHive ?? this.motherHive,
      dateOrphan: dateOrphan ?? this.dateOrphan,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'situation': situation,
      'production': production,
      'orphan': orphan,
      'motherHive': motherHive,
      'dateOrphan': dateOrphan != null
          ? dateOrphan.toString()
          : DateTime.now().toString(),
      'count': count,
    };
  }

  factory BeeHive.fromMap(Map<String, dynamic> map) {
    return BeeHive(
      name: map['name'],
      situation: List<String>.from(map['situation']),
      production: List<String>.from(map['production']),
      orphan: map['orphan'],
      motherHive: map['motherHive'],
      dateOrphan: DateTime.parse(map['dateOrphan']),
      count: map['count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BeeHive.fromJson(String source) =>
      BeeHive.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BeeHive(name: $name, situation: $situation, production: $production, orphan: $orphan, motherHive: $motherHive, dateOrphan: $dateOrphan, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BeeHive &&
        other.name == name &&
        listEquals(other.situation, situation) &&
        listEquals(other.production, production) &&
        other.orphan == orphan &&
        other.motherHive == motherHive &&
        other.dateOrphan == dateOrphan &&
        other.count == count;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        situation.hashCode ^
        production.hashCode ^
        orphan.hashCode ^
        motherHive.hashCode ^
        dateOrphan.hashCode ^
        count.hashCode;
  }
}
