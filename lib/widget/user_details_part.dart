import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../utils/colors.dart';
import '../views/ProfileScreen/edit_profile_screen.dart';

class UserDetailsPart extends StatefulWidget {
  const UserDetailsPart({super.key});

  @override
  State<UserDetailsPart> createState() => _UserDetailsPartState();
}

class _UserDetailsPartState extends State<UserDetailsPart> {
  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var data = snapshot.data;
          return Card(
            color: themeManager.themeMode == ThemeMode.light
                ? AppColor.fieldBackgroundColor
                : Colors.grey[900],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          ClipOval(
                            clipBehavior: Clip.hardEdge,
                            child: GestureDetector(
                              onTap: () async {
                                //! Use Navigator to show a full-screen image page
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      backgroundColor: color,
                                      body: Center(
                                        child: Hero(
                                            tag: 'user-avatar',
                                            child: data['image'] != ""
                                                ? Image.network(
                                                    data['image'],
                                                    height: 50.h,
                                                    width: 50.w,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    "assets/avatar.png",
                                                    height: 50.h,
                                                    width: 50.w,
                                                  )),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                  tag: 'user-avatar',
                                  child: data!['image'] != ""
                                      ? Image.network(
                                          data['image'],
                                          height: 50.h,
                                          width: 50.w,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/avatar.png",
                                          height: 50.h,
                                          width: 50.w,
                                        )),
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            right: -15,
                            child: IconButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProfileEditScreen()));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: color,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Text(
                              data['name'],
                              style: TextStyle(fontSize: 15.sp, color: color),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2, bottom: 5),
                            child: Text(
                              data['email'],
                              style: TextStyle(color: color),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2, bottom: 5),
                            child: Text(
                              data['address'],
                              style: TextStyle(color: color),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
