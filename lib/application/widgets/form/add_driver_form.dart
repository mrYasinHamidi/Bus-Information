import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';
import 'package:new_bus_information/application/models/new_driver.dart';
import 'package:new_bus_information/application/models/new_prop.dart';
import 'package:new_bus_information/application/widgets/custom_drop_down.dart';
import 'package:new_bus_information/application/widgets/custom_input_field.dart';
import 'package:new_bus_information/generated/l10n.dart';

class AddDriverForm extends StatefulWidget {
  final Function(NewDriver)? onSubmit;
  final Duration splashDelay;

  const AddDriverForm({
    Key? key,
    this.onSubmit,
    this.splashDelay = const Duration(milliseconds: 150),
  }) : super(key: key);

  @override
  State<AddDriverForm> createState() => _AddDriverFormState();
}

class _AddDriverFormState extends State<AddDriverForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Size size;

  late String name;
  DriverStatus status = DriverStatus.active;
  ShiftWork shiftWork = ShiftWork.morning;
  bool _show = false;

  @override
  void initState() {
    Future.delayed(widget.splashDelay, () {
      setState(() {
        _show = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 300),
      reverse: !_show,
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          fillColor: Colors.transparent,
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
        );
      },
      child: _show ? _form : const SizedBox(),
    );
  }

  Form get _form {
    return Form(
      key: globalKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CustomInputField(
                label: S.of(context).name,
                validator: _personNameValidator,
                onChange: _onPersonNameChange,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropDown(
                items: ShiftWork.values.asTextList,
                onChange: _onShiftWorkChange,
                label: S.of(context).shiftWork,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropDown(
                items: DriverStatus.values.asTextList,
                label: S.of(context).driverStatus,
                onChange: _onStatusChange,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton(
              onPressed: _onSubmit,
              child: Text(
                S.of(context).submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _personNameValidator(String? value) {
    if (value == null) return '';
    if (value.isEmpty) return S.of(context).shouldNotEmpty;
    if (context.read<Database>().containName(value)) return S.of(context).repeatedName;
    return null;
  }

  void _onSubmit() {
    if (globalKey.currentState!.validate()) {
      NewDriver driver = NewDriver(name: name, status: status, shiftWork: shiftWork);
      NewDatabase.of(context).putDriver(driver);
      widget.onSubmit?.call(driver);
    }
  }

  void _onPersonNameChange(String value) {
    name = value.trim();
  }

  void _onShiftWorkChange(int value) {
    shiftWork = ShiftWork.values[value];
  }

  void _onStatusChange(int value) {
    status = DriverStatus.values[value];
  }
}
