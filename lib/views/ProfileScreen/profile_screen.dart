// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable, unused_import, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/views/ProfileScreen/edit_profile_screen.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:e_commerce/widget/user_details_part.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../Authentication/LoginScreen/login_screen.dart';
import '../CartScreen/oder_screen.dart';
import 'faq_screen.dart';
import 'privacy_policy_screen.dart';
import 'support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black,
        appBar: customAppBar(
          context: context,
          isBack: false,
          // isLeading: InkWell(
          //   onTap: (){
          //     Navigator.pop(context);
          //   },
          //     child: Icon(Icons.arrow_back),
          // ),
          title: "Profile Screen",
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                //User Details Part
                UserDetailsPart(),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.payment,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Order',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OrderScreen()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: color,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Support',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SupportScreen()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: color,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Privacy',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PrivacyScreen()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: color,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'FAQ',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FAQScreen()));
                            },
                            icon: Icon(
                              Icons.question_answer,
                              color: color,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.color_lens,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Theme',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        //changing theme
                        Switch(
                            value: themeManager.themeMode == ThemeMode.dark,
                            activeColor: color,
                            onChanged: (value) async {
                              setState(() {
                                themeManager.toggleTheme(value);
                              });
                            })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false);
                  },
                  child: Card(
                    color: themeManager.themeMode == ThemeMode.light
                        ? AppColor.fieldBackgroundColor
                        : Colors.grey[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 10,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: color,
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Text(
                                  'LogOut',
                                  style:
                                      TextStyle(fontSize: 18.sp, color: color),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
