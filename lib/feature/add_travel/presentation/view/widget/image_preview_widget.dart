import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_loading_circle.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/image_search.dart';

class ImagePreviewWidget extends StatefulWidget {
  final String imageUrl;
  final String destinationName;
  final bool showSearchButton;
  final Function(String)? onImageSelected;

  const ImagePreviewWidget({
    super.key,
    required this.imageUrl,
    required this.destinationName,
    this.showSearchButton = true,
    this.onImageSelected,
  });

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  void _showImageSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7.sp,
        minChildSize: 0.5.h,
        maxChildSize: 0.9.h,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ImageSearchWidget(
                destinationName: widget.destinationName,
                selectedImageUrl: widget.imageUrl,
                onImageSelected: (selectedImageUrl) {
                  if (widget.onImageSelected != null) {
                    widget.onImageSelected!(selectedImageUrl);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl.isEmpty) {
      return _buildEmptyState();
    }
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.white,
            ),
            _buildImageWidget(),
            if (widget.showSearchButton) _buildSearchButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 50.sp,
            color: Colors.grey[400],
          ),
          heightBox(12),
          Text(
            'اختر صورة للوجهة',
            style: Styles.font16BlackBold,
          ),
          heightBox(15),
          if (widget.showSearchButton)
            ElevatedButton.icon(
              onPressed: _showImageSearchModal,
              icon: Icon(Icons.search, size: 20.sp),
              label: Text(
                'البحث عن صور',
                style: Styles.font14GreyExtraBold.copyWith(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    if (!_isValidImageUrl(widget.imageUrl)) {
      return _buildErrorWidget('رابط الصورة غير صحيح');
    }

    return Image.network(
      widget.imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          color: AppColors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomLoadingCircle(),
                heightBox(10),
                Text(
                  'جاري تحميل الصورة...',
                  style: Styles.font14GreyExtraBold,
                ),
                heightBox(8),
                LinearProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('خطأ في تحميل الصورة: $error');
        debugPrint('رابط الصورة: ${widget.imageUrl}');

        return _buildErrorWidget('فشل في تحميل الصورة');
      },
      headers: const {
        'User-Agent': 'travel_app/1.0',
        'Accept': 'image/*',
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image_outlined,
              size: 50.sp,
              color: Colors.grey[400],
            ),
            heightBox(10),
            Text(
              message,
              style: Styles.font14GreyExtraBold,
              textAlign: TextAlign.center,
            ),
            heightBox(8),
            if (widget.showSearchButton)
              TextButton.icon(
                onPressed: _showImageSearchModal,
                icon: Icon(
                  Icons.search,
                  size: 16.sp,
                  color: AppColors.primaryColor,
                ),
                label: Text(
                  'البحث عن صورة أخرى',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return Positioned(
      top: 12.h,
      left: 12.w,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: _showImageSearchModal,
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 25.sp,
          ),
          tooltip: 'البحث عن صور أخرى',
        ),
      ),
    );
  }

  bool _isValidImageUrl(String url) {
    if (url.isEmpty) return false;

    try {
      final uri = Uri.parse(url);
      return uri.hasScheme &&
          (uri.scheme == 'http' || uri.scheme == 'https') &&
          uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }
}
