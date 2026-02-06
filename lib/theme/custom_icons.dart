import 'package:flutter/widgets.dart';
import 'package:kuzco_app/kuzcco_app.dart';

class CustomIcons implements AppIcons {
  CustomIcons._();
  static final CustomIcons instance = CustomIcons._();
  static const _kFontFam = 'mymIcons';
  static const String? _kFontPkg = null;

  @override
  IconData get homeFilled => IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  IconData get homeOutlined => IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  IconData get searchFilled => IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  IconData get searchOutlined => IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  IconData get cartFilled => IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  IconData get cartOutlined => IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  IconData get userFilled => IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  IconData get userOutlined => IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
