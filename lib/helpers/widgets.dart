import 'dart:io';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/widgets/form.dart';

// Future<dynamic> getNotificationCount(int id) async {
//   NoticeBoardModel obj = NoticeBoardModel();
//   dynamic res = await obj.getCount(id);

//   if (res['ok'] > 0) {
//     return res;
//   }
// }

// Widget getImage(StudentModel obj, {double width = 100}) {
//   if (obj.profile.isEmpty) {
//     return Image.asset(
//       "assets/images/profile.png",
//       width: width,
//       alignment: Alignment.centerLeft,
//     );
//   } else {
//     return Image.network(
//       "$media_url${obj.profile}",
//       alignment: Alignment.centerLeft,
//       width: width,
//     );
//   }
// }

// Widget getProfileImage(StudentModel obj, {double width = 65}) {
//   if (obj.profile.isEmpty) {
//     return Image.asset(
//       "assets/images/profile.png",
//       width: width,
//       fit: BoxFit.contain,
//     );
//   } else {
//     return Image.network(
//       "$media_url${obj.profile}",
//       width: width,
//       fit: BoxFit.contain,
//       errorBuilder: (context, error, stackTrace) {
//         return const Center(child: Icon(Icons.person));
//       },
//     );
//   }
// }

// Widget navBar(context, scaffoldKey, String title,
//     {String subtitle = "Subtitle here",
//     bool isBack = false,
//     Function? refresh,
//     Function? backFunction,
//     bool is_bell = true,
//     required sessionUser,
//     int count = 0}) {
//   return Container(
//     height: 65,
//     decoration: BoxDecoration(
//       color: primaryColor,
//       borderRadius: BorderRadius.circular(50), // Adjust the radius as needed
//     ),
//     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     padding: const EdgeInsets.only(right: 25),
//     child: Stack(
//       alignment: Alignment.centerRight,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(width: 70),
//                 SizedBox(
//                   width: 200,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       textH2(title, color: whiteColor),
//                       subtext(subtitle, font_size: 11.5, color: whiteColor),
//                     ],
//                   ),
//                 ),
//                 const Expanded(child: SizedBox()),
//                 is_bell
//                     ? GestureDetector(
//                         onTap: () {
//                           Get.logout(context);
//                           // if (sessionUser != null) {
//                           //   NoticeBoardModel notic = NoticeBoardModel();
//                           //   notic.markAsSeenAllSeen(sessionUser.id);
//                           //   Get.to(context, () => NotificationPage(sessionUser),
//                           //       then: () {
//                           //     if (refresh != null) {
//                           //       refresh();
//                           //     }
//                           //   });
//                           // }
//                         },
//                         child: const Icon(
//                           Icons.logout,
//                           color: whiteColor,
//                         ),
//                       )
//                     : Container(),
//               ],
//             ),
//           ],
//         ),
//         Positioned(
//           top: 0,
//           left: 0,
//           bottom: 0,
//           child: isBack == true
//               ? GestureDetector(
//                   onTap: () {
//                     if (backFunction != null) {
//                       backFunction();
//                     } else {
//                       if (Get.isBack(context)) {
//                         Get.back(context);
//                       } else {
//                         // Get.toWithNoBack(context, () => HomePage(sessionUser));
//                       }
//                     }
//                   },
//                   child: const SizedBox(
//                     width: 70,
//                     height: 100,
//                     child: Icon(Icons.arrow_back, color: whiteColor),
//                   ),
//                 )
//               : GestureDetector(
//                   onTap: () {
//                     // scaffoldKey.currentState?.openDrawer();
//                   },
//                   // child: getImage(sessionUser),
//                 ),
//         ),
//         // is_bell
//         //     ? Positioned(
//         //         top: 10,
//         //         right: 0,
//         //         child: FutureBuilder(
//         //           future: getNotificationCount(sessionUser.id),
//         //           builder: (context, snapshot) {
//         //             Widget rslt = Container();
//         //             if (Get.snapshotResult(snapshot)) {
//         //               List<NoticeBoardModel> all = snapshot.data!['data'];
//         //               count = all.length;
//         //               rslt = Container(
//         //                 padding: const EdgeInsets.symmetric(
//         //                     horizontal: 3, vertical: 1),
//         //                 decoration: BoxDecoration(
//         //                   color: Colors.red,
//         //                   borderRadius: BorderRadius.circular(50),
//         //                 ),
//         //                 child: textH3("$count", color: whiteColor),
//         //               );
//         //             }

//         //             return rslt;
//         //           },
//         //         ),
//         //       )
//         //     : Container()
//       ],
//     ),
//   );
// }

