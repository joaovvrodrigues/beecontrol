// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:hive/hive.dart';

// 🌎 Project imports:
import 'bee_hive.dart';

part 'report.g.dart';

@HiveType(typeId: 2)
class Report {
  @HiveField(0)
  String name;
  @HiveField(1)
  DateTime? date;
  @HiveField(2)
  num numHives;
  @HiveField(3)
  num orphanBoxes;
  @HiveField(4)
  List<String> resume;
  @HiveField(5)
  String comments;
  @HiveField(6)
  int? beePasture;
  @HiveField(7)
  List<BeeHive> hives = [];
  @HiveField(8)
  bool newReport;

  Report({
    this.newReport = false,
    this.name = '',
    this.date,
    this.numHives = 0,
    this.orphanBoxes = 0,
    required this.resume,
    this.comments = '',
    this.beePasture,
    required this.hives,
  }); //: assert(beePasture < 3, 'beePasture must be less than 3');

  void add(BeeHive beeHive) {
    hives.add(beeHive);
  }

  Report copyWith({
    bool? newReport,
    String? name,
    DateTime? date,
    num? numHives,
    num? orphanBoxes,
    List<String>? resume,
    String? comments,
    int? beePasture,
    List<BeeHive>? hives,
  }) {
    return Report(
      newReport: newReport ?? this.newReport,
      name: name ?? this.name,
      date: date ?? this.date,
      numHives: numHives ?? this.numHives,
      orphanBoxes: orphanBoxes ?? this.orphanBoxes,
      resume: resume ?? this.resume,
      comments: comments ?? this.comments,
      beePasture: beePasture ?? this.beePasture,
      hives: hives ?? this.hives,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date != null ? date.toString() : DateTime.now().toString(),
      'numHives': numHives,
      'orphanBoxes': orphanBoxes,
      'resume': resume,
      'comments': comments,
      'beePasture': beePasture,
      'hives': hives.map((x) => x.toMap()).toList(),
      'newReport': newReport,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      name: map['name'],
      date: DateTime.parse(map['date']),
      numHives: map['numHives'],
      orphanBoxes: map['orphanBoxes'],
      resume: List<String>.from(map['resume']),
      comments: map['comments'],
      beePasture: map['beePasture'],
      hives: List<BeeHive>.from(map['hives']?.map((x) => BeeHive.fromMap(x))),
      newReport: map['newReport'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Report(newReport: $newReport, name: $name, date: $date, numHives: $numHives, orphanBoxes: $orphanBoxes, resume: $resume, comments: $comments, beePasture: $beePasture, hives: $hives)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Report &&
        other.newReport == newReport &&
        other.name == name &&
        other.date == date &&
        other.numHives == numHives &&
        other.orphanBoxes == orphanBoxes &&
        listEquals(other.resume, resume) &&
        other.comments == comments &&
        other.beePasture == beePasture &&
        listEquals(other.hives, hives);
  }

  @override
  int get hashCode {
    return newReport.hashCode ^
        name.hashCode ^
        date.hashCode ^
        numHives.hashCode ^
        orphanBoxes.hashCode ^
        resume.hashCode ^
        comments.hashCode ^
        beePasture.hashCode ^
        hives.hashCode;
  }
}
