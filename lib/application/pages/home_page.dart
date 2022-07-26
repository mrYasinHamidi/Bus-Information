import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:new_bus_information/application/bloc/search/search_bloc.dart';
import 'package:new_bus_information/application/cubit/filterProp/filter_prop_cubit.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/pages/create_prop_page.dart';
import 'package:new_bus_information/application/pages/filter_page.dart';
import 'package:new_bus_information/application/pages/prop_list_page.dart';
import 'package:new_bus_information/application/utils.dart';
import 'package:new_bus_information/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  Size get size => MediaQuery.of(context).size;

  @override
  void initState() {
    _searchController.addListener(() {
      context.read<SearchBloc>().add(SetSearchTermEvent(newSerchTerm: _searchController.text.trim()));
    });
    super.initState();
  }

  Widget buildFloatinButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        openPage(context, const CreatePropPage());
      },
    );
  }

  PreferredSizeWidget buildAppBar(bool searchMode) {
    if (searchMode) {
      _searchFocusNode.requestFocus();
      return AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<SearchBloc>().add(DeactiveSearchEvent());
            },
            icon: const Icon(Icons.close_rounded),
          ),
        ],
        title: Center(
          child: TextFormField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: S.of(context).searchHint,
            ),
          ),
        ),
      );
    } else {
      return BackdropAppBar(
        actions: [
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
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = context.watch<SearchBloc>().state;
    return BackdropScaffold(
      backLayerBackgroundColor: ThemeState.of(context).theme.colorScheme.surface,
      appBar: buildAppBar(searchState.isActive),
      floatingActionButton: buildFloatinButton(context),
      backLayer: const FilterPage(),
      frontLayer: const PropListPage(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
