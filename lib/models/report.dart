import 'dart:convert';

import 'package:flutter/foundation.dart';

class Report {
  String name;
  DateTime? date;
  num numHives;
  num orphanBoxes;
  List<String> resume;
  String comments;
  int? beePasture;

  Report(
      {this.name = '',
      this.date,
      this.numHives = 0,
      this.orphanBoxes = 0,
      required this.resume,
      this.comments = '',
      this.beePasture}); // : assert(beePasture < 3, 'beePasture must be less than 3');

  void updateProvider(Report aux) {
    name = aux.name;
    date = aux.date;
    numHives = aux.numHives;
    orphanBoxes = aux.orphanBoxes;
    resume = aux.resume;
    comments = aux.comments;
    beePasture = aux.beePasture;
  }

  Report copyWith({
    String? name,
    DateTime? date,
    num? numHives,
    num? orphanBoxes,
    List<String>? resume,
    String? comments,
    int? beePasture,
  }) {
    return Report(
      name: name ?? this.name,
      date: date ?? this.date,
      numHives: numHives ?? this.numHives,
      orphanBoxes: orphanBoxes ?? this.orphanBoxes,
      resume: resume ?? this.resume,
      comments: comments ?? this.comments,
      beePasture: beePasture ?? this.beePasture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'numHives': numHives,
      'orphanBoxes': orphanBoxes,
      'resume': resume,
      'comments': comments,
      'beePasture': beePasture,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      name: map['name'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      numHives: map['numHives'],
      orphanBoxes: map['orphanBoxes'],
      resume: List<String>.from(map['resume']),
      comments: map['comments'],
      beePasture: map['beePasture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Report(name: $name, date: $date, numHives: $numHives, orphanBoxes: $orphanBoxes, resume: $resume, comments: $comments, beePasture: $beePasture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Report &&
        other.name == name &&
        other.date == date &&
        other.numHives == numHives &&
        other.orphanBoxes == orphanBoxes &&
        listEquals(other.resume, resume) &&
        other.comments == comments &&
        other.beePasture == beePasture;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        date.hashCode ^
        numHives.hashCode ^
        orphanBoxes.hashCode ^
        resume.hashCode ^
        comments.hashCode ^
        beePasture.hashCode;
  }
}
