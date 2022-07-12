import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/bloc/bloc/search_bloc.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/generated/l10n.dart';

class HomeAppbar extends BackdropAppBar {
  final BuildContext context;
  HomeAppbar({Key? key, required this.context,List<Widget>? actions,searchCloase}) : super(key: key,actions: actions);


  @override
  List<Widget>? get actions => [
        IconButton(
          onPressed: context.read<ThemeCubit>().toggleTheme,
          icon: Icon(context.watch<ThemeCubit>().state is DarkThemeState ? Icons.light_mode : Icons.dark_mode),
        ),
        IconButton(
          onPressed: context.read<LanguageCubit>().toggleLanguage,
          icon: const Icon(Icons.language),
        ),
        IconButton(
          onPressed: () {
            context.read<SearchBloc>().add(ActiveSearchEvent());
          },
          icon: const Icon(Icons.search_rounded),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final SearchState state = context.watch<SearchBloc>().state;
    if (state.isActive) {
      return Container(
        height: preferredSize.height,
        color: ThemeState.of(context).theme.appBarTheme.backgroundColor,
        child: Center(
          child: TextFormField(
            controller: TextEditingController()..addListener(_searchTextChange),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: S.of(context).searchHint,
              suffixIcon: InkWell(
                child: const Icon(Icons.close),
                onTap: () {
                  context.read<SearchBloc>().add(DeactiveSearchEvent());
                },
              ),
            ),
          ),
        ),
      );
    } else {
      return super.build(context);
    }
  }

  void _searchTextChange() {
  }
}
