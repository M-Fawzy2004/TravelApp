import 'package:flutter/material.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/governorate_card.dart';

class ListViewGovernorateCard extends StatelessWidget {
  final List<MapEntry<String, List<Station>>> governorates;

  const ListViewGovernorateCard({super.key, required this.governorates});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: governorates.length,
        itemBuilder: (context, index) {
          final governorateEntry = governorates[index];
          return GovernorateCard(
            name: governorateEntry.key,
            stations: governorateEntry.value,
            key: ValueKey(governorateEntry.key),
          );
        },
      ),
    );
  }
}