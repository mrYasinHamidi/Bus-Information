import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';
import 'package:objectid/objectid.dart';

part 'driver.g.dart';
part 'driver_list_extension.dart';
@HiveType(typeId: 2)
class Driver extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DriverStatus status;
  @HiveField(3)
  final ShiftWork shiftWork;
  Driver({
    String? id,
    this.name = '',
    this.shiftWork = ShiftWork.morning,
    this.status = DriverStatus.active,
  }) : id = id ?? ObjectId().hexString;

  @override
  List<Object?> get props => [id];

  Driver copyWith({
    String? id,
    String? name,
    DriverStatus? status,
    ShiftWork? shiftWork,
  }) {
    return Driver(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      shiftWork: shiftWork ?? this.shiftWork,
    );
  }

  DateTime getCreationTime() {
    return ObjectId.fromHexString(id).timestamp;
  }

  bool isEmpty() {
    return name.isEmpty;
  }

  bool isNotEmpty() {
    return name.isNotEmpty;
  }
}
