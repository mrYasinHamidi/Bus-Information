import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/pages/language-page.dart';
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
        leading: GestureDetector(
          onTap: () {
            context.read<ThemeCubit>().toggleTheme();
          },
          child: const Icon(Icons.switch_access_shortcut),
        ),
        actions: [
          IconButton(
            onPressed: () {
              LanguagePage.open(context);
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
