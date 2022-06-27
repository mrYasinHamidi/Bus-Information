import 'package:flutter/material.dart';

Future openPage(BuildContext context, StatefulWidget page) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (s) => page,
      ),
    );
