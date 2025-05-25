import 'package:flutter/material.dart';

import '../theme/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.isAction = false,
    this.isLeading = false,
    this.iconLeading,
    this.iconAction,
  });

  final String title;
  final bool isAction;
  final bool isLeading;
  final IconButton? iconLeading;
  final IconButton? iconAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Text(
        title,
        style: Styles.font20ExtraBlackBold(context),
      ),
      centerTitle: true,
      leading: isLeading ? iconLeading : null,
      actions: isAction && iconAction != null ? [iconAction!] : null,
    );
  }
}
