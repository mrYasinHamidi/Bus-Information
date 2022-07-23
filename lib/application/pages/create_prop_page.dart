import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/new_bus.dart';
import 'package:new_bus_information/application/models/new_driver.dart';
import 'package:new_bus_information/application/models/new_prop.dart';
import 'package:new_bus_information/application/pages/driver_chooser.dart';
import 'package:new_bus_information/application/pages/bus_chooser.dart';
import 'package:new_bus_information/application/utils.dart';
import 'package:new_bus_information/application/widgets/bus_preview.dart';
import 'package:new_bus_information/application/widgets/driver_preview.dart';
import 'package:new_bus_information/generated/l10n.dart';

class CreatePropPage extends StatefulWidget {
  final NewProp? prop;
  const CreatePropPage({Key? key, this.prop}) : super(key: key);

  @override
  State<CreatePropPage> createState() => _CreatePropPageState();
}

class _CreatePropPageState extends State<CreatePropPage> {
  NewDriver? _firstDriver;
  NewDriver? _secondDriver;
  NewBus? _bus;

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

  Future<NewDriver?> _chooseDriver() async {
    return await openPage(
      context,
      DriverChooser(
        drivers: NewDatabase.of(context).getDrivers().toList(),
      ),
    );
  }

  Future<NewBus?> _chooseBus() async {
    return await openPage(
      context,
      BusChooser(
        buses: NewDatabase.of(context).getBuses().toList(),
      ),
    );
  }

  void _submit() {
    NewProp prop = NewProp.from(
      id: widget.prop?.id,
      bus: _bus?.id,
      driver: _firstDriver?.id,
      alternativeDriver: _secondDriver?.id,
    );
    NewDatabase.of(context).putProp(prop);
    Navigator.pop(context);
  }
}
