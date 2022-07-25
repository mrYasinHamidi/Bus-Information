import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/widgets/form/add_bus_form.dart';
import 'package:new_bus_information/application/widgets/form/add_driver_form.dart';

class CreatorDialog extends StatefulWidget {
  final Function(Driver)? onAddDriver;
  final Function(Bus)? onAddBus;
  final bool isDriverChooser;

  const CreatorDialog({
    Key? key,
    this.onAddBus,
    this.onAddDriver,
    this.isDriverChooser = true,
  }) : super(key: key);

  @override
  State<CreatorDialog> createState() => _CreatorDialogState();
}

class _CreatorDialogState extends State<CreatorDialog> {
  final Duration _duration = const Duration(milliseconds: 400);

  final Curve _curve = Curves.easeInOutCubicEmphasized;

  Size get size => MediaQuery.of(context).size;

  bool _isOpen = false;

  bool get _isVertical => MediaQuery.of(context).orientation == Orientation.portrait;

  double get _width => _isOpen ? size.width * (_isVertical ? 0.9 : 0.8) : 50;

  double get _height => _isOpen ? size.height * (_isVertical ? 0.5 : 0.75) : 50;

  Color get _color => context.read<ThemeCubit>().state.createDialog;

  Color get _backgroundColor => _isOpen ? Colors.black38 : Colors.transparent;

  BorderRadius get _radius => BorderRadius.circular(16);

  BoxDecoration get _decoration => BoxDecoration(color: _color, borderRadius: _radius, boxShadow: const [
        BoxShadow(spreadRadius: .2, blurRadius: 2, color: Colors.black38),
      ]);

  Widget? get _child {
    if (_isOpen) {
      if (widget.isDriverChooser) {
        return AddDriverForm(
          onSubmit: _onDriverSubmit,
          splashDelay: _duration,
        );
      } else {
        return AddBusForm(
          onSubmit: _onBusSubmit,
          splashDelay: _duration,
        );
      }
    }
    return const Icon(
      Icons.add,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isOpen) {
          _close();
          return false;
        }
        return true;
      },
      child: Stack(
        children: [
          IgnorePointer(
            ignoring: !_isOpen,
            child: GestureDetector(
                onTap: _close,
                child: Container(
                  width: size.width,
                  height: size.height,
                  color: _backgroundColor,
                  // duration: _duration,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: _isOpen ? null : _onTap,
                borderRadius: _radius,
                child: AnimatedContainer(
                  width: _width,
                  height: _height,
                  decoration: _decoration,
                  curve: _curve,
                  duration: _duration,
                  child: _child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap() {
    if (!_isOpen) {
      _open();
    }
  }

  void _open() {
    setState(() {
      _isOpen = true;
    });
  }

  void _close() {
    setState(() {
      _isOpen = false;
    });
  }

  _onBusSubmit(Bus bus) {
    _close();
    widget.onAddBus?.call(bus);
  }

  _onDriverSubmit(Driver driver) {
    _close();
    widget.onAddDriver?.call(driver);
  }
}
