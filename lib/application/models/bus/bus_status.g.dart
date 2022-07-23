// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusStatusAdapter extends TypeAdapter<BusStatus> {
  @override
  final int typeId = 4;

  @override
  BusStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BusStatus.active;
      case 1:
        return BusStatus.deActive;
      default:
        return BusStatus.active;
    }
  }

  @override
  void write(BinaryWriter writer, BusStatus obj) {
    switch (obj) {
      case BusStatus.active:
        writer.writeByte(0);
        break;
      case BusStatus.deActive:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
