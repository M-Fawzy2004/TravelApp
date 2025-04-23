import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/gradient_selector.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';

class GradientSelectorRow extends StatefulWidget {
  const GradientSelectorRow({
    super.key,
  });

  @override
  State<GradientSelectorRow> createState() => _GradientSelectorRowState();
}

class _GradientSelectorRowState extends State<GradientSelectorRow> {
  late LinearGradient _selectedGradient = _gradientsList[0];
  static const List<LinearGradient> _gradientsList = [
    LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)]),
    LinearGradient(colors: [Color(0xFFFCE4EC), Color(0xFFF48FB1)]),
    LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)]),
    LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)]),
  ];

  @override
  Widget build(BuildContext context) {
    return RowWithLabel(
      label: 'اختر خلفية',
      widget: GradientSelector(
        selectedGradient: _selectedGradient,
        gradients: _gradientsList,
        onChanged: (gradient) {
          setState(() => _selectedGradient = gradient);
          final selectedIndex = _gradientsList.indexOf(gradient);
          context.read<TripFormCubit>().setGradientIndex(selectedIndex);
        },
      ),
    );
  }
}
