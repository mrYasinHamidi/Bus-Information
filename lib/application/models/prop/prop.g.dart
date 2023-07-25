// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prop.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropAdapter extends TypeAdapter<Prop> {
  @override
  final int typeId = 3;

  @override
  Prop read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prop(
      id: fields[0] as String?,
      bus: fields[1] as String,
      driver: fields[2] as String,
      alternativeDriver: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Prop obj) {
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
      other is PropAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
