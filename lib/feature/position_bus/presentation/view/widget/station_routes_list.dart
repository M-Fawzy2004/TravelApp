import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/route_list_tile.dart';

class StationRoutesList extends StatelessWidget {
  const StationRoutesList({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: station.routes.length,
      separatorBuilder: (context, index) => heightBox(8),
      itemBuilder: (context, index) {
        final route = station.routes[index];
        return RouteListTile(route: route);
      },
    );
  }
}
