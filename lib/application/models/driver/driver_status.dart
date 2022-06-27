import 'package:flutter/material.dart';
import 'package:new_bus_information/generated/l10n.dart';

enum DriverStatus {
  active,
  inActive,
  vacation,
  coordination,
}
extension DriverStatusEx on DriverStatus {
  String get text {
    switch (this) {
      case DriverStatus.active:
        return S.current.active;
      case DriverStatus.inActive:
        return S.current.inActive;
      case DriverStatus.vacation:
        return S.current.vacation;
      case DriverStatus.coordination:
        return S.current.coordination;
    }
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

