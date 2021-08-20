import 'dart:convert';
import 'package:hive/hive.dart';

import 'package:flutter/foundation.dart';

import 'package:beecontrol/models/bee_hive.dart';
import 'package:beecontrol/models/report.dart';

part 'apiary.g.dart';
@HiveType(typeId: 1)
class Apiary {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String city;
  @HiveField(3)
  String uf;
  @HiveField(4)
  String? image;
  @HiveField(5)
  num numHives;
  @HiveField(6)
  num visits;
  @HiveField(7)
  num orphanBoxes;
  @HiveField(8)
  DateTime? lastVisit;
  @HiveField(9)
  List<Report> reports = [];
  @HiveField(10)
  List<BeeHive> hives = [];

  Apiary({
    this.id = 0,
    this.name = '',
    this.city = 'Bambuí',
    this.uf = 'MG',
    this.image,
    this.numHives = 0,
    this.visits = 0,
    this.orphanBoxes = 0,
    this.lastVisit,
    required this.reports,
    required this.hives,
  });

  void updateProvider(Apiary aux) {
    id = aux.id;
    name = aux.name;
    city = aux.city;
    uf = aux.uf;
    image = aux.image;
    numHives = aux.numHives;
    visits = aux.visits;
    orphanBoxes = aux.orphanBoxes;
    lastVisit = aux.lastVisit;
    reports = aux.reports;
    hives = aux.hives;
  }

  Apiary copyWith({
    int? id,
    String? name,
    String? city,
    String? uf,
    String? image,
    num? numHives,
    num? visits,
    num? orphanBoxes,
    DateTime? lastVisit,
    List<Report>? reports,
    List<BeeHive>? hives,
  }) {
    return Apiary(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      uf: uf ?? this.uf,
      image: image ?? this.image,
      numHives: numHives ?? this.numHives,
      visits: visits ?? this.visits,
      orphanBoxes: orphanBoxes ?? this.orphanBoxes,
      lastVisit: lastVisit ?? this.lastVisit,
      reports: reports ?? this.reports,
      hives: hives ?? this.hives,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'uf': uf,
      'image': image,
      'numHives': numHives,
      'visits': visits,
      'orphanBoxes': orphanBoxes,
      'lastVisit': lastVisit,
      'reports': reports.map((x) => x.toMap()).toList(),
      'hives': hives.map((x) => x.toMap()).toList(),
    };
  }

  factory Apiary.fromMap(Map<String, dynamic> map) {
    return Apiary(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      uf: map['uf'],
      image: map['image'],
      numHives: map['numHives'],
      visits: map['visits'],
      orphanBoxes: map['orphanBoxes'],
      lastVisit: map['lastVisit'],
      reports: List<Report>.from(map['reports']?.map((x) => Report.fromMap(x))),
      hives: List<BeeHive>.from(map['hives']?.map((x) => BeeHive.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Apiary.fromJson(String source) => Apiary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Apiary(id: $id, name: $name, city: $city, uf: $uf, image: $image, numHives: $numHives, visits: $visits, orphanBoxes: $orphanBoxes, lastVisit: $lastVisit, reports: $reports, hives: $hives)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Apiary &&
        other.id == id &&
        other.name == name &&
        other.city == city &&
        other.uf == uf &&
        other.image == image &&
        other.numHives == numHives &&
        other.visits == visits &&
        other.orphanBoxes == orphanBoxes &&
        other.lastVisit == lastVisit &&
        listEquals(other.reports, reports) &&
        listEquals(other.hives, hives);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        city.hashCode ^
        uf.hashCode ^
        image.hashCode ^
        numHives.hashCode ^
        visits.hashCode ^
        orphanBoxes.hashCode ^
        lastVisit.hashCode ^
        reports.hashCode ^
        hives.hashCode;
  }
}
