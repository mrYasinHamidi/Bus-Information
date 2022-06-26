import 'package:flutter/material.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/pages/item_chooser.dart';
import 'package:new_bus_information/application/utils.dart';
import 'package:new_bus_information/application/widgets/bus_preview.dart';
import 'package:new_bus_information/application/widgets/driver_preview.dart';
import 'package:new_bus_information/generated/l10n.dart';

class CreatePropPage extends StatefulWidget {
  const CreatePropPage({Key? key}) : super(key: key);

  @override
  State<CreatePropPage> createState() => _CreatePropPageState();

}

class _CreatePropPageState extends State<CreatePropPage> {
  Driver? _firstDriver;
  Driver? _secondDriver;
  Bus? _bus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).createProp),
        actions: [
          IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DriverPreviewer(
                    driver: _firstDriver,
                    emptyTitle: S.of(context).driver,
                    onTap: _selectFirstDriver,
                  ),
                ),
                Expanded(
                  child: DriverPreviewer(
                    driver: _secondDriver,
                    emptyTitle: S.of(context).alternativeDriver,
                    onTap: _selectSecondDriver,
                  ),
                ),
              ],
            ),
            BusPreviewer(
              onTap: _selectBus,
              emptyTitle: S.of(context).busInformation,
              bus: _bus,
            ),
          ],
        ),
      ),
    );
  }

  void _selectBus() async {
    _bus = await _chooseBus();
    setState(() {});
  }

  void _selectFirstDriver() async {
    _firstDriver = await _chooseDriver();
    setState(() {});
  }

  void _selectSecondDriver() async {
    _secondDriver = await _chooseDriver();
    setState(() {});
  }

  Future<Driver?> _chooseDriver() async {
    openPage(context, const ItemChooser(items: []));
    // return await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => ItemChooser(
    //       items: DatabaseHelper.instance.drivers,
    //       type: ObjectType.driver,
    //     ),
    //   ),
    // );
  }

  Future<Bus?> _chooseBus() async {
    openPage(context, const ItemChooser(items: []));

  }

  void _submit() {
    // Prop prop = Prop(
    //   id: _bus?.id,
    //   driverId: _firstDriver?.id,
    //   secondDriverId: _secondDriver?.id,
    // );
    // DatabaseHelper.instance.put(prop);
    // Navigator.pop(context,true);
  }
}
