// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DriverStatusAdapter extends TypeAdapter<DriverStatus> {
  @override
  final int typeId = 5;

  @override
  DriverStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DriverStatus.active;
      case 1:
        return DriverStatus.inActive;
      case 2:
        return DriverStatus.vacation;
      case 3:
        return DriverStatus.coordination;
      default:
        return DriverStatus.active;
    }
  }

  @override
  void write(BinaryWriter writer, DriverStatus obj) {
    switch (obj) {
      case DriverStatus.active:
        writer.writeByte(0);
        break;
      case DriverStatus.inActive:
        writer.writeByte(1);
        break;
      case DriverStatus.vacation:
        writer.writeByte(2);
        break;
      case DriverStatus.coordination:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
