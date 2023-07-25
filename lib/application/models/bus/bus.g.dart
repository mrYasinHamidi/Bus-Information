// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusAdapter extends TypeAdapter<Bus> {
  @override
  final int typeId = 1;

  @override
  Bus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bus(
      id: fields[0] as String?,
      code: fields[1] as String,
      status: fields[2] as BusStatus,
    );
  }

  @override
  void write(BinaryWriter writer, Bus obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
