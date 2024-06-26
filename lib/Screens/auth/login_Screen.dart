import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test_arun/Screens/HomeScreen/home_Screen.dart';
import 'package:machine_test_arun/services/db.dart';
import 'package:machine_test_arun/services/web_Services.dart';
import 'package:machine_test_arun/utils/color_Const.dart';
import 'package:machine_test_arun/utils/common_Text.dart';
import 'package:machine_test_arun/utils/text_Style.dart';
import 'package:machine_test_arun/widgets/reusable_Widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //all sign In  controller here
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  //all sign up controller here
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpContyrCodeController = TextEditingController();
  TextEditingController signUpFirstNameController = TextEditingController();
  TextEditingController signUpLastNameController = TextEditingController();
  TextEditingController signUpPhoneNumberController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

// all variable here
  String loginType = "SignIn";
  bool loginloader = false;
  bool isLogInLoading = false;
  bool isSignUpLoading = false;

// all keys here
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

// all validator her
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  AutovalidateMode loginautoValidateMode = AutovalidateMode.disabled;
  getUserLoggedInStatus() async {
    await Db.getTokenKey().then((value) async {
      log("value : $value");
      if (value != "" && value != null) {
        final route = MaterialPageRoute(builder: (context) => HomeScreen());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else {}
    });
  }

  static String? validateCountryCode(String value) {
    value = value.trim();
    RegExp countryCodeRegex = RegExp(r'^\+?[1-9]\d{1,2}$');

    if (value.isEmpty) {
      return 'Country code is required';
    } else if (!countryCodeRegex.hasMatch(value)) {
      return 'Invalid country code format';
    } else if (value.length > 2) {
      // just A static check for our coutry you can modify it by your self
      return 'Country code cannot exceed 2 characters';
    }

    return null;
  }

  String? phone(String value) {
    if (value == "") {
      return "Please enter mobile number";
    } else if (value.length > 10 ||
        value.length < 10 ||
        value.contains(
            "~!@#{}%^&*()_+.,qwertyuiopasdfghjkl;':" "zxcvbnm<>?//*-+")) {
      return "Please enter correct phone number";
    } else if (value.contains(".")) {
      return "Please enter correct phone number";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return StringConstant.passwordRequired;
    } else if (value.length < 8) {
      return StringConstant.passwordvalid6digit;
    }
    return null;
  }

  String? _validateConfirmPassword(String value, String originalPassword) {
    if (value.isEmpty) {
      return "Confirm Password is required";
    }
    if (value != originalPassword) {
      return "Passwords do not match";
    }
    return null;
  }

  String? _validateFirstName(
    String value,
  ) {
    if (value.isEmpty) {
      return "Please enter First Name";
    }
    return null;
  }

  String? _validateLastName(
    String value,
  ) {
    if (value.isEmpty) {
      return "Please enter First Name";
    }
    return null;
  }

  bool _validateEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  @override
  void initState() {
    getUserLoggedInStatus();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: GradientPainter(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 38.w),
          child: ListView(
            children: [
              SizedBox(
                height: 120.h,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        loginType = "SignIn";
                      });
                    },
                    child: commonText(
                        StringConstant.signIn,
                        18.sp,
                        FontWeight.w400,
                        loginType == "SignIn"
                            ? ColorConst.blackColor
                            : ColorConst.lightTextColor),
                  ),
                  SizedBox(
                    width: 26.w,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        loginType = "SignUp";
                      });
                    },
                    child: commonText(
                        StringConstant.signUP,
                        18.sp,
                        FontWeight.w400,
                        loginType == "SignUp"
                            ? ColorConst.blackColor
                            : ColorConst.lightTextColor),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),

