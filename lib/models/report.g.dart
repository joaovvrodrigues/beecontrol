// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportAdapter extends TypeAdapter<Report> {
  @override
  final int typeId = 2;

  @override
  Report read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Report(
      name: fields[0] as String,
      date: fields[1] as DateTime?,
      numHives: fields[2] as num,
      orphanBoxes: fields[3] as num,
      resume: (fields[4] as List).cast<String>(),
      comments: fields[5] as String,
      beePasture: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Report obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.numHives)
      ..writeByte(3)
      ..write(obj.orphanBoxes)
      ..writeByte(4)
      ..write(obj.resume)
      ..writeByte(5)
      ..write(obj.comments)
      ..writeByte(6)
      ..write(obj.beePasture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
