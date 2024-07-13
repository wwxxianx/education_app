import 'package:education_app/presentation/account/account_screen.dart';
import 'package:education_app/presentation/explore/explore_screen.dart';
import 'package:education_app/presentation/my_course/my_course_screen.dart';
import 'package:education_app/presentation/my_learning/my_learning_screen.dart';
import 'package:education_app/presentation/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  State<HomeBottomNavigationBar> createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  var logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  static int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(ExploreScreen.route)) {
      return 0;
    }
    if (location.startsWith(SearchScreen.route)) {
      return 1;
    }
    if (location.startsWith(MyLearningScreen.route)) {
      return 2;
    }
    if (location.startsWith(AccountScreen.route)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(ExploreScreen.route);
      case 1:
        GoRouter.of(context).go(SearchScreen.route);
      case 2:
        GoRouter.of(context).go(MyLearningScreen.route);
      case 3:
        GoRouter.of(context).go(AccountScreen.route);
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
          icon: SvgPicture.asset("assets/icons/globe.svg"),
          activeIcon: SvgPicture.asset("assets/icons/globe-active.svg"),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          activeIcon: SvgPicture.asset("assets/icons/search-active.svg"),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/academic-cap.svg"),
          activeIcon: SvgPicture.asset("assets/icons/academic-cap-active.svg"),
          label: "My Learning",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/user-circle.svg"),
          activeIcon: SvgPicture.asset("assets/icons/user-circle-active.svg"),
          label: "Account",
        ),
      ],
      currentIndex: _getCurrentIndex(context),
      onTap: (value) {
        _onItemTapped(value, context);
      },
    );
  }
}
