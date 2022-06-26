import 'package:flutter/material.dart';
import 'package:new_bus_information/application/models/base_object_extension.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/widgets/dot.dart';

class BusItemWidget extends StatelessWidget {
  final Bus bus;

  const BusItemWidget(this.bus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.directions_bus),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(bus.id),
          Dot(color: bus.status.color),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(bus.status.text),
          Text(bus.creationTime.toString()),
        ],
      ),
    );
  }
}
