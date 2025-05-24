import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/add_travel/data/service/unsplash_service.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/no_search_results_box.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/refresh_images_button.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/search_header_row.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/search_image_button.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/search_image_item.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/search_results_grid.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/search_results_header.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/search_tips_box.dart';

class ImageSearchWidget extends StatefulWidget {
  final String destinationName;
  final String? selectedImageUrl;
  final Function(String) onImageSelected;

  const ImageSearchWidget({
    super.key,
    required this.destinationName,
    this.selectedImageUrl,
    required this.onImageSelected,
  });

  @override
  State<ImageSearchWidget> createState() => _ImageSearchWidgetState();
}

class _ImageSearchWidgetState extends State<ImageSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  bool _isSearching = false;
  String _currentSearchTerm = '';
  int _currentSearchCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.destinationName.isNotEmpty) {
      _searchController.text = widget.destinationName;
      _performSearch(widget.destinationName);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String searchTerm,
      {bool isRefresh = false}) async {
    if (searchTerm.trim().isEmpty) return;

    setState(() {
      _isSearching = true;
      _currentSearchTerm = searchTerm;
      if (!isRefresh) {
        _currentSearchCount = 0;
        _searchResults = [];
      }
    });

    try {
      List<String> results;

      if (isRefresh) {
        results = await UnsplashService.getRefreshedImages(
          searchTerm,
          count: 8,
        );
        _currentSearchCount++;
      } else {
        results = await UnsplashService.getCityImages(
          searchTerm,
          count: 8,
        );
        _currentSearchCount = 1;
      }

      if (mounted && _currentSearchTerm == searchTerm) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });

        if (isRefresh && results.isNotEmpty) {
          showCustomTopSnackBar(
            context: context,
            message: 'تم تحديث الصور بنجاح! (${results.length} صورة جديدة)',
          );
        }
      }
    } catch (e) {
      if (mounted && _currentSearchTerm == searchTerm) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });

        showCustomTopSnackBar(
          context: context,
          message: 'حدث خطأ أثناء البحث، يرجى المحاولة مرة أخرى',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchHeaderRow(currentSearchCount: _currentSearchCount),
          heightBox(16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.lightGrey.withOpacity(0.2),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن صور للوجهة...',
                hintStyle: Styles.font14GreyExtraBold,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                  size: 20.sp,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults = [];
                            _currentSearchCount = 0;
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              onSubmitted: (value) => _performSearch(value),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          heightBox(12),
          Row(
            children: [
              SearchImageButton(
                isSearching: _isSearching,
                onPressed: () => _performSearch(_searchController.text),
              ),
              widthBox(8),
              if (_searchResults.isNotEmpty)
                RefreshImagesButton(
                  isSearching: _isSearching,
                  onPressed: () => _performSearch(
                    _searchController.text,
                    isRefresh: true,
                  ),
                ),
            ],
          ),
          if (_searchResults.isEmpty && !_isSearching) ...[
            heightBox(16),
            const SearchTipsBox(),
          ],
          if (_searchResults.isNotEmpty) ...[
            heightBox(20),
            SearchResultsHeader(
              resultsCount: _searchResults.length,
            ),
            heightBox(12),
            SearchResultsGrid(
              searchResults: _searchResults,
              selectedImageUrl: widget.selectedImageUrl,
              buildImageItem: (imageUrl, isSelected, index) => SearchImageItem(
                imageUrl: imageUrl,
                isSelected: isSelected,
                index: index,
                onImageSelected: widget.onImageSelected,
              ),
            ),
          ],
          if (_searchResults.isEmpty &&
              !_isSearching &&
              _currentSearchTerm.isNotEmpty) ...[
            heightBox(20),
            const NoSearchResultsBox(),
          ],
        ],
      ),
    );
  }
}
