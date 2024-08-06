import 'package:education_app/presentation/instructor_subscription/instructor_subscription_screen.dart';
import 'package:education_app/presentation/my_course/my_course_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class InstructorBottomNavigationBar extends StatefulWidget {
  const InstructorBottomNavigationBar({super.key});

  @override
  State<InstructorBottomNavigationBar> createState() =>
      _InstructorBottomNavigationBarState();
}

class _InstructorBottomNavigationBarState
    extends State<InstructorBottomNavigationBar> {
  var logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  static int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(MyCourseScreen.route)) {
      return 0;
    }
    if (location.startsWith("/bank")) {
      return 1;
    }
    if (location.startsWith(InstructorSubscriptionScreen.route)) {
      return 2;
    }
    if (location.startsWith("/my-instructor-profile")) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(MyCourseScreen.route);
      case 1:
        GoRouter.of(context).go("/bank");
      case 2:
        GoRouter.of(context).go(InstructorSubscriptionScreen.route);
      case 3:
        GoRouter.of(context).go("/my-instructor-profile");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 12.0,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/blackboard.svg"),
          activeIcon: SvgPicture.asset("assets/icons/blackboard-active.svg"),
          label: "My Course",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/credit-card.svg"),
          activeIcon: SvgPicture.asset("assets/icons/credit-card-filled.svg"),
          label: "Bank",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/bill.svg"),
          activeIcon: SvgPicture.asset("assets/icons/bill-filled.svg"),
          label: "Subscription",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/user-circle.svg"),
          activeIcon: SvgPicture.asset("assets/icons/user-circle-active.svg"),
          label: "Profile",
        ),
      ],
      currentIndex: _getCurrentIndex(context),
      onTap: (value) {
        _onItemTapped(value, context);
      },
    );
  }
}
