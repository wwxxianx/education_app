import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/presentation/login/widgets/login_form.dart';
import 'package:education_app/presentation/sign_up/sign_up_screen.dart';
import 'package:education_app/state_management/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(login: serviceLocator()),
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
                  "Login",
                  style: CustomFonts.titleExtraLarge,
                ),
                24.kH,
                const LoginForm(),
                24.kH,
                Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: CustomFonts.labelMedium,
                    ),
                    InkWell(
                      onTap: () {
                        context.go(SignUpScreen.route);
                      },
                      child: Ink(
                        child: Text(
                          "Sign up now",
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
