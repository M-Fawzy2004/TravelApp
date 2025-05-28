import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonListLoader extends StatelessWidget {
  const SkeletonListLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Container(
              width: 80.w,
              height: 60.h,
              color: Colors.grey,
            ),
            title: Container(
              height: 16.h,
              color: Colors.grey,
            ),
            subtitle: Container(
              height: 12.h,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
