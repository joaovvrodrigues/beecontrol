import 'dart:convert';

class Summary {
  num numApiaries;
  num numHives;
  num numReports;
  num orphanBoxes;

  Summary({
    required this.numApiaries,
    required this.numHives,
    required this.numReports,
    required this.orphanBoxes,
  });

  Summary copyWith({
    num? numApiaries,
    num? numHives,
    num? numReports,
    num? orphanBoxes,
  }) {
    return Summary(
      numApiaries: numApiaries ?? this.numApiaries,
      numHives: numHives ?? this.numHives,
      numReports: numReports ?? this.numReports,
      orphanBoxes: orphanBoxes ?? this.orphanBoxes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numApiaries': numApiaries,
      'numHives': numHives,
      'numReports': numReports,
      'orphanBoxes': orphanBoxes,
    };
  }

  factory Summary.fromMap(Map<String, dynamic> map) {
    return Summary(
      numApiaries: map['numApiaries'],
      numHives: map['numHives'],
      numReports: map['numReports'],
      orphanBoxes: map['orphanBoxes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Summary.fromJson(String source) => Summary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Resume(numApiaries: $numApiaries, numHives: $numHives, numReports: $numReports, orphanBoxes: $orphanBoxes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Summary &&
      other.numApiaries == numApiaries &&
      other.numHives == numHives &&
      other.numReports == numReports &&
      other.orphanBoxes == orphanBoxes;
  }

  @override
  int get hashCode {
    return numApiaries.hashCode ^
      numHives.hashCode ^
      numReports.hashCode ^
      orphanBoxes.hashCode;
  }
}
