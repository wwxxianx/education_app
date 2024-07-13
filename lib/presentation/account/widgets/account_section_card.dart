import 'package:flutter/material.dart';

class AccountSectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const AccountSectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.only(
      left: 16.0,
      right: 12.0,
      top: 18.0,
      bottom: 12.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white,
          border: Border.all(
            color: Color(0xFFF5F5F5),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              offset: Offset(0, 1),
              color: Colors.black.withOpacity(0.08),
            ),
            BoxShadow(
              blurRadius: 2.0,
              offset: Offset(0, 1),
              color: Colors.black.withOpacity(0.12),
            ),
          ]),
      child: child,
    );
  }
}