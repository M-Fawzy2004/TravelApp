import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/search_text_field.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final String hintText;

  SearchBarDelegate({required this.hintText});

  @override
  double get minExtent => 70.0;

  @override
  double get maxExtent => 70.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        alignment: Alignment.center,
        child: SearchTextField(hintText: hintText),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! SearchBarDelegate ||
        (oldDelegate).hintText != hintText;
  }

  @override
  TickerProvider? get vsync => null;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;
}
