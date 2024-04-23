import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIHelper {
  static final double _verticalSpaceExtraSmall = 4.0.h;
  static final double _verticalSpaceSmall = 8.0.h;
  static final double _verticalSpaceMedium = 16.0.h;
  static final double _verticalSpaceLarge = 24.0.h;
  static final double _verticalSpaceExtraLarge = 48.h;

  static final double _horizontalSpaceExtraSmall = 4.0.w;
  static final double _horizontalSpaceSmall = 8.0.w;
  static final double _horizontalSpaceMedium = 16.0.w;
  static final double _horizontalSpaceLarge = 24.0.w;
  static final double _horizontalSpaceExtraLarge = 48.0.w;

  static SizedBox verticalSpaceExtraSmall() =>
      verticalSpace(_verticalSpaceExtraSmall);
  static SizedBox verticalSpaceSmall() => verticalSpace(_verticalSpaceSmall);
  static SizedBox verticalSpaceMedium() => verticalSpace(_verticalSpaceMedium);
  static SizedBox verticalSpaceLarge() => verticalSpace(_verticalSpaceLarge);
  static SizedBox verticalSpaceExtraLarge() =>
      verticalSpace(_verticalSpaceExtraLarge);

  static SizedBox verticalSpace(double height) => SizedBox(height: height);

  static SizedBox horizontalSpaceExtraSmall() =>
      horizontalSpace(_horizontalSpaceExtraSmall);
  static SizedBox horizontalSpaceSmall() =>
      horizontalSpace(_horizontalSpaceSmall);
  static SizedBox horizontalSpaceMedium() =>
      horizontalSpace(_horizontalSpaceMedium);
  static SizedBox horizontalSpaceLarge() =>
      horizontalSpace(_horizontalSpaceLarge);
  static SizedBox horizontalSpaceExtraLarge() =>
      horizontalSpace(_horizontalSpaceExtraLarge);

  static SizedBox horizontalSpace(double width) => SizedBox(width: width);
}
