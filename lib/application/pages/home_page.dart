import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_bus_information/application/bloc/bloc/search_bloc.dart';
import 'package:new_bus_information/application/cubit/filterProp/filter_prop_cubit.dart';
import 'package:new_bus_information/application/cubit/filterTerms/filter_terms_cubit.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/objectList/object_list_cubit.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:new_bus_information/application/pages/create_prop_page.dart';
import 'package:new_bus_information/application/utils.dart';
import 'package:new_bus_information/application/widgets/prop_item.dart';
import 'package:new_bus_information/application/widgets/toggled_enum.dart';
import 'package:new_bus_information/application/widgets/toggled_grid_enum.dart';
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

  @override
  Widget build(BuildContext context) {
    final searchState = context.watch<SearchBloc>().state;
    return BackdropScaffold(
      // backLayerBackgroundColor: ThemeState.of(context).theme.primaryColor,
      // frontLayerBackgroundColor: ThemeState.of(context).scaffoldBackground,
      appBar: _buildAppBar(searchState.isActive),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openPage(context, const CreatePropPage()).then((value) => null);
        },
      ),
      backLayer: _buildBackLayer(),
      frontLayer: _buildFrontLayer(),
    );
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

  PreferredSizeWidget _buildAppBar(bool searchMode) {
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

  Widget _buildFrontLayer() {
    return BlocBuilder<FilterPropCubit, FilterPropState>(
      builder: (context, state) {
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
      },
    );
  }

  Widget _buildBackLayer() {
    return BlocBuilder<FilterTermsCubit, FilterTermsState>(
      builder: (context, state) {
        return ListView(
          children: [
            ExpansionTile(
              title: Text('Bus Filtering'),
              children: [
                const SizedBox(
                  height: 8,
                ),
                _buildTitle('Bus Status'),
                Center(
                  child: ToggledEnum(
                    options: {
                      'Active': false,
                      'Inactive': false,
                    },
                    onTap: (int index) {},
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Driver Filtering'),
              children: [
                SizedBox(
                  height: 8,
                ),
                _buildTitle('Status'),
                Center(
                  child: ToggledEnum(
                    options: {
                      'Active': false,
                      'Inactive': false,
                      'Vacation': false,
                      'Coordinate': false,
                    },
                    onTap: (int index) {},
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                _buildTitle('Shift'),
                Center(
                  child: ToggledEnum(
                    options: {
                      'Morning': false,
                      'Evening': false,
                      'First Ot': false,
                      'Second Ot': false,
                      'Switching': false,
                    },
                    onTap: (int index) {},
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Alternative Driver Filtering'),
              children: [
                const SizedBox(
                  height: 8,
                ),
                _buildTitle('Status'),
                Center(
                  child: ToggledEnum(
                    options: {
                      'Active': false,
                      'Inactive': false,
                      'Vacation': false,
                      'Coordinate': false,
                    },
                    onTap: (int index) {},
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                _buildTitle('Shift Work'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: ToggledGridEnum(
                    options: {
                      'Morning': false,
                      'Evening': true,
                      'First Ot': false,
                      'Second Ot': false,
                      'Switching': false,
                    },
                  ),
                ),
                // const SizedBox(
                // height: 36,
                // ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            _buildTitle('Search on'),
            Center(
              child: ToggledEnum(
                options: state.condidateAsMap,
                onTap: (int index) {
                  context.read<FilterTermsCubit>().changeCondidate(SearchCondidateType.values[index]);
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    _buildTitle('From'),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: const Text('21/02/2022'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    _buildTitle('To'),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: Text('21/02/2022'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        );
      },
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
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

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
