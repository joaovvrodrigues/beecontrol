import 'dart:convert';

class UserModel {
  final String name;
  final String phone;
  final String cpf;
  final String city;
  final String uf;
  final String street;
  final String district;
  final int number;

  UserModel({
    this.name = '',
    this.phone = '',
    this.cpf = '',
    this.city = '',
    this.uf = '',
    this.street = '',
    this.district = '',
    this.number = 0,
  });

  UserModel copyWith({
    String? name,
    String? phone,
    String? cpf,
    String? city,
    String? uf,
    String? street,
    String? district,
    int? number,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      cpf: cpf ?? this.cpf,
      city: city ?? this.city,
      uf: uf ?? this.uf,
      street: street ?? this.street,
      district: district ?? this.district,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'cpf': cpf,
      'city': city,
      'uf': uf,
      'street': street,
      'district': district,
      'number': number,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      phone: map['phone'],
      cpf: map['cpf'],
      city: map['city'],
      uf: map['uf'],
      street: map['street'],
      district: map['district'],
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, phone: $phone, cpf: $cpf, city: $city, uf: $uf, street: $street, district: $district, number: $number)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.phone == phone &&
        other.cpf == cpf &&
        other.city == city &&
        other.uf == uf &&
        other.street == street &&
        other.district == district &&
        other.number == number;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        cpf.hashCode ^
        city.hashCode ^
        uf.hashCode ^
        street.hashCode ^
        district.hashCode ^
        number.hashCode;
  }
}
