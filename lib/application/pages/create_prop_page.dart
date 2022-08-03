import 'package:flutter/material.dart';
import 'package:bus_information/application/database/database.dart';
import 'package:bus_information/application/models/bus/bus.dart';
import 'package:bus_information/application/models/driver/driver.dart';
import 'package:bus_information/application/models/prop/prop.dart';
import 'package:bus_information/application/pages/driver_chooser.dart';
import 'package:bus_information/application/pages/bus_chooser.dart';
import 'package:bus_information/application/utils.dart';
import 'package:bus_information/application/widgets/bus_preview.dart';
import 'package:bus_information/application/widgets/driver_preview.dart';
import 'package:bus_information/generated/l10n.dart';

class CreatePropPage extends StatefulWidget {
  final Prop? prop;
  const CreatePropPage({Key? key, this.prop}) : super(key: key);

  @override
  State<CreatePropPage> createState() => _CreatePropPageState();
}

class _CreatePropPageState extends State<CreatePropPage> {
  final GlobalKey<BusPreviewerState> _busPreviewKey = GlobalKey<BusPreviewerState>();
  final GlobalKey<DriverPreviewerState> _driverPreviewKey = GlobalKey<DriverPreviewerState>();
  Driver? _firstDriver;
  Driver? _secondDriver;
  Bus? _bus;

  bool get _editMode => widget.prop != null;

  @override
  void initState() {
    ///Initialize data with old data for editing prop
    if (_editMode) {
      _firstDriver = Database.of(context).getDriver(widget.prop!.driver);
      _secondDriver = Database.of(context).getDriver(widget.prop!.alternativeDriver);
      _bus = Database.of(context).getBus(widget.prop!.bus);
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
                      key: _driverPreviewKey,
                      driver: _firstDriver,
                      emptyTitle: S.of(context).driver,
                      onTap: _selectFirstDriver,
                      validator: () {
                        if (_firstDriver != null) return null;
                        return S.of(context).shouldNotEmpty;
                      }),
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
              key: _busPreviewKey,
              onTap: _selectBus,
              emptyTitle: S.of(context).bus,
              bus: _bus,
              validator: () {
                if (_bus == null) {
                  return S.of(context).shouldNotEmpty;
                }
                return null;
              },
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
        drivers: Database.of(context).getDrivers().toList()..reSort(),
      ),
    );
  }

  Future<Bus?> _chooseBus() async {
    return await openPage(
      context,
      BusChooser(
        buses: Database.of(context).getBuses().toList()..reSort(),
      ),
    );
  }

  void _submit() {
    bool a = _busPreviewKey.currentState?.save() ?? true;
    bool b = _driverPreviewKey.currentState?.save() ?? true;
    if (!a || !b) {
      return;
    }
    Prop prop = Prop.from(
      id: widget.prop?.id,
      bus: _bus?.id,
      driver: _firstDriver?.id,
      alternativeDriver: _secondDriver?.id,
    );
    Database.of(context).putProp(prop);
    Navigator.pop(context);
  }
}
