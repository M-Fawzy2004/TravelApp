import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultsGrid extends StatelessWidget {
  final List<String> searchResults;
  final String? selectedImageUrl;
  final Widget Function(String imageUrl, bool isSelected, int index) buildImageItem;

  const SearchResultsGrid({
    super.key,
    required this.searchResults,
    required this.selectedImageUrl,
    required this.buildImageItem,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.3,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final imageUrl = searchResults[index];
        final isSelected = selectedImageUrl == imageUrl;

        return buildImageItem(imageUrl, isSelected, index);
      },
    );
  }
}
