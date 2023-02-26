// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveEvent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEventAdapter extends TypeAdapter<HiveEvent> {
  @override
  final int typeId = 1;

  @override
  HiveEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEvent(
      importanceLevel: fields[4] as int,
      title: fields[3] as String,
      description: fields[5] as String,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime,
      endDate: fields[6] as DateTime,
      date: fields[0] as DateTime,
      notification: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEvent obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.importanceLevel)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.notification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
