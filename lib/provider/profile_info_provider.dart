import 'package:flutter/material.dart';

class ProfileInfoProvider extends ChangeNotifier {
  String? _status;
  ImageProvider? _displayImg;

  void setStatus(String status) {
    _status = status;
  }

  void setDisplayImg(ImageProvider image) {
    _displayImg = image;
  }

  ImageProvider? get displayImg => _displayImg;
  String? get status => _status;
}
