import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/widgets/custom_drop_down.dart';
import 'package:new_bus_information/application/widgets/custom_input_field.dart';
import 'package:new_bus_information/generated/l10n.dart';

class AddBusForm extends StatefulWidget {
  final Function(Bus)? onSubmit;
  final Duration splashDelay;

  const AddBusForm({
    Key? key,
    this.onSubmit,
    this.splashDelay = const Duration(milliseconds: 150),
  }) : super(key: key);

  @override
  State<AddBusForm> createState() => _AddDriverFormState();
}

class _AddDriverFormState extends State<AddBusForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Size size;
  bool _show = false;

  late String id;
  late BusStatus status = BusStatus.active;

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
    return Column(
      children: [
        PageTransitionSwitcher(
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
        ),
      ],
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
                maxLength: 10,
                icon: const Icon(Icons.bus_alert),
                label: S.of(context).busNumber,
                validator: _busNumberValidator,
                onChange: _onBusNumberChange,
                inputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDropDown(
                label: S.of(context).busStatus,
                items: BusStatus.values.asTextList,
                onChange: _onStatusChange,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _onSubmit,
              child: Text(S.of(context).submit),
            ),
          ],
        ),
      ),
    );
  }

  String? _busNumberValidator(String? value) {
    if (value == null) return '';
    if (value.isEmpty) return S.of(context).shouldNotEmpty;
    if (context.read<Database>().containBusCode(value.trim())) {
      return S.of(context).repeatedNumber;
    }
    return null;
  }

  void _onBusNumberChange(String value) {
    id = value.trim();
  }

  void _onStatusChange(int value) {
    status = BusStatus.values[value];
  }

  void _onSubmit() {
    if (globalKey.currentState!.validate()) {
      Bus bus = Bus(busCode: id, status: status);
      context.read<Database>().put(bus);
      widget.onSubmit?.call(bus);
    }
  }
}
