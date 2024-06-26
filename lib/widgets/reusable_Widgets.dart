import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test_arun/utils/color_Const.dart';
import 'package:machine_test_arun/utils/text_Style.dart';

InputDecoration inputFieldDecoration(
  String hintText,
  String label,
) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
        fontFamily: "EuclidCircularA",
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: ColorConst.lightTextColor),
    label: commonText(label, 16.sp, FontWeight.w500, ColorConst.blackColor),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: Color(0Xff263238),
      ),
      borderRadius: BorderRadius.circular(4.r),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: Color(0Xff263238),
      ),
      borderRadius: BorderRadius.circular(4.r),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: Color(0Xff263238),
      ),
      borderRadius: BorderRadius.circular(4.r),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(
        width: 0.5,
        color: Color(0Xff263238),
      ),
    ),
  );
}

Widget commonButton(String title, Function() _onTap) {
  return InkWell(
    onTap: _onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorConst.primaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
          child: commonText(title, 18.sp, FontWeight.w400, Colors.white)),
    ),
  );
}
