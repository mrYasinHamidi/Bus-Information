import 'package:flutter/material.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:new_bus_information/application/pages/driver_chooser.dart';
import 'package:new_bus_information/application/pages/bus_chooser.dart';
import 'package:new_bus_information/application/utils.dart';
import 'package:new_bus_information/application/widgets/bus_preview.dart';
import 'package:new_bus_information/application/widgets/driver_preview.dart';
import 'package:new_bus_information/generated/l10n.dart';

class CreatePropPage extends StatefulWidget {
  final Prop? prop;
  const CreatePropPage({Key? key, this.prop}) : super(key: key);

  @override
  State<CreatePropPage> createState() => _CreatePropPageState();
}

class _CreatePropPageState extends State<CreatePropPage> {
  Driver? _firstDriver;
  Driver? _secondDriver;
  Bus? _bus;

  bool get _editMode => widget.prop != null;

  @override
  void initState() {
    ///Initialize data with old data for editing prop
    if (_editMode) {
      _firstDriver = NewDatabase.of(context).getDriver(widget.prop!.driver);
      _secondDriver = NewDatabase.of(context).getDriver(widget.prop!.alternativeDriver);
      _bus = NewDatabase.of(context).getBus(widget.prop!.bus);
    }
    super.initState();
  }

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
              emptyTitle: S.of(context).bus,
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
    return await openPage(
      context,
      DriverChooser(
        drivers: NewDatabase.of(context).getDrivers().toList().reSort(),
      ),
    );
  }

  Future<Bus?> _chooseBus() async {
    return await openPage(
      context,
      BusChooser(
        buses: NewDatabase.of(context).getBuses().toList().reSort(),
      ),
    );
  }

  void _submit() {
    Prop prop = Prop.from(
      id: widget.prop?.id,
      bus: _bus?.id,
      driver: _firstDriver?.id,
      alternativeDriver: _secondDriver?.id,
    );
    NewDatabase.of(context).putProp(prop);
    Navigator.pop(context);
  }
}
