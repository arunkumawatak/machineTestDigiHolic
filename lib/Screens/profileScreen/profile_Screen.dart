import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test_arun/services/db.dart';
import 'package:machine_test_arun/services/web_Services.dart';
import 'package:machine_test_arun/utils/color_Const.dart';
import 'package:machine_test_arun/utils/text_Style.dart';
import 'package:machine_test_arun/widgets/reusable_Widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
// all variable here
  String? userName;
  String? userLastName;
  String? userEmail;
  String? userProfileUrl;
  bool isLoading = false;

  //all api functions here
  getUSerData() async {
    await Db.getUserName().then((value) {
      userName = value!;
    });

    await Db.getUserLastName().then((value) {
      userLastName = value!;
    });
    await Db.getUserEmail().then((value) {
      userEmail = value!;
    });
    await Db.getProfileURL().then((value) {
      userProfileUrl = value!;
    });
    setState(() {});
  }

//init state
  @override
  void initState() {
    getUSerData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 43.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: userProfileUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(userProfileUrl!),
                    )
                  : Icon(Icons.person_2_outlined),
            ),
            SizedBox(
              height: 20.h,
            ),
            userName != null && userLastName != null
                ? commonText("${userName!} ${userLastName!}", 17.sp,
                    FontWeight.w500, ColorConst.blackColor)
                : SizedBox(),
            SizedBox(
              height: 12.h,
            ),
            userEmail != null
                ? commonText(
                    userEmail!, 17.sp, FontWeight.w500, ColorConst.blackColor)
                : SizedBox(),
            SizedBox(
              height: 12.h,
            ),
            SizedBox(
              height: 50.h,
            ),
            isLoading
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: ColorConst.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                        child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )),
                  )
                : commonButton("LogOut", () async {
                    setState(() {
                      isLoading = true;
                    });
                    await WebService.logOutRequest(context);
                    setState(() {
                      isLoading = false;
                    });
                  })
          ],
        ),
      ),
    );
  }
}
