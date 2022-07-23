import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/new_driver.dart';
import 'package:new_bus_information/application/models/new_prop.dart';
import 'package:new_bus_information/application/widgets/bus_item.dart';
import 'package:new_bus_information/application/widgets/create_dialog.dart';
import 'package:new_bus_information/application/widgets/driver_item.dart';
import 'package:new_bus_information/application/widgets/lottie/lottie_viewer.dart';
import 'package:new_bus_information/generated/l10n.dart';

class DriverChooser extends StatefulWidget {
  final List<NewDriver> drivers;

  const DriverChooser({
    Key? key,
    required this.drivers,
  }) : super(key: key);

  @override
  State<DriverChooser> createState() => _DriverChooserState();
}

class _DriverChooserState extends State<DriverChooser> {
  Size get size => MediaQuery.of(context).size;

  final TextEditingController _controller = TextEditingController();

  List<NewDriver> get _searchedItems => widget.drivers
      .where((element) => element.name.toLowerCase().contains(_controller.text.trim().toLowerCase()))
      .toList();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).drivers),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _buildSearchBox(context),
          ),
          if (widget.drivers.isEmpty)
            Expanded(
              child: LottieViewer(
                width: size.width * .5,
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchedItems.length,
                itemBuilder: (BuildContext context, int index) => Dismissible(
                  key: ValueKey(_searchedItems[index].id),
                  confirmDismiss: (d) async {
                    if (await _confirmDelete(d)) {
                      NewDatabase.of(context).deleteDriver(_searchedItems[index]);
                      return true;
                    }
                    return false;
                  },
                  child: InkWell(
                    onTap: () {
                      _onItemSelect(_searchedItems[index]);
                    },
                    child: _buildItemWidget(_searchedItems[index]),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CreatorDialog(
        onAddDriver: _onAddItem,
        isDriverChooser: true,
      ),
    );
  }

  TextField _buildSearchBox(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        isDense: true,
        prefixIcon: Icon(Icons.search),
        enabledBorder: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(),
      ),
    );
  }

  Widget _buildItemWidget(NewDriver driver) {
    return DriverItemWidget(driver);
  }

  void _onItemSelect(NewDriver driver) {
    Navigator.pop(context, driver);
  }

  void _onAddItem(NewDriver driver) {
    setState(() {
      if (widget.drivers.isEmpty) {
        widget.drivers.add(driver);
      } else {
        widget.drivers.insert(0, driver);
      }
    });
  }

  Future<bool> _confirmDelete(DismissDirection direction) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Item ?'),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text('yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }
}
