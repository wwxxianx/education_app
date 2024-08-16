import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/utils/input_validator.dart';
import 'package:education_app/common/utils/show_snackbar.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:education_app/presentation/explore/explore_screen.dart';
import 'package:education_app/presentation/onboarding/onboarding_screen.dart';
import 'package:education_app/state_management/app_user_cubit.dart';
import 'package:education_app/state_management/login/login_bloc.dart';
import 'package:education_app/state_management/login/login_event.dart';
import 'package:education_app/state_management/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:logger/logger.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with InputValidator {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  void _handleLoginSubmit() {
    if (_formKey.currentState!.validate()) {
      final appUserCubit = context.read<AppUserCubit>();
      context.read<LoginBloc>().add(OnLogin(
            email: _emailController.text,
            password: _passwordController.text,
            onSuccess: (user) {
              appUserCubit.updateUser(user);
              if (user.isOnboardingCompleted) {
                context.go(ExploreScreen.route);
                return;
              }
              context.go(OnboardingScreen.route);
            },
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomOutlinedTextfield(
                focusNode: _focusNode,
                label: "Email",
                hintText: "email@gmail.com",
                controller: _emailController,
                validator: (value) => validateEmail(value),
                prefixIcon: const HeroIcon(
                  HeroIcons.envelope,
                  size: 20.0,
                ),
                textInputAction: TextInputAction.next,
              ),
              16.kH,
              CustomOutlinedTextfield(
                label: "Password",
                hintText: "********",
                controller: _passwordController,
                isObscureText: true,
                prefixIcon: const HeroIcon(
                  HeroIcons.lockClosed,
                  size: 20.0,
                ),
                onFieldSubmitted: (p0) {
                  _handleLoginSubmit();
                },
              ),
              20.kH,
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  isLoading: state is LoginLoading,
                  enabled: state is! LoginLoading,
                  onPressed: _handleLoginSubmit,
                  child: const Text("Login"),
                ),
              ),
              24.kH,
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      indent: 0,
                      endIndent: 8,
                      color: CustomColors.divider,
                    ),
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFB0B0B0),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      indent: 8,
                      endIndent: 0,
                      color: CustomColors.divider,
                    ),
                  ),
                ],
              ),
              24.kH,
              SizedBox(
                width: double.maxFinite,
                child: CustomButton(
                  style: CustomButtonStyle.white,
                  onPressed: () {
                    final state = context.read<AppUserCubit>().state;
                    var logger = Logger();
                    logger.w(state);
                    if (state.currentUser != null) {
                      logger.w(state.currentUser!.isOnboardingCompleted);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google-logo.png",
                        height: 20.0,
                        width: 20.0,
                        fit: BoxFit.cover,
                      ),
                      10.kW,
                      Text("Continue with Google")
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
