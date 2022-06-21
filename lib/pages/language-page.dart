import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/cubit/language/language_cubit.dart';
import 'package:new_bus_information/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/generated/l10n.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();

  static void open(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (s) => const LanguagePage(),
      ),
    );
  }
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).name),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(S.of(context).toggleLanguage),
          onPressed: () {
            context.read<LanguageCubit>().toggleLanguage();
            context.read<ThemeCubit>().toggleTheme();

          },
        ),
      ),
    );
  }
}
