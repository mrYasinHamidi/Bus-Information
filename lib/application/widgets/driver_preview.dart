import 'package:flutter/material.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';

import 'dot.dart';

class DriverPreviewer extends StatelessWidget {
  final Driver? driver;
  final String emptyTitle;
  final VoidCallback? onTap;

  const DriverPreviewer({
    Key? key,
    this.driver,
    this.emptyTitle = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: InkWell(
          splashColor: ThemeState.of(context).onTapSplash,
          splashFactory: InkSplash.splashFactory,
          borderRadius: BorderRadius.circular(4),
          onTap: onTap,
          child: driver == null ? _buildEmptyView(context) : _buildPreview(context),
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
          color: ThemeState.of(context).onCard,
          size: 60,
        ),
        Text(
          emptyTitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: ThemeState.of(context).onCard),
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
              Icons.person_rounded,
              size: 60,
              color: ThemeState.of(context).onCard,
            ),
            Text(
              driver?.name ?? '',
              style: TextStyle(fontSize: 24, color: ThemeState.of(context).onCard),
            ),
          ],
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Dot(color: driver?.status.color),
        ),
      ],
    );
  }
}
