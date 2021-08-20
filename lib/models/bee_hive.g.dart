// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bee_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BeeHiveAdapter extends TypeAdapter<BeeHive> {
  @override
  final int typeId = 3;

  @override
  BeeHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BeeHive(
      name: fields[0] as String,
      situation: (fields[1] as List).cast<String>(),
      production: (fields[2] as List).cast<String>(),
      orphan: fields[3] as bool,
      motherHive: fields[4] as num?,
      dateOrphan: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BeeHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.situation)
      ..writeByte(2)
      ..write(obj.production)
      ..writeByte(3)
      ..write(obj.orphan)
      ..writeByte(4)
      ..write(obj.motherHive)
      ..writeByte(5)
      ..write(obj.dateOrphan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
