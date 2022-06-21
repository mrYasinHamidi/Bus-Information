import 'package:flutter/material.dart';

enum DriverStatus {
  active,
  inActive,
  vacation,
  coordination,
}
extension DriverStatusEx on DriverStatus {
  String get text {
    return '';
    // switch (this) {
    //   case DriverStatus.active:
    //     return Languages.language.value.active;
    //   case DriverStatus.inActive:
    //     return Languages.language.value.inActive;
    //   case DriverStatus.vacation:
    //     return Languages.language.value.vacation;
    //   case DriverStatus.coordination:
    //     return Languages.language.value.coordination;
    // }
  }
  Color get color {
    switch (this) {
      case DriverStatus.active:
        return Colors.green;
      case DriverStatus.inActive:
        return Colors.red;
      case DriverStatus.vacation:
        return Colors.grey;
      case DriverStatus.coordination:
        return Colors.lightBlueAccent;
    }
  }
}

extension DriverStatusExe on List<DriverStatus> {
  List<Text> get asTextList => map((e) => Text(e.text)).toList();
}

