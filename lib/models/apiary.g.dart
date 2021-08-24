// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApiaryAdapter extends TypeAdapter<Apiary> {
  @override
  final int typeId = 1;

  @override
  Apiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Apiary(
      id: fields[0] as String,
      name: fields[1] as String,
      city: fields[2] as String,
      uf: fields[3] as String,
      image: fields[4] as String?,
      numHives: fields[5] as num,
      visits: fields[6] as num,
      orphanBoxes: fields[7] as num,
      lastVisit: fields[8] as DateTime?,
      reports: (fields[9] as List).cast<Report>(),
      hives: (fields[10] as List).cast<BeeHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, Apiary obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.uf)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.numHives)
      ..writeByte(6)
      ..write(obj.visits)
      ..writeByte(7)
      ..write(obj.orphanBoxes)
      ..writeByte(8)
      ..write(obj.lastVisit)
      ..writeByte(9)
      ..write(obj.reports)
      ..writeByte(10)
      ..write(obj.hives);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
