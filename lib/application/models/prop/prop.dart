import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:objectid/objectid.dart';

part 'prop.g.dart';

@HiveType(typeId: 3)
class Prop extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String bus;
  @HiveField(2)
  final String driver;
  @HiveField(3)
  final String alternativeDriver;

  Prop({
    String? id,
    this.bus = '',
    this.driver = '',
    this.alternativeDriver = '',
  }) : id = id ?? ObjectId().hexString;

  factory Prop.from({
    String? id,
    String? bus,
    String? driver,
    String? alternativeDriver,
  }) {
    return Prop(
      id: id ?? ObjectId().hexString,
      bus: bus ?? '',
      driver: driver ?? '',
      alternativeDriver: alternativeDriver ?? '',
    );
  }

  DateTime getCreationTime() {
    return ObjectId.fromHexString(id).timestamp;
  }

  @override
  List<Object?> get props => [id, bus, driver, alternativeDriver];

  Prop copyWith({
    String? id,
    String? bus,
    String? driver,
    String? alternativeDriver,
  }) {
    return Prop(
      id: id ?? this.id,
      bus: bus ?? this.bus,
      driver: driver ?? this.driver,
      alternativeDriver: alternativeDriver ?? this.alternativeDriver,
    );
  }

  bool isEmpty() {
    return bus.isEmpty && driver.isEmpty && alternativeDriver.isEmpty;
  }
}
