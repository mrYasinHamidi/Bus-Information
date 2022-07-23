import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_bus_information/generated/l10n.dart';
part 'driver_status.g.dart';

@HiveType(typeId: 5)
enum DriverStatus {
  @HiveField(0)
  active,
  @HiveField(1)
  inActive,
  @HiveField(2)
  vacation,
  @HiveField(3)
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

