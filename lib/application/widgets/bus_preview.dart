import 'package:flutter/material.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/widgets/dot.dart';

class BusPreviewer extends StatelessWidget {
  final Bus? bus;
  final String emptyTitle;
  final VoidCallback? onTap;

  const BusPreviewer({
    Key? key,
    this.bus,
    this.emptyTitle = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.25),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: InkWell(
          splashColor: ThemeState.of(context).onTapSplash,
          splashFactory: InkSplash.splashFactory,
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: bus == null ? _buildEmptyView(context) : _buildPreview(context),
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.person_add_alt_1_rounded,
          size: 60,
          color: ThemeState.of(context).onCard,
        ),
        Text(
          emptyTitle,
          style:  TextStyle(fontSize: 24, color: ThemeState.of(context).onCard),
        ),
      ],
    );
  }

  Widget _buildPreview(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_bus,
              size: 60,
              color: ThemeState.of(context).onCard,
            ),
            Text(
              bus?.busCode ?? '',
              style:  TextStyle(fontSize: 24, color: ThemeState.of(context).onCard),
            ),
          ],
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Dot(color: bus?.status.color),
        ),
      ],
    );
  }

}
