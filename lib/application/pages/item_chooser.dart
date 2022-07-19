import 'package:flutter/material.dart';
import 'package:new_bus_information/application/models/base/base_object.dart';
import 'package:new_bus_information/application/models/base/base_object_extension.dart';
import 'package:new_bus_information/application/models/base/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/widgets/bus_item.dart';
import 'package:new_bus_information/application/widgets/create_dialog.dart';
import 'package:new_bus_information/application/widgets/driver_item.dart';
import 'package:new_bus_information/application/widgets/lottie/lottie_viewer.dart';
import 'package:new_bus_information/generated/l10n.dart';

class ItemChooser extends StatefulWidget {
  final List<BaseObject> items;
  final BaseObjectType type;

  const ItemChooser({
    Key? key,
    required this.items,
    this.type = BaseObjectType.bus,
  }) : super(key: key);

  @override
  State<ItemChooser> createState() => _ItemChooserState();
}

class _ItemChooserState extends State<ItemChooser> {
  Size get size => MediaQuery.of(context).size;
  final TextEditingController _controller = TextEditingController();

  List<BaseObject> get _searchedItems => widget.items
      .where((element) => element.searchTerm.toLowerCase().contains(_controller.text.trim().toLowerCase()))
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
        title: Text(widget.type.text),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _buildSearchBox(context),
          ),
          if (widget.items.isEmpty)
            Expanded(
              child: LottieViewer(
                width: size.width * .5,
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchedItems.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                    _onItemSelect(_searchedItems[index]);
                  },
                  child: _buildItemWidget(_searchedItems[index]),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CreatorDialog(
        onAddItem: _onAddItem,
        type: widget.type,
      ),
    );
  }

  Stream<List<BaseObject>> _stream() async* {}

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

  Widget _buildItemWidget(BaseObject item) {
    switch (item.type) {
      case BaseObjectType.bus:
        return BusItemWidget(item as Bus);
      case BaseObjectType.driver:
        return DriverItemWidget(item as Driver);
      default:
        return BusItemWidget(item as Bus);
    }
  }

  void _onItemSelect(BaseObject item) {
    Navigator.pop(context, item);
  }

  void _onAddItem(BaseObject item) {
    setState(() {
      if (widget.items.isEmpty) {
        widget.items.add(item);
      } else {
        widget.items.insert(0, item);
      }
    });
  }

  void _search(String text) {}
}