// Widget facultyNavBar(context, scaffoldKey, String title,
//     {String subtitle = "Subtitle here",
//     bool isBack = false,
//     Function? refresh,
//     required sessionUser,
//     int count = 0}) {
//   return Container(
//     height: 65,
//     decoration: BoxDecoration(
//       color: primaryColor,
//       borderRadius: BorderRadius.circular(50), // Adjust the radius as needed
//     ),
//     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     padding: const EdgeInsets.only(right: 25),
//     child: Stack(
//       alignment: Alignment.centerRight,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(width: 70),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     textH2(title, color: whiteColor),
//                     subtext(subtitle, font_size: 12, color: whiteColor),
//                   ],
//                 ),
//                 const Expanded(child: SizedBox()),
//                 GestureDetector(
//                   onTap: () {
//                     Get.logout(context);
//                   },
//                   child: const Icon(
//                     Icons.logout,
//                     color: whiteColor,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Positioned(
//           top: 0,
//           left: 0,
//           bottom: 0,
//           child: isBack == true
//               ? GestureDetector(
//                   onTap: () {
//                     if (Get.isBack(context)) {
//                       Get.back(context);
//                     } else {
//                       // Get.toWithNoBack(
//                       //     context, () => FacultyHomePage(sessionUser));
//                     }
//                   },
//                   child: const SizedBox(
//                     width: 70,
//                     height: 100,
//                     child: Icon(Icons.arrow_back, color: whiteColor),
//                   ),
//                 )
//               : GestureDetector(
//                   onTap: () {
//                     // scaffoldKey.currentState?.openDrawer();
//                   },
//                   // child: getImage(sessionUser),
//                 ),
//         ),
//       ],
//     ),
//   );
// }

// Widget bottomBar(int selectedIndex, Function? onItemTapped) {
//   return BottomNavigationBar(
//     type: BottomNavigationBarType.fixed,
//     items: const <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         label: 'Home',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.shopping_bag),
//         label: 'Wallet',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.shopping_cart),
//         label: 'Transactions',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.person),
//         label: 'Account',
//       ),
//     ],
//     currentIndex: 4 > selectedIndex ? selectedIndex : 0,
//     selectedItemColor: primaryColor,
//     onTap: (index) {
//       if (onItemTapped != null) {
//         onItemTapped(index);
//       }
//     },
//   );
// }

Widget textField(String labelText,
    {TextEditingController? controller,
    String? hintText,
    Function? validator,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    String prefixText = "",
    bool isPassword = false,
    bool readOnly = false,
    Function(String)? onChanged,
    Function()? onTap}) {
  return TextFormField(
    validator: (text) {
      if (validator != null) {
        return validator(text);
      }
      return null;
    },
    controller: controller,
    keyboardType: keyboardType,
    maxLength: maxLength,
    obscureText: isPassword,
    readOnly: readOnly,
    onChanged: onChanged,
    onTap: onTap,
    decoration: InputDecoration(
        counterText: "",
        prefixText: prefixText, // Prefix text
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w400)),
  );
}

// Widget darkButton(Widget text,
//     {Color primary = primaryColor,
//     Function? onPressed,
//     double borderRadius = 5}) {
//   return ElevatedButton(
//     onPressed: () {
//       if (onPressed != null) {
//         onPressed();
//       }
//     },
//     style: ElevatedButton.styleFrom(
//       foregroundColor: whiteColor,
//       backgroundColor: primary, // Background color
//       shadowColor: primary.withOpacity(0.5), // Shadow color
//       elevation: 0, // Shadow elevation
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//     ),
//     child: text,
//   );
// }

// Widget outlineButton(Widget text,
//     {Color primary = primaryColor,
//     double border_radius = 5,
//     double width = 1,
//     Function? onPressed}) {
//   return OutlinedButton(
//     onPressed: () {
//       if (onPressed != null) {
//         onPressed();
//       }
//     },
//     style: OutlinedButton.styleFrom(
//       foregroundColor: primary, // Background color
//       elevation: 5, // Shadow elevation
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(border_radius),
//       ),
//       side: BorderSide(
//         color: primary, // Set disabled border color here
//         width: width, // Set border width here
//       ),
//     ),
//     child: text,
//   );
// }

Widget buttonIconText(Widget text,
    {Color primary = primaryColor,
    IconData? icon,
    double border_radius = 5,
    Function? onPressed}) {
  return TextButton.icon(
    onPressed: () {
      if (onPressed != null) {
        onPressed();
      }
    },
    icon: Icon(
      icon,
      size: 18.0,
    ),
    style: OutlinedButton.styleFrom(
      foregroundColor: primary, // Background color
      elevation: 5, // Shadow elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(border_radius),
      ),
      side: BorderSide(
        color: primary, // Set disabled border color here
        width: 1, // Set border width here
      ),
    ),
    label: text,
  );
}

