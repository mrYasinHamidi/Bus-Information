import 'package:flutter/material.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';

class ToggledGridEnum extends StatelessWidget {
  const ToggledGridEnum({Key? key, this.column = 3, required this.options}) : super(key: key);

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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: delegate,
      itemBuilder: (BuildContext context, int index) {
        final isSelect = options.values.elementAt(index);
        final String text = options.keys.elementAt(index);

        return _MyToggledButton(
          isSelect: isSelect,
          text: text,
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
  }) : super(key: key);

  ///Text of Button
  final String text;

  ///select status of button
  final bool isSelect;

  ///create box decoration of button container
  BoxDecoration _boxDecoration(
    bool isSelect,
    ThemeData themeData,
    ToggleButtonsThemeData toggleButtonsThemeData,
  ) {
    return BoxDecoration(
      color: isSelect ? themeData.colorScheme.primary.withOpacity(0.12) : null,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: toggleButtonsThemeData.borderColor ?? themeData.colorScheme.onSurface.withOpacity(0.12),
      ),
    );
  }

  ///create [TextStyle] of button text
  TextStyle _textStyle(bool isSelect, ThemeData themeData) {
    return TextStyle(color: isSelect ? themeData.colorScheme.primary : null);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeState.of(context).theme;
    final ToggleButtonsThemeData toggleTheme = ToggleButtonsTheme.of(context);

    final TextStyle textStyle = _textStyle(
      isSelect,
      theme,
    );
    final BoxDecoration decoration = _boxDecoration(
      isSelect,
      theme,
      toggleTheme,
    );

    return Container(
      decoration: decoration,
      child: Center(
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
