import 'package:flutter/material.dart';

void openPage(BuildContext context, StatefulWidget page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (s) => page,
    ),
  );
}
