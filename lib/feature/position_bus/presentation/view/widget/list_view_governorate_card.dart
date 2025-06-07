import 'package:flutter/material.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/governorate_card.dart';

class ListViewGovernorateCard extends StatelessWidget {
  final List<GovernorateModel> governorates;

  const ListViewGovernorateCard({super.key, required this.governorates});

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, List<Station>>> governoratesList = governorates
        .expand((g) => g.data.entries.map((entry) => MapEntry(
              entry.value.namegovernorate,
              entry.value.stations,
            )))
        .toList();

    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: governoratesList.length,
        itemBuilder: (context, index) {
          final governorateEntry = governoratesList[index];
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
