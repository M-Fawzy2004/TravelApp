import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/manager/swip/swipe_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/manager/swip/swipe_state.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/view_all_featured.dart';

class ViewAllFeaturedBlocListener extends StatefulWidget {
  const ViewAllFeaturedBlocListener({super.key});

  @override
  State<ViewAllFeaturedBlocListener> createState() =>
      _ViewAllFeaturedBlocListenerState();
}

class _ViewAllFeaturedBlocListenerState
    extends State<ViewAllFeaturedBlocListener> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SwipeCubit>().reset();
      _hasNavigated = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<SwipeCubit>()
        .setMaxDragDistance(MediaQuery.of(context).size.width - 130.w - 28.w);
  }

  void _navigateToFeatured() {
    if (!_hasNavigated && mounted) {
      _hasNavigated = true;
      context.push(AppRouter.featuredHomeView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (_) {
        if (!_hasNavigated) {
          context.read<SwipeCubit>().startDrag();
        }
      },
      onHorizontalDragUpdate: (details) {
        if (!_hasNavigated) {
          context.read<SwipeCubit>().updateDrag(details.delta.dx);
        }
      },
      onHorizontalDragEnd: (_) {
        if (!_hasNavigated) {
          context.read<SwipeCubit>().endDrag();
        }
      },
      child: BlocListener<SwipeCubit, SwipeState>(
        listener: (context, state) {
          if (state is SwipeCompleted && !_hasNavigated) {
            _navigateToFeatured();
          }
        },
        child: BlocBuilder<SwipeCubit, SwipeState>(
          builder: (context, state) {
            double progress = 0.0;
            double dragOffset = 0.0;
            bool canComplete = false;

            if (state is SwipeDragging) {
              progress = state.progress;
              dragOffset = state.offset;
              canComplete = state.canComplete;
            } else if (state is SwipeCompleting) {
              progress = 1.0;
              canComplete = true;
            }

            return ViewAllFeatured(
              progress: progress,
              dragOffset: dragOffset,
              canComplete: canComplete,
            );
          },
        ),
      ),
    );
  }
}
