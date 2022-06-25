import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/pages/create-prop-page.dart';
import 'package:new_bus_information/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).name),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
            icon: Icon(context.watch<ThemeCubit>().state is DarkThemeState ? Icons.light_mode : Icons.dark_mode),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          CreatePropPage.open(context);
        },
      ),
      body: Container(),
    );
  }
}
