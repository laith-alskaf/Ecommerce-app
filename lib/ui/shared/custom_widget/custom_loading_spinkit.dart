import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_e_commerce/ui/shared/colors.dart';

Widget showSpinKitLoading() {
  return Center(
    child: SpinKitCircle(
      color: AppColors.blueColor,
      size: 80.w,
    ),
  );
}