import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/common/widgets/container/custom_bottom_sheet.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/state_management/bank_account/connected_bank_account_bloc.dart';
import 'package:education_app/state_management/bank_account/connected_bank_account_event.dart';
import 'package:education_app/state_management/bank_account/connected_bank_account_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupBankAccountBottomSheet extends StatelessWidget {
  const SetupBankAccountBottomSheet({super.key});

  void _handleConnectAccount(BuildContext context) {
    context
        .read<BankAccountBloc>()
        .add(OnUpdateConnectAccount(onSuccess: (onboardLink) async {
      final url = Uri.parse(onboardLink);
      if (!await launchUrl(url)) {
        toastification.show(
          type: ToastificationType.error,
          title: Text(
            "Failed to connect to Stripe",
            style: CustomFonts.labelSmall,
          ),
          description: Text(
            "Please try again later.",
            style: CustomFonts.bodySmall,
          ),
        );
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return CustomDraggableSheet(
      initialChildSize: 0.9,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.screenHorizontalPadding),
        child: BlocBuilder<BankAccountBloc, BankAccountState>(
          builder: (context, state) {
            return Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/bank-transfer.svg'),
                        4.kW,
                        const Text(
                          "Setup Your Back Account",
                          style: CustomFonts.labelSmall,
                        ),
                      ],
                    ),
                    6.kH,
                    const Text(
                      'Before you receive any donation, please set up a valid bank account in order to receive donation.',
                      style: CustomFonts.bodySmall,
                    )
                  ],
                ),
                20.kH,
                SvgPicture.asset(
                    'assets/images/setup-stripe-connect-account.svg'),
                30.kH,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        isLoading: state.updateStripeConnectAccountResult is ApiResultLoading,
                        enabled: state.updateStripeConnectAccountResult is! ApiResultLoading,
                        onPressed: () {
                          _handleConnectAccount(context);
                        },
                        child: Text('Setup my bank account'),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
