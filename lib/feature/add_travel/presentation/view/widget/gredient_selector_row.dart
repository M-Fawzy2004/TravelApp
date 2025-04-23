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
  final List<LinearGradient> _gradientsList = [
    const LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)]),
    const LinearGradient(colors: [Color(0xFFEDE7F6), Color(0xFFB39DDB)]),
    const LinearGradient(colors: [Color(0xFFE0F2F1), Color(0xFF80CBC4)]),
    const LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)]),
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
