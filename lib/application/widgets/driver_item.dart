import 'package:flutter/material.dart';
import 'package:bus_information/application/models/driver/driver_status.dart';
import 'package:bus_information/application/models/driver/shift_work.dart';
import 'package:bus_information/application/models/driver/driver.dart';
import 'package:bus_information/application/widgets/dot.dart';

class DriverItemWidget extends StatelessWidget {
  final Driver driver;

  const DriverItemWidget(this.driver, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(driver.name),
          Dot(color: driver.status.color),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(driver.shiftWork.text),
          Text(driver.status.text),
        ],
      ),
    );
  }
}
