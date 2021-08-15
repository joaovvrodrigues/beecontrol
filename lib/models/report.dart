import 'dart:convert';

class Report {
  final String name;
  final DateTime? date;
  final num numHives;
  final num orphanBoxes;
  final String resume;

  Report({
    this.name = '',
    this.date,
    this.numHives = 0,
    this.orphanBoxes = 0,
    this.resume = '',
  });

  Report copyWith({
    String? name,
    DateTime? date,
    num? numHives,
    num? orphanBoxes,
    String? resume,
  }) {
    return Report(
      name: name ?? this.name,
      date: date ?? this.date,
      numHives: numHives ?? this.numHives,
      orphanBoxes: orphanBoxes ?? this.orphanBoxes,
      resume: resume ?? this.resume,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date!.millisecondsSinceEpoch,
      'numHives': numHives,
      'orphanBoxes': orphanBoxes,
      'resume': resume,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      name: map['name'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      numHives: map['numHives'],
      orphanBoxes: map['orphanBoxes'],
      resume: map['resume'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Report(name: $name, date: $date, numHives: $numHives, orphanBoxes: $orphanBoxes, resume: $resume)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Report &&
      other.name == name &&
      other.date == date &&
      other.numHives == numHives &&
      other.orphanBoxes == orphanBoxes &&
      other.resume == resume;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      date.hashCode ^
      numHives.hashCode ^
      orphanBoxes.hashCode ^
      resume.hashCode;
  }
}
