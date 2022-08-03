import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:bus_information/generated/l10n.dart';
part 'shift_work.g.dart';

@HiveType(typeId: 6)
enum ShiftWork {
  @HiveField(0)
  morning,
  @HiveField(1)
  evening,
  @HiveField(2)
  firstOverTime,
  @HiveField(3)
  secondOverTime,
  @HiveField(4)
  shiftSwitching,
}

extension ShiftWorkEx on ShiftWork {
  String get text {
    switch (this) {
      case ShiftWork.morning:
        return S.current.morningShift;
      case ShiftWork.evening:
        return S.current.eveningShift;
      case ShiftWork.firstOverTime:
        return S.current.firstOverTime;
      case ShiftWork.secondOverTime:
        return S.current.secondOverTime;
      case ShiftWork.shiftSwitching:
        return S.current.shiftSwitching;
    }
  }
}

extension ShiftWorkExe on List<ShiftWork> {
  List<Text> get asTextList => map((e) => Text(e.text)).toList();
}
