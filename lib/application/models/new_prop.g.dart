// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_prop.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewPropAdapter extends TypeAdapter<NewProp> {
  @override
  final int typeId = 3;

  @override
  NewProp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewProp(
      id: fields[0] as String?,
      bus: fields[1] as String,
      driver: fields[2] as String,
      alternativeDriver: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewProp obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bus)
      ..writeByte(2)
      ..write(obj.driver)
      ..writeByte(3)
      ..write(obj.alternativeDriver);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewPropAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
