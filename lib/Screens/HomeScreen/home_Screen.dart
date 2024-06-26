import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test_arun/Models/user_detail_Model.dart';
import 'package:machine_test_arun/Screens/profileScreen/profile_Screen.dart';
import 'package:machine_test_arun/services/db.dart';
import 'package:machine_test_arun/services/web_Services.dart';
import 'package:machine_test_arun/utils/color_Const.dart';
import 'package:machine_test_arun/utils/common_Text.dart';
import 'package:machine_test_arun/utils/text_Style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//init state
  @override
  void initState() {
    getUserDetailRequest();
    getUSerData();
    // TODO: implement initState
    super.initState();
  }

// varialble here
  bool isLoading = false;
  int _onGriedSelected = 0;
  String? userName;
  String? userLastName;
  String? userEmail;
  String? userProfileUrl;

//all model instance here
  UserDetailModel? userDetailModel;

//all Api function here
  getUserDetailRequest() async {
    setState(() {
      isLoading = true;
    });
    userDetailModel = await WebService.getUserRequest(context);

    setState(() {
      isLoading = false;
    });
  }

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
  }

// refresh indicator
  Future<void> _onRefresh() async {
    getUserDetailRequest();
    getUSerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConst.primaryColor,
              ),
            )
          : RefreshIndicator(
              color: ColorConst.primaryColor,
              onRefresh: _onRefresh,
              child: CustomPaint(
                  painter: GradientPainter(),
                  child: Container(
                    child: ListView(
                      children: [
                        Card(
                          elevation: 0,
                          child: ListTile(
                            title: commonText(
                                userName != null && userLastName != null
                                    ? "${userName!} ${userLastName}"
                                    : "",
                                17.sp,
                                FontWeight.w500,
                                ColorConst.blackColor),
                            subtitle: commonText(
                                userEmail != null ? userEmail! : "",
                                13.sp,
                                FontWeight.w400,
                                ColorConst.lightTextColor),
                            leading: userProfileUrl != null
                                ? SizedBox(
                                    height: 48.h,
                                    width: 45.w,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        userProfileUrl!,
                                      ),
                                    ),
                                  )
                                : Icon(Icons.person_outline_rounded),
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonText(StringConstant.userList, 17.sp,
                                  FontWeight.w500, ColorConst.blackColor),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(
                                        color: ColorConst.greyLight,
                                        width: 0.5.w)),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _onGriedSelected = 0;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.list_alt_outlined,
                                          color: _onGriedSelected == 0
                                              ? ColorConst.primaryColor
                                              : ColorConst.blackColor,
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        _onGriedSelected = 1;
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.grid_view,
                                        color: _onGriedSelected == 1
                                            ? ColorConst.primaryColor
                                            : ColorConst.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        userDetailModel != null &&
                                userDetailModel!.userList.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 23.w),
                                child: _onGriedSelected == 1
                                    ? GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                        ),
                                        shrinkWrap: true,
                                        itemCount:
                                            userDetailModel!.userList.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 8.w),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  border: Border.all(
                                                      color:
                                                          ColorConst.greyLight,
                                                      width: 0.5.w)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: commonText(
                                                            "first name: ${userDetailModel!.userList[index].firstName}",
                                                            12.sp,
                                                            FontWeight.w400,
                                                            ColorConst
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: commonText(
                                                            "last name: ${userDetailModel!.userList[index].lastName}",
                                                            12.sp,
                                                            FontWeight.w400,
                                                            ColorConst
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: commonText(
                                                            "Email address: ${userDetailModel!.userList[index].email}",
                                                            12.sp,
                                                            FontWeight.w400,
                                                            ColorConst
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: commonText(
                                                            "phone number: ${userDetailModel!.userList[index].phoneNo}",
                                                            12.sp,
                                                            FontWeight.w400,
                                                            ColorConst
                                                                .blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ));
                                        },
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: userDetailModel!
                                                .userList.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                elevation: 0.5,
                                                child: ListTile(
                                                  title: commonText(
                                                      "first name: ${userDetailModel!.userList[index].firstName}",
                                                      12.sp,
                                                      FontWeight.w400,
                                                      ColorConst.blackColor),
                                                  subtitle: commonText(
                                                      "first name: ${userDetailModel!.userList[index].lastName}",
                                                      12.sp,
                                                      FontWeight.w400,
                                                      ColorConst.blackColor),
                                                  trailing: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  ProfileScreen()));
                                                    },
                                                    child: Container(
                                                      height: 25.h,
                                                      width: 80.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: ColorConst
                                                                .primaryColor,
                                                            width: 0.5.w),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.r),
                                                      ),
                                                      child: Center(
                                                        child: commonText(
                                                            StringConstant
                                                                .viewProfile,
                                                            12.sp,
                                                            FontWeight.w400,
                                                            ColorConst
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ))
                            : commonText("No Data Found", 20.sp,
                                FontWeight.w500, ColorConst.primaryColor),
                      ],
                    ),
                  )),
            ),
    );
  }
}

class GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xffD8F1FE).withOpacity(0.3),
          Color(0xffD8F1FE).withOpacity(0.3),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawCircle(
      Offset(0, 0),
      size.width * 0.5,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width, size.height),
      size.width * 0.5,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
