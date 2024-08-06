import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/domain/model/stripe/stripe_account.dart';
import 'package:education_app/presentation/bank_account/widgets/setup_bank_account_bottom_sheet.dart';
import 'package:education_app/state_management/bank_account/connected_bank_account_bloc.dart';
import 'package:education_app/state_management/bank_account/connected_bank_account_event.dart';
import 'package:education_app/state_management/bank_account/connected_bank_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectedBankAccountScreen extends StatelessWidget {
  const ConnectedBankAccountScreen({
    super.key,
  });

  void _showConnectAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      isDismissible: true,
      context: context,
      builder: (modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<BankAccountBloc>(context),
          child: SetupBankAccountBottomSheet(),
        );
      },
    );
  }

  Widget _buildNoAccountCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: CustomColors.red100, borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/x-circle-outlined.svg'),
              6.kW,
              Text(
                'No Account',
                style: CustomFonts.labelMedium,
              )
            ],
          ),
          6.kH,
          Text(
            "You haven’t connect any bank account to your campaign.",
            style: CustomFonts.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildNotCompletedCard(StripeAccount stripeAccount) {
    List<String> errorList =
        stripeAccount.requirements?.errors?.isNotEmpty == true
            ? stripeAccount.requirements!.errors!
                .map((e) => e.reason ?? 'Infomation required')
                .toList()
            : [''];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: CustomColors.amber100, borderRadius: BorderRadius.circular(6)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/checklist.svg'),
              6.kW,
              Text(
                'Information Not Completed',
                style: CustomFonts.labelMedium,
              )
            ],
          ),
          6.kH,
          if (errorList.isNotEmpty)
            ...errorList.map((error) {
              return Text(
                error,
                style: CustomFonts.bodySmall,
              );
            }).toList(),
          if (errorList.isEmpty)
            Text(
              "Your bank account information is not completed.",
              style: CustomFonts.bodySmall,
            ),
        ],
      ),
    );
  }

  Widget _buildVerifiedCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: CustomColors.containerLightGreen,
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/shield-check-filled.svg'),
              6.kW,
              Text(
                'Verified and Completed',
                style: CustomFonts.labelMedium,
              )
            ],
          ),
          6.kH,
          Text(
            "Your bank account is verified and ready to collect funds.",
            style: CustomFonts.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final stripeAccountResult =
        context.read<BankAccountBloc>().state.stripeAccountResult;
    final state = context.read<BankAccountBloc>().state;
    // No Account
    if (state.isAccountNull) {
      // No account
      return Column(
        children: [
          const Text(
            'Connected Stripe Bank Account Status:',
            style: CustomFonts.labelMedium,
          ),
          8.kH,
          _buildNoAccountCard(),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    _showConnectAccountBottomSheet(context);
                  },
                  child: const Text("Set up my bank account"),
                ),
              ),
            ],
          )
        ],
      );
    }
    if (stripeAccountResult is ApiResultSuccess<StripeAccount>) {
      // Incomplete account
      if (!stripeAccountResult.data.detailsSubmitted ||
          !stripeAccountResult.data.payoutsEnabled) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Connected Stripe Bank Account Status:',
              style: CustomFonts.labelMedium,
            ),
            8.kH,
            _buildNotCompletedCard(stripeAccountResult.data),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      context.read<BankAccountBloc>().add(
                        OnUpdateConnectAccount(
                          onSuccess: (onboardLink) async {
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
                          },
                        ),
                      );
                    },
                    child: Text("Finish set up my bank account"),
                  ),
                ),
              ],
            ),
          ],
        );
      }
      // Verified
      return Column(
        children: [
          const Text(
            'Connected Stripe Bank Account Status:',
            style: CustomFonts.labelMedium,
          ),
          8.kH,
          _buildVerifiedCard(),
        ],
      );
    }
    // Loading
    return Column(
      children: [
        Text('Loading...'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return BankAccountBloc(
          fetchConnectedAccount: serviceLocator(),
          updateConnectAccount: serviceLocator(),
        )..add(OnFetchConnectedAccount());
      },
      child: BlocBuilder<BankAccountBloc, BankAccountState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/bank-transfer.svg'),
                  4.kW,
                  const Text(
                    'Connected Bank Account',
                    style: CustomFonts.labelMedium,
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.screenHorizontalPadding,
                right: Dimensions.screenHorizontalPadding,
                bottom: Dimensions.screenHorizontalPadding,
              ),
              child: _buildContent(context),
            ),
          );
        },
      ),
    );
  }
}
