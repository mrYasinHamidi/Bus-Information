import 'package:flutter/material.dart';
import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/widgets/form/add_bus_form.dart';
import 'package:new_bus_information/application/widgets/form/add_driver_form.dart';

class CreatorDialog extends StatefulWidget {
  final Function(BaseObject)? onAddItem;
  final BaseObjectType type;

  const CreatorDialog({
    Key? key,
    this.onAddItem,
    this.type = BaseObjectType.driver,
  }) : super(key: key);

  @override
  State<CreatorDialog> createState() => _CreatorDialogState();
}

class _CreatorDialogState extends State<CreatorDialog> {
  final Duration _duration = const Duration(milliseconds: 400);

  final Curve _curve = Curves.easeInOutCubicEmphasized;

  Size get size => MediaQuery.of(context).size;

  bool _isOpen = false;

  double get _width => _isOpen ? size.width * 0.9 : 50;

  double get _height => _isOpen ? size.height * .5 : 50;

  Color get _color => _isOpen ? Colors.yellow : Colors.green;

  BorderRadius get _radius => BorderRadius.circular(16);

  BoxDecoration get _decoration => BoxDecoration(color: _color, borderRadius: _radius);

  Widget? get _child {
    if (_isOpen) {
      switch(widget.type){
        case BaseObjectType.bus:
          return AddBusForm(
            onSubmit: _onSubmit,
            splashDelay: _duration,
          );
        case BaseObjectType.driver:
          return AddDriverForm(
            onSubmit: _onSubmit,
            splashDelay: _duration,
          );
        default:
          return AddDriverForm(
            onSubmit: _onSubmit,
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
      child: InkWell(
        onTap: _onTap,
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

  _onSubmit(BaseObject object) {
    _close();
    widget.onAddItem?.call(object);
  }
}
