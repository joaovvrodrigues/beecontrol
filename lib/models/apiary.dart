import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'bee_hive.dart';
import 'report.dart';

part 'apiary.g.dart';

@HiveType(typeId: 1)
class Apiary extends ChangeNotifier {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String city;
  @HiveField(3)
  String uf;
  @HiveField(4)
  String? image;
  @HiveField(5)
  num visits;
  @HiveField(6)
  num orphanBoxes;
  @HiveField(7)
  DateTime? lastVisit;
  @HiveField(8)
  List<Report> reports = [];
  @HiveField(9)
  int numHives;

  Apiary({
    this.id = '0',
    this.name = '',
    this.city = 'Bambuí',
    this.uf = 'MG',
    this.image,
    this.visits = 0,
    this.orphanBoxes = 0,
    this.lastVisit,
    required this.reports,
    this.numHives = 0,
  });

  void updateProvider(Apiary aux) {
    id = aux.id;
    name = aux.name;
    city = aux.city;
    uf = aux.uf;
    image = aux.image;
    visits = aux.visits;
    orphanBoxes = aux.orphanBoxes;
    lastVisit = aux.lastVisit;
    reports = aux.reports;
    numHives = aux.numHives;
    notifyListeners();
  }

  void add(BeeHive beeHive, int index) {
    reports[index].hives.add(beeHive);
    notifyListeners();
  }

  Apiary copyWith({
    String? id,
    String? name,
    String? city,
    String? uf,
    String? image,
    num? visits,
    num? orphanBoxes,
    DateTime? lastVisit,
    List<Report>? reports,
    int? numHives,
  }) {
    return Apiary(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      uf: uf ?? this.uf,
      image: image ?? this.image,
      visits: visits ?? this.visits,
      orphanBoxes: orphanBoxes ?? this.orphanBoxes,
      lastVisit: lastVisit ?? this.lastVisit,
      reports: reports ?? this.reports,
      numHives: numHives ?? this.numHives,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'uf': uf,
      'image': image,
      'visits': visits,
      'orphanBoxes': orphanBoxes,
      'lastVisit':
          lastVisit != null ? lastVisit.toString() : DateTime.now().toString(),
      'reports': reports.map((x) => x.toMap()).toList(),
      'numHives': numHives,
    };
  }

  factory Apiary.fromMap(Map<String, dynamic> map) {
    return Apiary(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      uf: map['uf'],
      image: map['image'],
      visits: map['visits'],
      orphanBoxes: map['orphanBoxes'],
      lastVisit: DateTime.parse(map['lastVisit']),
      reports: List<Report>.from(map['reports']?.map((x) => Report.fromMap(x))),
      numHives: map['numHives'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Apiary.fromJson(String source) => Apiary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Apiary(id: $id, name: $name, city: $city, uf: $uf, image: $image, visits: $visits, orphanBoxes: $orphanBoxes, lastVisit: $lastVisit, reports: $reports, numHives: $numHives)';
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
        other.visits == visits &&
        other.orphanBoxes == orphanBoxes &&
        other.lastVisit == lastVisit &&
        listEquals(other.reports, reports) &&
        other.numHives == numHives;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        city.hashCode ^
        uf.hashCode ^
        image.hashCode ^
        visits.hashCode ^
        orphanBoxes.hashCode ^
        lastVisit.hashCode ^
        reports.hashCode ^
        numHives.hashCode;
  }
}
