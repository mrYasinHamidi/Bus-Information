// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_driver.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewDriverAdapter extends TypeAdapter<NewDriver> {
  @override
  final int typeId = 2;

  @override
  NewDriver read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewDriver(
      id: fields[0] as String?,
      name: fields[1] as String,
      shiftWork: fields[3] as ShiftWork,
      status: fields[2] as DriverStatus,
    );
  }

  @override
  void write(BinaryWriter writer, NewDriver obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.shiftWork);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewDriverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
