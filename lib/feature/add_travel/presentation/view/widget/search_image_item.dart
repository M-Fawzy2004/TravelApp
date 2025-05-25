import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';

class SearchImageItem extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final int index;
  final void Function(String) onImageSelected;

  const SearchImageItem({
    super.key,
    required this.imageUrl,
    required this.isSelected,
    required this.index,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onImageSelected(imageUrl);
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? AppColors.getPrimaryColor(context)
                : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Stack(
            children: [
              _buildNetworkImage(imageUrl),
              Positioned(
                top: 6.h,
                left: 6.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.getPrimaryColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      onImageSelected(imageUrl);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkImage(String imageUrl) {
    return Image.network(
      imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          color: Colors.grey[200],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }
}
