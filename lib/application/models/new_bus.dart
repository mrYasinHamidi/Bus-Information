import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:objectid/objectid.dart';
part 'new_bus.g.dart';

@HiveType(typeId: 1)
class NewBus extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String code;
  @HiveField(2)
  final BusStatus status;
  NewBus({
    String? id,
    this.code = '',
    this.status = BusStatus.active,
  }) : id = id ?? ObjectId().hexString;

  @override
  List<Object?> get props => [id];

  NewBus copyWith({
    String? id,
    String? code,
    BusStatus? status,
  }) {
    return NewBus(
      id: id ?? this.id,
      code: code ?? this.code,
      status: status ?? this.status,
    );
  }

  DateTime getCreationTime() {
    return ObjectId.fromHexString(id).timestamp;
  }

  bool isEmpty() {
    return code.isEmpty;
  }
}