//if user select sign in
              loginType == "SignIn"
                  ? Form(
                      key: _loginFormKey,
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 2.h,
                              decoration: BoxDecoration(
                                color: ColorConst.greyLight,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 2.h,
                                    width: 57.w,
                                    decoration: BoxDecoration(
                                      color: loginType == "SignIn"
                                          ? ColorConst.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 26.w,
                                  ),
                                  Container(
                                    height: 2.h,
                                    width: 65.w,
                                    decoration: BoxDecoration(
                                      color: loginType == "SignUp"
                                          ? ColorConst.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an mail id';
                                }
                                if (!_validateEmail(value)) {
                                  return 'Please enter a valid mail id.';
                                }
                                return null;
                              },
                              controller: loginEmailController,
                              decoration: inputFieldDecoration(
                                  "Enter your email", "E-mail"),
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            TextFormField(
                              validator: (value) => validatePassword(value!),
                              controller: loginPasswordController,
                              decoration: inputFieldDecoration(
                                  "Enter your password", "Password"),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            isLogInLoading
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: ColorConst.primaryColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                  )
                                : commonButton(StringConstant.login, () {
                                    loginRequest();
                                  }),
                            SizedBox(
                              height: 10.h,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: commonText("Forgot Password?", 16.sp,
                                  FontWeight.w400, Colors.black),
                            ),
                            SizedBox(height: 45.h),
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 2.5.r,
                                )),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: commonText("Or signin with", 16.sp,
                                      FontWeight.w400, Colors.black),
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 2.5.r,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12.r),
                                  height: 48.h,
                                  width: 48.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey),
                                    ],
                                  ),
                                  child: Image.asset(
                                      "assets/appIcons/FaceBookLogo.png"),
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12.r),
                                  height: 48.h,
                                  width: 48.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey),
                                    ],
                                  ),
                                  child: Image.asset(
                                      "assets/appIcons/GoogleLogo.png"),
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12.r),
                                  height: 48.h,
                                  width: 48.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey),
                                    ],
                                  ),
                                  child: Image.asset(
                                      "assets/appIcons/applelogo.png"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Form(
                      key: _signUpFormKey,
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: 2.h,
                              decoration: BoxDecoration(
                                color: ColorConst.greyLight,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 2.h,
                                    width: 57.w,
                                    decoration: BoxDecoration(
                                      color: loginType == "SignIn"
                                          ? ColorConst.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 26.w,
                                  ),
                                  Container(
                                    height: 2.h,
                                    width: 65.w,
                                    decoration: BoxDecoration(
                                      color: loginType == "SignUp"
                                          ? ColorConst.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            TextFormField(
                              validator: (value) => _validateFirstName(value!),
                              controller: signUpFirstNameController,
                              decoration: inputFieldDecoration(
                                  "Enter your first name", "First name"),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              validator: (value) => _validateLastName(value!),
                              controller: signUpLastNameController,
                              decoration: inputFieldDecoration(
                                  "Enter your Last name", "Last name"),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              // readOnly: true,
                              // initialValue: ,
                              validator: (v) => validateCountryCode(v!),
                              controller: signUpContyrCodeController,
                              decoration: inputFieldDecoration(
                                  "Enter your Country code", "Country code"),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              validator: (v) => phone(v!),
                              controller: signUpPhoneNumberController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: inputFieldDecoration(
                                  "Enter your Phone no", "Phone no"),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an mail id';
                                }
                                if (!_validateEmail(value)) {
                                  return 'Please enter a valid mail id.';
                                }
                                return null;
                              },
                              controller: signUpEmailController,
                              decoration: inputFieldDecoration(
                                  "Enter your email", "E-mail"),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              validator: (v) => validatePassword(v!),
                              controller: signUpPasswordController,
                              decoration: inputFieldDecoration(
                                  "Enter your password", "Password"),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              validator: (v) => _validateConfirmPassword(
                                  v!, signUpPasswordController.text),
                              controller: signUpConfirmPasswordController,
                              decoration: inputFieldDecoration(
                                  "Enter your Confirm password",
                                  "Confirm password"),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            isSignUpLoading
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: ColorConst.primaryColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                  )
                                : commonButton(StringConstant.signUP, () {
                                    signUpRequest();
                                  }),
                            SizedBox(
                              height: 32.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 2.5.r,
                                )),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: commonText("Or signin with", 16.sp,
                                      FontWeight.w400, Colors.black),
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 2.5.r,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12.r),
                                  height: 48.h,
                                  width: 48.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey),
                                    ],
                                  ),
                                  child: Image.asset(
                                      "assets/appIcons/FaceBookLogo.png"),
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12.r),
                                  height: 48.h,
                                  width: 48.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey),
                                    ],
                                  ),
                                  child: Image.asset(
                                      "assets/appIcons/GoogleLogo.png"),
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12.r),
                                  height: 48.h,
                                  width: 48.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey),
                                    ],
                                  ),
                                  child: Image.asset(
                                      "assets/appIcons/applelogo.png"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                          ],
                        ),
                      ),
                    ),

              InkWell(
                onTap: () {
                  if (loginType == "SignIn") {
                    loginType = "SignUp";
                  } else if (loginType == "SignUp") {
                    loginType = "SignIn";
                  }

                  setState(() {});
                },
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: "EuclidCircularA",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorConst.lightTextColor),
                        text: loginType == "SignUp"
                            ? "Already have a Account?"
                            : "Don’t have a Account?",
                        children: [
                          TextSpan(
                            text:
                                loginType == "SignUp" ? " Sign In" : " Sign up",
                            style: TextStyle(
                                fontFamily: "EuclidCircularA",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5096F1)),
                          )
                        ])),
              ),
              SizedBox(
                height: 25.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginRequest() async {
    if (_loginFormKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.disabled;

      setState(() {
        isLogInLoading = true;
      });
      log("${loginEmailController.text}   ${loginPasswordController.text}");
      await WebService.logInRequest(
          loginEmailController.text, loginPasswordController.text, context);
      setState(() {
        isLogInLoading = false;
      });
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  Future<void> signUpRequest() async {
    if (_signUpFormKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.disabled;

      setState(() {
        isSignUpLoading = true;
      });
      log("${loginEmailController.text}   ${loginPasswordController.text}");
      await WebService.signUpRequest(
          signUpFirstNameController.text,
          signUpLastNameController.text,
          signUpContyrCodeController.text,
          signUpPhoneNumberController.text,
          signUpEmailController.text,
          signUpPasswordController.text,
          signUpConfirmPasswordController.text,
          context);
      setState(() {
        isSignUpLoading = false;
      });
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
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
