import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bus_information/application/cubit/filterProp/filter_prop_cubit.dart';
import 'package:bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:bus_information/application/database/database.dart';
import 'package:bus_information/application/models/prop/prop.dart';
import 'package:bus_information/application/pages/create_prop_page.dart';
import 'package:bus_information/application/utils.dart';
import 'package:bus_information/application/widgets/lottie/lottie_viewer.dart';
import 'package:bus_information/application/widgets/prop_item.dart';
import 'package:bus_information/generated/l10n.dart';

class PropListPage extends StatelessWidget {
  const PropListPage({Key? key}) : super(key: key);

  Widget slideButton({required IconData iconData, required String lable, required VoidCallback action}) {
    return SlidableAction(
      onPressed: (context) => action(),
      backgroundColor: const Color(0xFF21B7CA),
      foregroundColor: Colors.white,
      icon: iconData,
      label: lable,
    );
  }

  Widget propListView({
    required List<Prop> props,
    required Function(Prop) onDismissItem,
  }) {
    return ListView.builder(
      itemCount: props.length,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemBuilder: (BuildContext context, int index) {
        final slideButtons = [
          slideButton(
            iconData: Icons.delete_rounded,
            lable: S.of(context).delete,
            action: () async {
              if (await showDeleteDialog(context)) {
                delete(context, props[index]);
              }
            },
          ),
          slideButton(
            iconData: Icons.edit_rounded,
            lable: S.of(context).edite,
            action: () {
              edit(context, props[index]);
            },
          ),
        ];
        return Slidable(
          key: ValueKey(props[index].id),
          startActionPane: ActionPane(
            motion: const BehindMotion(),
            dismissible: DismissiblePane(
              confirmDismiss: () => showDeleteDialog(context),
              onDismissed: () => onDismissItem(props[index]),
              closeOnCancel: true,
            ),
            children: slideButtons,
          ),
          child: PropItemWidget(props[index]),
        );
      },
    );
  }

  Widget emptyWiew({required Size size}) {
    return Center(
      child: LottieViewer(
        width: size.width * .5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FilterPropCubit>().state;

    var child = state.filteredList.isEmpty
        ? emptyWiew(size: MediaQuery.of(context).size)
        : propListView(props: state.filteredList..reSort(), onDismissItem: (Prop prop) => delete(context, prop));

    return child;
  }

  void edit(BuildContext context, Prop prop) {
    openPage(
      context,
      CreatePropPage(
        prop: prop,
      ),
    );
  }

  void delete(BuildContext context, Prop prop) {
    Database.of(context).deleteProp(prop);
  }

  Future<bool> showDeleteDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: ThemeState.of(context).createDialog,
              title: Text(S.of(context).deleteProp),
              content: Text(S.of(context).deleteWarning),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(elevation: 0),
                  child: Text(S.of(context).no),
                ),
                const SizedBox(
                  width: 8,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(S.of(context).yes),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
