import 'package:flutter/material.dart';
import 'package:new_bus_information/generated/l10n.dart';

enum BusStatus { active, deActive, }

extension BusStatusEx on BusStatus {
  String get text {
    switch (this) {
      case BusStatus.active:
        return S.current.active;
      case BusStatus.deActive:
        return S.current.inActive;
    }
  }
  Color get color {
    switch (this) {
      case BusStatus.active:
        return Colors.green;
      case BusStatus.deActive:
        return Colors.red;
    }
  }
}

extension BusStatusExe on List<BusStatus> {
  List<Text> get asTextList => map((e) => Text(e.text)).toList();
}