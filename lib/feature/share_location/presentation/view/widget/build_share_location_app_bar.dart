import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/theme/styles.dart';

AppBar buildShareLocationAppBar(BuildContext context) {
  return AppBar(
    elevation: 2,
    scrolledUnderElevation: 0,
    title: Text(
      'مشاركة موقعك',
      style: Styles.font20ExtraBlackBold(context),
    ),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        context.pop();
      },
      icon: const Icon(FontAwesomeIcons.arrowRight),
    ),
  );
}
