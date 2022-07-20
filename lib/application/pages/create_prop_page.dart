import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/base/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:new_bus_information/application/pages/item_chooser.dart';
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
      _firstDriver = context.read<Database>().getObject(widget.prop!.driverId, BaseObjectType.driver) as Driver?;
      if(widget.prop!.secondDriverId.isNotEmpty) {
        _secondDriver = context.read<Database>().getObject(widget.prop!.secondDriverId, BaseObjectType.driver) as Driver?;
      }
      _bus = context.read<Database>().getObject(widget.prop!.busId, BaseObjectType.bus) as Bus?;
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
      ItemChooser(
        items: context.read<Database>().getObjects(BaseObjectType.driver),
        type: BaseObjectType.driver,
      ),
    );
  }

  Future<Bus?> _chooseBus() async {
    return await openPage(
      context,
      ItemChooser(
        items: context.read<Database>().getObjects(BaseObjectType.bus),
        type: BaseObjectType.bus,
      ),
    );
  }

  void _submit() {
    final Database database = context.read<Database>();
    Prop prop = Prop(
      id: widget.prop?.id,
      busId: _bus?.key ?? '',
      driverId: _firstDriver?.key ?? '',
      secondDriverId: _secondDriver?.key ?? '',
    );
    database.put(prop);
    Navigator.pop(context);
  }
}
