// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_bus.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewBusAdapter extends TypeAdapter<NewBus> {
  @override
  final int typeId = 1;

  @override
  NewBus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewBus(
      id: fields[0] as String?,
      code: fields[1] as String,
      status: fields[2] as BusStatus,
    );
  }

  @override
  void write(BinaryWriter writer, NewBus obj) {
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
      other is NewBusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
