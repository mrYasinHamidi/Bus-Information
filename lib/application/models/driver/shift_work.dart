
import 'package:flutter/material.dart';

enum ShiftWork {
  morning,
  evening,
  firstOverTime,
  secondOverTime,
  shiftSwitching,
}

extension ShiftWorkEx on ShiftWork {
  String get text {
    return '';
    // switch (this) {
    //   case ShiftWork.morning:
    //     return Languages.language.value.morningShift;
    //   case ShiftWork.evening:
    //     return Languages.language.value.eveningShift;
    //   case ShiftWork.firstOverTime:
    //     return Languages.language.value.firstOverTime;
    //   case ShiftWork.secondOverTime:
    //     return Languages.language.value.secondOverTime;
    //   case ShiftWork.shiftSwitching:
    //     return Languages.language.value.shiftSwitching;
    // }
  }
}

extension ShiftWorkExe on List<ShiftWork> {
  List<Text> get asTextList => map((e) => Text(e.text)).toList();
}
