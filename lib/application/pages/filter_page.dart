import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';
import 'package:new_bus_information/application/models/search_condidate_type.dart';
import 'package:new_bus_information/application/widgets/toggled_enum.dart';
import 'package:new_bus_information/application/widgets/toggled_grid_enum.dart';
import 'package:new_bus_information/generated/l10n.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  Widget _title(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  FilterTermsBloc _bloc(BuildContext context) {
    return context.read<FilterTermsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final FilterTermsState state = context.watch<FilterTermsBloc>().state;

    final Size size = MediaQuery.of(context).size;

    const Widget space = SizedBox(height: 16);
    const Widget downSpace = SizedBox(height: 36);
    final EdgeInsets sideSpace = EdgeInsets.symmetric(horizontal: size.width * 0.07);

    final ButtonStyle buttonStyle = _buttonStyle();

    final ScrollController controller = ScrollController();
    
    return ListView(
      controller: controller,
      children: [
        ExpansionTile(
          title: Text(S.of(context).bus),
          children: [
            space,
            _title(S.of(context).busStatus),
            space,
            Center(
              child: ToggledEnum(
                options: state.busStatusCondidateAsMap,
                onTap: (int index) {
                  _bloc(context).add(
                    SetBusStatusCondidateEvent(
                      newStatus: BusStatus.values[index],
                    ),
                  );
                },
              ),
            ),
            downSpace,
          ],
        ),
        ExpansionTile(
          title: Text(S.of(context).driver),
          children: [
            space,
            _title(S.of(context).driverStatus),
            space,
            Padding(
              padding: sideSpace,
              child: ToggledGridEnum(
                options: state.driverStatusCondidateAsMap,
                onTap: (int index) {
                  _bloc(context).add(
                    SetDriverStatusCondidateEvent(
                      newStatus: DriverStatus.values[index],
                    ),
                  );
                },
              ),
            ),
            space,
            _title(S.of(context).shiftWork),
            space,
            Padding(
              padding: sideSpace,
              child: ToggledGridEnum(
                options: state.driverShiftCondidateAsMap,
                onTap: (index) {
                  _bloc(context).add(
                    SetDriverShiftCondidateEvent(
                      newShift: ShiftWork.values[index],
                    ),
                  );
                },
              ),
            ),
            downSpace,
          ],
        ),
        ExpansionTile(
          title: Text(S.of(context).alternativeDriver),
          children: [
            space,
            _title(S.of(context).driverStatus),
            space,
            Padding(
              padding: sideSpace,
              child: ToggledGridEnum(
                options: state.secondDriverStatusCondidateAsMap,
                onTap: (index) {
                  _bloc(context).add(
                    SetSecondDriverStatusCondidateEvent(
                      newStatus: DriverStatus.values[index],
                    ),
                  );
                },
              ),
            ),
            space,
            _title(S.of(context).shiftWork),
            space,
            Padding(
              padding: sideSpace,
              child: ToggledGridEnum(
                options: state.secondDriverShiftCondidateAsMap,
                onTap: (int index) {
                  _bloc(context).add(
                    SetSecondDriverShiftCondidateEvent(
                      newShift: ShiftWork.values[index],
                    ),
                  );
                },
              ),
            ),
            downSpace
          ],
        ),
        space,
        _title(S.of(context).searchOn),
        Center(
          child: ToggledEnum(
            options: state.searchCondidateAsMap,
            onTap: (int index) {
              _bloc(context).add(
                SetSearchCondidateEvent(
                  newCondidate: SearchCondidateType.values[index],
                ),
              );
            },
          ),
        ),
        space,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                _title(S.of(context).from),
                OutlinedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: const Text('21/02/2022'),
                ),
              ],
            ),
            Column(
              children: [
                _title(S.of(context).to),
                OutlinedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: const Text('21/02/2022'),
                ),
              ],
            ),
          ],
        ),
        downSpace
      ],
    );
  }
}
