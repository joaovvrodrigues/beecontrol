import 'dart:convert';

class Apiary {
  final String name;
  final String city;
  final String uf;
  final String? image;
  final num numHives;
  Apiary({
    this.name = '',
    this.city = '',
    this.uf = '',
    this.image,
    this.numHives = 0,
  });

  Apiary copyWith({
    String? name,
    String? city,
    String? uf,
    String? image,
    num? numHives,
  }) {
    return Apiary(
      name: name ?? this.name,
      city: city ?? this.city,
      uf: uf ?? this.uf,
      image: image ?? this.image,
      numHives: numHives ?? this.numHives,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'uf': uf,
      'image': image,
      'numHives': numHives,
    };
  }

  factory Apiary.fromMap(Map<String, dynamic> map) {
    return Apiary(
      name: map['name'],
      city: map['city'],
      uf: map['uf'],
      image: map['image'],
      numHives: map['numHives'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Apiary.fromJson(String source) => Apiary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Apiary(name: $name, city: $city, uf: $uf, image: $image, numHives: $numHives)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Apiary &&
        other.name == name &&
        other.city == city &&
        other.uf == uf &&
        other.image == image &&
        other.numHives == numHives;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        city.hashCode ^
        uf.hashCode ^
        image.hashCode ^
        numHives.hashCode;
  }
}
