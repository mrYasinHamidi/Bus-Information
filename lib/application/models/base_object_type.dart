import 'package:new_bus_information/generated/l10n.dart';

enum BaseObjectType { driver, bus, prop }

extension BaseObjectTypeExtension on BaseObjectType {
  String get text {
    switch (this) {
      case BaseObjectType.driver:
        return S.current.drivers;
      case BaseObjectType.bus:
        return S.current.buses;
      case BaseObjectType.prop:
        return S.current.props;
    }
  }
}
