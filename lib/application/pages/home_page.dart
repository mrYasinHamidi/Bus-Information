import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
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
  List<BaseObject> get _props => context.read<Database>().getObjects(BaseObjectType.prop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        actions: [
          IconButton(
            onPressed: context.read<ThemeCubit>().toggleTheme,
            icon: Icon(context.watch<ThemeCubit>().state is DarkThemeState ? Icons.light_mode : Icons.dark_mode),
          ),
          IconButton(
            onPressed: context.read<LanguageCubit>().toggleLanguage,
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openPage(context, const CreatePropPage()).then((value) => null);
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: context.read<Database>().listen(BaseObjectType.prop),
        builder: (BuildContext context, value, Widget? child) {
          return ListView.builder(
            itemCount: _props.length,
            itemBuilder: (c, i) {
              return Slidable(
                key: ValueKey(_props[i].key),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {
                    _delete(_props[i]);
                  }),
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.red,
                      child: Icon(Icons.search),
                    )),
                    Expanded(
                        child: Container(
                      color: Colors.blue,
                      child: Icon(Icons.add),
                    )),
                  ],
                ),
                child: PropItemWidget(_props[i] as Prop),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool?> _confirmDissmis(BaseObject object) async {
    try {
      await context.read<Database>().delete(object);
    } catch (e) {
      return false;
    }
    return true;
  }

  void _delete(BaseObject object) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ThemeState.of(context).createDialog,
            title: Text('Did you realy wanna delete this?'),
            content: Text('If ypu delete this item , you can\'t return this.'),
            actions: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(elevation: 0),
                child: Text('No'),
              ),
              SizedBox(
                width: 8,
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text('Yes do it'),
              ),
            ],
          );
        });
  }
}
