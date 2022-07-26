import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/widgets/create_dialog.dart';
import 'package:new_bus_information/application/widgets/driver_item.dart';
import 'package:new_bus_information/application/widgets/lottie/lottie_viewer.dart';
import 'package:new_bus_information/generated/l10n.dart';

class DriverChooser extends StatefulWidget {
  final List<Driver> drivers;

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

  List<Driver> get _searchedItems => widget.drivers
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
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.delete,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  confirmDismiss: (d) async {
                    if (await _confirmDelete(d)) {
                      Database.of(context).deleteDriver(_searchedItems[index]);
                      widget.drivers.removeAt(index);
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
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CreatorDialog(
        onAddDriver: _onAddItem,
        isDriverChooser: true,
      ),
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            icon: Icon(Icons.search),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }

  Widget _buildItemWidget(Driver driver) {
    return DriverItemWidget(driver);
  }

  void _onItemSelect(Driver driver) {
    Navigator.pop(context, driver);
  }

  void _onAddItem(Driver driver) {
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
            title: Text(S.of(context).deleteDriver),
            content: Text(S.of(context).deleteWarning),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(S.of(context).yes),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(S.of(context).no),
              ),
            ],
          ),
        ) ??
        false;
  }
}