Widget buttonIcon(IconData icon,
    {Color primary = primaryColor,
    double border_radius = 5,
    Function? onPressed}) {
  return IconButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary, // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border_radius),
        ),
        side: BorderSide(
          color: primary, // Set disabled border color here
          width: 1, // Set border width here
        ),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      icon: Icon(
        icon,
        size: 18.0,
      ));
  // TextButton.icon(

  //   icon: ,
  //   style: OutlinedButton.styleFrom(
  //     foregroundColor: primary, // Background color
  //     elevation: 5, // Shadow elevation
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(border_radius),
  //     ),
  //     side: BorderSide(
  //       color: primary, // Set disabled border color here
  //       width: 1, // Set border width here
  //     ),
  //   ),
  //   label: text,
  // );
}

// Widget buttonText(String text,
//     {bool isLoading = false,
//     Color color = Colors.white,
//     double font_size = 18}) {
//   if (isLoading) {
//     return Get.loading();
//   }
//   return textH2(text,
//       font_size: font_size,
//       color: color,
//       font_weight: FontWeight.w500,
//       overflow: TextOverflow.clip);
// }

// Widget menuTile(IconData icon, String title, {Function? function}) {
//   return ListTile(
//     onTap: () {
//       if (function != null) {
//         // scaffoldKey.currentState?.openDrawer();
//         function();
//       }
//     },
//     leading: Icon(icon),
//     title: textH3(title, font_size: 14, font_weight: FontWeight.w600),
//   );
// }

// Widget customerDrawer(context, StudentModel obj) {
//   return Drawer(
//     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//     child: SingleChildScrollView(
//       child: Column(
//         // padding: EdgeInsets.zero,
//         children: <Widget>[
//           SizedBox(
//             width: double.infinity,
//             child: DrawerHeader(
//               decoration: const BoxDecoration(
//                 color: primaryColor,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   getImage(obj, width: 50),
//                   const SizedBox(height: 10),
//                   textH1(obj.name, color: Colors.white),
//                   const SizedBox(height: 3),
//                   subtext("+91 ${obj.mobile}",
//                       font_size: 14, color: Colors.white),
//                 ],
//               ),
//             ),
//           ),
//           // menuTile(Icons.home, "Home", function: () {
//           //   Get.back(context);
//           //   Get.to(context, () => HomePage(obj));
//           // }),
//           // const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.menu_book_rounded, "Management Affairs", function: () {
//             Get.back(context);
//             Get.to(context, () => ManagementAffairsPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.menu_book_rounded, "Current Affairs", function: () {
//             Get.back(context);
//             Get.to(context, () => CurrentAffairsPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.menu_book_rounded, "Judgments", function: () {
//             Get.back(context);
//             Get.to(context, () => JudgementPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.menu_book_rounded, "Acts", function: () {
//             Get.back(context);
//             Get.to(context, () => ActsPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.question_answer, "MCQ", function: () {
//             Get.back(context);
//             Get.to(context, () => MCQListPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.payment, "Fees", function: () {
//             Get.back(context);
//             Get.to(context, () => FeesPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.book, "Exams", function: () {
//             Get.back(context);
//             Get.to(context, () => ExamLinkPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.calendar_month, "Attendance", function: () {
//             Get.back(context);
//             Get.to(context, () => AttendanceReportPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           menuTile(Icons.open_in_browser, "Other Links", function: () {
//             Get.back(context);
//             Get.to(context, () => OtherLinkPage(obj));
//           }),
//           const Divider(thickness: 0.5, height: 1),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: ListTile(
//               leading: const Icon(
//                 Icons.logout,
//                 color: Colors.red,
//               ),
//               title: textH3("Logout",
//                   color: Colors.red,
//                   font_size: 15,
//                   font_weight: FontWeight.w600),
//               onTap: () {
//                 Get.logout(context);
//               },
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// Widget bottomBar(context, indexSelected, StudentModel obj) {
//   List<TabItem> items = const [
//     TabItem(
//       icon: Icons.home,
//       title: 'Home',
//     ),
//     TabItem(
//       icon: Icons.notifications,
//       title: 'Notifications',
//     ),
//     TabItem(
//       icon: Icons.post_add,
//       title: 'Feeds',
//     ),
//     TabItem(
//       icon: Icons.wallet,
//       title: 'Fees',
//     ),
//     TabItem(
//       icon: Icons.account_box,
//       title: 'ID Card',
//     ),
//   ];

