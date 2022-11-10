import 'package:flutter/material.dart';

class MediaQueryHelper {
  final BuildContext context;
  MediaQueryHelper(this.context);

  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;
}
