
import 'package:flutter/material.dart';
import 'package:new_bus_information/generated/l10n.dart';
import 'package:new_bus_information/generated/l10n.dart';
import 'package:new_bus_information/generated/l10n.dart';
import 'package:new_bus_information/generated/l10n.dart';
import 'package:new_bus_information/generated/l10n.dart';

enum ShiftWork {
  morning,
  evening,
  firstOverTime,
  secondOverTime,
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
