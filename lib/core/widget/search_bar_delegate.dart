// Corrección del SearchBarDelegate
import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/search_text_field.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final String hintText;

  SearchBarDelegate({required this.hintText});

  @override
  double get minExtent => 65.0;
  @override
  double get maxExtent => 65.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SearchTextField(hintText: hintText),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
