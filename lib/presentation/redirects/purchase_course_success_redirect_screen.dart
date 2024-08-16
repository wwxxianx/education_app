import 'package:education_app/presentation/my_learning/my_learning_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PurchaseCourseSuccessRedirectScreen extends StatefulWidget {
  static const route = '/purchase-success-redirect';
  const PurchaseCourseSuccessRedirectScreen({super.key});

  @override
  State<PurchaseCourseSuccessRedirectScreen> createState() => _PurchaseCourseSuccessRedirectScreenState();
}

class _PurchaseCourseSuccessRedirectScreenState extends State<PurchaseCourseSuccessRedirectScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      context.go(MyLearningScreen.route);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}