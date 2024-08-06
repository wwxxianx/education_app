import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/presentation/login/login_screen.dart';
import 'package:education_app/presentation/sign_up/widgets/sign_up_form.dart';
import 'package:education_app/state_management/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  static const route = '/sign-up';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        signOut: serviceLocator(),
        signUp: serviceLocator(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFDDF2FE),
                Colors.white,
                Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.only(
              left: Dimensions.screenHorizontalPadding,
              right: Dimensions.screenHorizontalPadding,
              top: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Register",
                  style: CustomFonts.titleExtraLarge,
                ),
                24.kH,
                const SignUpForm(),
                24.kH,
                Row(
                  children: [
                    const Text(
                      "Already have an account?",
                      style: CustomFonts.labelMedium,
                    ),
                    InkWell(
                      onTap: () {
                        context.go(LoginScreen.route);
                      },
                      child: Ink(
                        child: Text(
                          "Sign in now",
                          style: CustomFonts.labelMedium.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
