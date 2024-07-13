import 'package:education_app/presentation/navigation/instructor/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class InstructorNavigationScreen extends StatefulWidget {
  final Widget child;
  const InstructorNavigationScreen({
    super.key,
    required this.child,
  });

  @override
  State<InstructorNavigationScreen> createState() => _InstructorNavigationScreenState();
}

class _InstructorNavigationScreenState extends State<InstructorNavigationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const InstructorBottomNavigationBar(),
        body: widget.child,
      ),
    );
  }
}
