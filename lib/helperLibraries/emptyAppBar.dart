import 'package:flutter/material.dart';
import '../helperLibraries/uiHelper.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';

import 'package:getwidget/getwidget.dart';
import 'package:bruno/bruno.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0,8,20,1),
    );
  }
  @override
  Size get preferredSize => Size(0.0, 0.0);
}