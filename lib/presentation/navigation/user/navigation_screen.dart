import 'package:education_app/presentation/navigation/user/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class UserNavigationScreen extends StatefulWidget {
  final Widget child;
  const UserNavigationScreen({
    super.key,
    required this.child,
  });

  @override
  State<UserNavigationScreen> createState() => _UserNavigationScreenState();
}

class _UserNavigationScreenState extends State<UserNavigationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:const  HomeBottomNavigationBar(),
        body: widget.child,
      ),
    );
  }
}
