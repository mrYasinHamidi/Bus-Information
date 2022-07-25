import 'package:flutter/material.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/widgets/shake_widget.dart';

import 'dot.dart';

class DriverPreviewer extends StatefulWidget {
  final Driver? driver;
  final String emptyTitle;
  final VoidCallback? onTap;
  final String? Function()? validator;

  const DriverPreviewer({
    Key? key,
    this.driver,
    this.emptyTitle = '',
    this.onTap,
    this.validator,
  }) : super(key: key);

  @override
  State<DriverPreviewer> createState() => DriverPreviewerState();
}

class DriverPreviewerState extends State<DriverPreviewer> {
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  String? errorText;
  bool get isEmpty => widget.driver == null;

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
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: InkWell(
          splashColor: ThemeState.of(context).onTapSplash,
          splashFactory: InkSplash.splashFactory,
          borderRadius: BorderRadius.circular(4),
          onTap: widget.onTap,
          child: isEmpty ? _buildEmptyView(context) : _buildPreview(context),
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.person_add_alt_1_rounded,
          size: 60,
        ),
        Text(
          widget.emptyTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
          ),
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
              Icons.person_rounded,
              size: 60,
            ),
            Text(
              widget.driver?.name ?? '',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Dot(color: widget.driver?.status.color),
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
