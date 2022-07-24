import 'package:flutter/material.dart';

class ToggledEnum extends StatelessWidget {
  final Map<String, bool> options;
  final Function(int index)? onTap;
  const ToggledEnum({
    Key? key,
    required this.options,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ToggleButtons(
      borderRadius: BorderRadius.circular(4.0),
      constraints: BoxConstraints(minWidth: size.width * (1 / (options.length + .5)), minHeight: 36),
      isSelected: options.values.toList(),
      onPressed: onTap,
      children: options.keys.map((e) => Text(e)).toList(),
    );
  }
}
