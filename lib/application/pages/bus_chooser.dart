import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bus_information/application/database/database.dart';
import 'package:bus_information/application/models/bus/bus.dart';
import 'package:bus_information/application/widgets/bus_item.dart';
import 'package:bus_information/application/widgets/create_dialog.dart';
import 'package:bus_information/application/widgets/lottie/lottie_viewer.dart';
import 'package:bus_information/generated/l10n.dart';

class BusChooser extends StatefulWidget {
  final List<Bus> buses;

  const BusChooser({
    Key? key,
    required this.buses,
  }) : super(key: key);

  @override
  State<BusChooser> createState() => _BusChooserState();
}

class _BusChooserState extends State<BusChooser> {
  Size get size => MediaQuery.of(context).size;

  final TextEditingController _controller = TextEditingController();

  List<Bus> get _searchedItems =>
      widget.buses.where((element) => element.code.contains(_controller.text.trim().toLowerCase())).toList();

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
        title: Text(S.of(context).bus),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _buildSearchBox(context),
          ),
          if (widget.buses.isEmpty)
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
                      Database.of(context).deleteBus(_searchedItems[index]);
                      widget.buses.removeAt(index);
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
      floatingActionButton: CreatorDialog(
        isDriverChooser: false,
        onAddBus: _onAddItem,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
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

  Widget _buildItemWidget(Bus bus) {
    return BusItemWidget(bus);
  }

  void _onItemSelect(Bus bus) {
    Navigator.pop(context, bus);
  }

  void _onAddItem(Bus bus) {
    setState(() {
      if (widget.buses.isEmpty) {
        widget.buses.add(bus);
      } else {
        widget.buses.insert(0, bus);
      }
    });
  }

  Future<bool> _confirmDelete(DismissDirection direction) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(S.of(context).deleteBus),
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
