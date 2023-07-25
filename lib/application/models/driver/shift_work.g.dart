// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_work.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftWorkAdapter extends TypeAdapter<ShiftWork> {
  @override
  final int typeId = 6;

  @override
  ShiftWork read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ShiftWork.morning;
      case 1:
        return ShiftWork.evening;
      case 2:
        return ShiftWork.firstOverTime;
      case 3:
        return ShiftWork.secondOverTime;
      case 4:
        return ShiftWork.shiftSwitching;
      default:
        return ShiftWork.morning;
    }
  }

  @override
  void write(BinaryWriter writer, ShiftWork obj) {
    switch (obj) {
      case ShiftWork.morning:
        writer.writeByte(0);
        break;
      case ShiftWork.evening:
        writer.writeByte(1);
        break;
      case ShiftWork.firstOverTime:
        writer.writeByte(2);
        break;
      case ShiftWork.secondOverTime:
        writer.writeByte(3);
        break;
      case ShiftWork.shiftSwitching:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftWorkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
