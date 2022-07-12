import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_bus_information/application/bloc/bloc/search_bloc.dart';
import 'package:new_bus_information/application/cubit/filterProp/filter_prop_cubit.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/objectList/object_list_cubit.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:new_bus_information/application/pages/create_prop_page.dart';
import 'package:new_bus_information/application/utils.dart';
import 'package:new_bus_information/application/widgets/prop_item.dart';
import 'package:new_bus_information/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      context.read<SearchBloc>().add(SetSearchTermEvent(newSerchTerm: _searchController.text.trim()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = context.watch<SearchBloc>().state;
    return BackdropScaffold(
      backLayerBackgroundColor: ThemeState.of(context).theme.primaryColor,
      frontLayerBackgroundColor: ThemeState.of(context).scaffoldBackground,
      appBar: _buildAppBar(searchState.isActive),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openPage(context, const CreatePropPage()).then((value) => null);
        },
      ),
      backLayer: Container(height: 100),
      frontLayer: Builder(builder: (context) {
        final state = context.watch<FilterPropCubit>().state;
        return ListView.builder(
          itemCount: state.filteredList.length,
          itemBuilder: (c, i) {
            return Slidable(
              key: ValueKey(state.filteredList[i].key),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  confirmDismiss: _showDeleteDialog,
                  onDismissed: () {
                    _delete(state.filteredList[i]);
                  },
                  closeOnCancel: true,
                ),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      if (await _showDeleteDialog()) {
                        _delete(state.filteredList[i]);
                      }
                    },
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.delete_rounded,
                    label: S.of(context).delete,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      _edit(state.filteredList[i]);
                    },
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit_rounded,
                    label: S.of(context).edite,
                  ),
                ],
              ),
              child: PropItemWidget(state.filteredList[i]),
            );
          },
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(bool searchMode) {
    if (searchMode) {
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

  Future<bool> _showDeleteDialog() async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: ThemeState.of(context).createDialog,
              title: Text('Did you realy wanna delete this?'),
              content: Text('If ypu delete this item , you can\'t return this.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(elevation: 0),
                  child: Text('No'),
                ),
                SizedBox(
                  width: 8,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Yes do it'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _edit(Prop object) {
    openPage(
      context,
      CreatePropPage(
        prop: object,
      ),
    );
  }

  void _delete(BaseObject object) {
    context.read<Database>().delete(object);
  }
}
