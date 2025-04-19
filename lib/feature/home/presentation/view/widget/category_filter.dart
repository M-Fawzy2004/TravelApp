import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_filter_item.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({super.key});

  @override
  State<CategoryFilter> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategoryFilter> {
  List<String> filterText = [
    'الكل',
    'رحلات',
    'توصيل',
    'موقف',
  ];

  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filterText.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                isSelected = index;
              });
            },
            child: CategoryFilterItem(
              text: filterText[index],
              isSelected: isSelected == index,
            ),
          );
        }),
      ),
    );
  }
}
