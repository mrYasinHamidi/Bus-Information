import 'package:flutter/material.dart';
import 'package:bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:bus_information/application/models/bus/bus_status.dart';
import 'package:bus_information/application/models/bus/bus.dart';
import 'package:bus_information/application/widgets/dot.dart';
import 'package:bus_information/application/widgets/shake_widget.dart';

class BusPreviewer extends StatefulWidget {
  final Bus? bus;
  final String emptyTitle;
  final VoidCallback? onTap;
  final String? Function()? validator;

  const BusPreviewer({
    Key? key,
    this.bus,
    this.emptyTitle = '',
    this.onTap,
    this.validator,
  }) : super(key: key);

  @override
  State<BusPreviewer> createState() => BusPreviewerState();
}

class BusPreviewerState extends State<BusPreviewer> {
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    if (errorText != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          _shakeKey.currentState?.shake();
        },
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.25),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: InkWell(
          splashColor: ThemeState.of(context).onTapSplash,
          splashFactory: InkSplash.splashFactory,
          borderRadius: BorderRadius.circular(4),
          onTap: widget.onTap,
          child: widget.bus == null ? _buildEmptyView(context) : _buildPreview(context),
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
          widget.emptyTitle,
          style: const TextStyle(fontSize: 24),
        ),
        ShakeWidget(
          key: _shakeKey,
          shakeOffset: 2,
          shakeCount: 2,
          shakeDuration: const Duration(milliseconds: 400),
          child: Text(
            errorText ?? '',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
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
              widget.bus?.code ?? '',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Dot(color: widget.bus?.status.color),
        ),
      ],
    );
  }

  bool save() {
    String? err = widget.validator?.call();
    if (err == null) {
      if (errorText != null) {
        setState(() {
          errorText = null;
        });
      }
      return true;
    }
    setState(() {
      errorText = err;
    });
    return false;
  }
}
