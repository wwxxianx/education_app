import 'package:education_app/common/theme/color.dart';
import 'package:flutter/material.dart';

class OnboardingProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalStep;
  const OnboardingProgressBar({
    super.key,
    required this.currentStep,
    required this.totalStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          totalStep,
          (index) => Flexible(
            flex: 1,
            child: Stack(
              children: [
                Container(
                  margin: index != totalStep - 1
                      ? const EdgeInsets.only(right: 8)
                      : null,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: const Color.fromARGB(255, 224, 224, 224),
                  ),
                ),
                AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 500),
                  widthFactor: currentStep >= index ? 1 : 0,
                  child: Container(
                    margin: index != totalStep - 1
                        ? const EdgeInsets.only(right: 8)
                        : null,
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        CustomColors.primaryBlue,
                        Color(0xFF997BEF),
                      ]),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