//   return BottomBarInspiredOutside(
//     items: items,
//     backgroundColor: primaryColor,
//     color: whiteColor,
//     colorSelected: Colors.white,
//     indexSelected: indexSelected,
//     onTap: (int index) {
//       if (index == 0) {
//         Get.toWithNoBack(context, () => HomePage(obj, index: index));
//       } else if (index == 1) {
//         Get.toWithNoBack(context, () {
//           NoticeBoardModel notic = NoticeBoardModel();
//           notic.markAsSeenAllSeen(obj.id);
//           return NotificationPage(obj);
//         });
//       } else if (index == 2) {
//         Get.toWithNoBack(context, () => FeedsPage(obj, index: index));
//       } else if (index == 3) {
//         Get.toWithNoBack(context, () => FeesPage(obj));
//       } else if (index == 4) {
//         Get.toWithNoBack(context, () => ProfilePage(obj, index: index));
//       }
//     },
//     top: -28,
//     animated: false,
//     itemStyle: ItemStyle.circle,
//     chipStyle: const ChipStyle(
//         notchSmoothness: NotchSmoothness.smoothEdge, background: primaryColor),
//   );
// }

// Widget facultyBottomBar(context, indexSelected, StudentModel obj,
//     {Function? onTap}) {
//   List<TabItem> items = const [
//     TabItem(
//       icon: Icons.home,
//       title: 'Home',
//     ),
//     TabItem(
//       icon: Icons.edit_note,
//       title: 'Lecture',
//     ),
//     TabItem(
//       icon: Icons.post_add,
//       title: 'Feeds',
//     ),
//     TabItem(
//       icon: Icons.work_off,
//       title: 'Leave',
//     ),
//     TabItem(
//       icon: Icons.notifications,
//       title: 'Notice',
//     ),
//   ];

//   return BottomBarInspiredOutside(
//     items: items,
//     backgroundColor: primaryColor,
//     color: whiteColor,
//     colorSelected: Colors.white,
//     indexSelected: indexSelected,
//     onTap: (int index) {
//       if (index == 0) {
//         Get.toWithNoBack(context, () => FacultyHomePage(obj, index: index));
//       } else if (index == 1) {
//         if (onTap != null) {
//         } else {
//           Get.toWithNoBack(context, () => LectureOption(obj, index: 1));
//         }
//       } else if (index == 2) {
//         Get.toWithNoBack(context, () => FacultyFeedsPage(obj, index: index));
//       } else if (index == 3) {
//         Get.toWithNoBack(context, () => LeaveRequestPage(obj, index: 3));
//       } else if (index == 4) {
//         NoticeBoardModel notic = NoticeBoardModel();
//         notic.markAsSeenEmpAllSeen(obj.id).then((res) {
//           Get.back(context);
//           if (res['ok'] > 0) {
//             Get.to(context, () => FacNotificationPage(obj, index: 4));
//           } else {
//             Get.viewMessage(context, res['error']);
//           }
//         });
//         Get.toWithNoBack(context, () => FacNotificationPage(obj, index: index));
//       }
//     },
//     top: -28,
//     animated: false,
//     itemStyle: ItemStyle.circle,
//     chipStyle: const ChipStyle(
//         notchSmoothness: NotchSmoothness.smoothEdge, background: primaryColor),
//   );
// }

// Widget iconWithTextSmall(IconData icon, String text,
//     {double size = 22,
//     String? textOpt,
//     Color color = blackColor,
//     Function? function,
//     dynamic args}) {
//   return GestureDetector(
//     onTap: () {
//       if (function != null) {
//         function();
//       }
//     },
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 247, 201, 141),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           textOpt == null
//               ? Container(
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 247, 201,
//                         141), //Color.fromARGB(255, 255, 232, 201),

//                     borderRadius: BorderRadius.circular(
//                         50), // Adjust the radius as needed
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color.fromARGB(255, 247, 201, 141),
//                         spreadRadius: 1,
//                         blurRadius: 1,
//                         offset: Offset(0,
//                             0), // Adjust the vertical offset to move the shadow down
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     icon,
//                     color: primaryColor,
//                   ),
//                 )
//               : textH3(textOpt,
//                   color: color,
//                   text_align: TextAlign.center,
//                   font_size: 18,
//                   font_weight: FontWeight.bold),
//           const SizedBox(height: 5),
//           textH3(text,
//               color: Colors.black,
//               text_align: TextAlign.center,
//               font_size: 11,
//               font_weight: FontWeight.w500)
//         ],
//       ),
//     ),
//   );
// }

class ThumbsUpButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback onPressed;

  const ThumbsUpButton({
    super.key,
    required this.icon,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(icon, size: 20),
          onPressed: onPressed,
        ),
        // textH3(count.toString(), font_size: 12)
      ],
    );
  }
}

class PostProvider extends ChangeNotifier {
  List<File> dataList = [];

  void deleteData(int index) async {
    dataList.removeAt(index);
    notifyListeners();
  }

  void clearData() async {
    dataList.clear();
    notifyListeners();
  }
}
