import 'package:flutter/material.dart';

class ScaleConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  static late double scaleFactor;
  static late double screenWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    scaleFactor = MediaQuery.of(context).textScaleFactor;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 375;
    blockSizeVertical = screenHeight / 667;
  }

  double scaleHeight(myHeight) {
    return blockSizeVertical * myHeight * scaleFactor;
  }

  double scaleWidth(myWidth) {
    return blockSizeHorizontal * myWidth * scaleFactor;
  }
}
