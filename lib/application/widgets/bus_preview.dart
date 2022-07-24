import 'package:flutter/material.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
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
          borderRadius: BorderRadius.circular(4),
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
        const Icon(
          Icons.directions_bus,
          size: 60,
        ),
        Text(
          emptyTitle,
          style: const TextStyle(fontSize: 24),
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
            const Icon(
              Icons.directions_bus,
              size: 60,
            ),
            Text(
              bus?.code ?? '',
              style: const TextStyle(
                fontSize: 24,
              ),
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
