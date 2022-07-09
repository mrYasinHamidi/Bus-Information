import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:new_bus_information/application/widgets/dot.dart';
import 'package:new_bus_information/generated/l10n.dart';

class PropItemWidget extends StatelessWidget {
  final Prop prop;

  const PropItemWidget(this.prop, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Driver? _driver = context.read<Database>().getObject(prop.driverId ?? '', BaseObjectType.driver) as Driver?;
    Driver? _secondDriver =
        context.read<Database>().getObject(prop.secondDriverId ?? '', BaseObjectType.driver) as Driver?;
    Bus? _bus = context.read<Database>().getObject(prop.busId ?? '', BaseObjectType.bus) as Bus?;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProperty(S.of(context).busNumber, _bus?.busCode ?? ''),
              Dot(color: _bus?.status.color),
            ],
          ),
          const SizedBox(height: 4),
          _buildProperty(S.of(context).busStatus, _bus?.status.text ?? ''),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 18,
                      child: Icon(Icons.person),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    horizontalTitleGap: 8,
                    minVerticalPadding: 4,
                    title: Text(_driver?.name ?? ''),
                    subtitle: Text(S.of(context).driver),
                    dense: true,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 18,
                    ),
                    title: Text(_secondDriver?.name ?? ''),
                    subtitle: Text(S.of(context).alternativeDriver),
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    horizontalTitleGap: 8,
                    minVerticalPadding: 4,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Row _buildProperty(String name, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(name),
        const Text(' : '),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
