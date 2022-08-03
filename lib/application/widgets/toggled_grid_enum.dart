import 'package:flutter/material.dart';
import 'package:bus_information/application/constants/numerics.dart';
import 'package:bus_information/application/cubit/theme/theme_cubit.dart';

class ToggledGridEnum extends StatelessWidget {
  const ToggledGridEnum({
    Key? key,
    this.column = 3,
    required this.options,
    this.onTap,
  }) : super(key: key);

  ///count of columns
  ///if column set to 4
  ///response will be a grid of [_MyToggledButton] with 4 column
  final int column;

  /*
  map of [text] and [selecting] status
  Ex:
    {
      'button 1 txt' : false,
      'button 2 txt' : true,
      'button 3 txt : false,
    }
  */
  final Map<String, bool> options;

  ///onTap callback provide a callback whenever one of buttons clicked
  ///we pass a int to this callback to determine which button at what index was clicked
  final Function(int)? onTap;

  ///create a [SliverGridDelegate] for shoving items in a Grid form
  SliverGridDelegate _delegate(int crossAxisCount, double spaceBetween, double height) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spaceBetween,
      mainAxisSpacing: spaceBetween,
      mainAxisExtent: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    final SliverGridDelegate delegate = _delegate(column, 16, 40);

    return GridView.builder(
      itemCount: options.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: delegate,
      itemBuilder: (BuildContext context, int index) {
        final isSelect = options.values.elementAt(index);
        final String text = options.keys.elementAt(index);

        return _MyToggledButton(
          isSelect: isSelect,
          text: text,
          onTap: () {
            onTap?.call(index);
          },
        );
      },
    );
  }
}

class _MyToggledButton extends StatelessWidget {
  const _MyToggledButton({
    Key? key,
    required this.isSelect,
    required this.text,
    this.onTap,
  }) : super(key: key);

  ///Text of Button
  final String text;

  ///select status of button
  final bool isSelect;

  ///on tap callback
  final VoidCallback? onTap;

  ///border radius for all subwidgets
  BorderRadius _borderRadius() {
    return BorderRadius.circular(NumericConstants.buttonRadius);
  }

  ///create box decoration of button container
  BoxDecoration _boxDecoration(
    bool isSelect,
    ThemeData themeData,
    ToggleButtonsThemeData toggleButtonsThemeData,
    BorderRadius borderRadius,
  ) {
    return BoxDecoration(
      color: isSelect ? themeData.colorScheme.primary.withOpacity(0.12) : null,
      borderRadius: borderRadius,
      border: Border.all(
        color: toggleButtonsThemeData.borderColor ?? themeData.colorScheme.onSurface.withOpacity(0.12),
      ),
    );
  }

  ///create [TextStyle] of button text
  TextStyle _textStyle(bool isSelect, ThemeData themeData) {
    return TextStyle(
      color: isSelect ? themeData.colorScheme.primary : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeState.of(context).theme;
    final ToggleButtonsThemeData toggleTheme = ToggleButtonsTheme.of(context);

    final TextStyle textStyle = _textStyle(
      isSelect,
      theme,
    );
    final borderRadius = _borderRadius();
    final BoxDecoration decoration = _boxDecoration(
      isSelect,
      theme,
      toggleTheme,
      borderRadius,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        decoration: decoration,
        child: Center(
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
