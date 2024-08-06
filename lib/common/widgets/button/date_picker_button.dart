import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

/// Flutter code sample for [showDatePicker].

class DatePickerButton extends StatefulWidget {
  final String? placeholder;
  final String? restorationId;
  final void Function(DateTime selectedDateTime)? onSelected;
  const DatePickerButton({
    super.key,
    this.restorationId,
    this.placeholder,
    this.onSelected,
  });

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerButtonState extends State<DatePickerButton>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  RestorableDateTimeN _selectedDate = RestorableDateTimeN(null);
  // RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _handleSelectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value?.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments != null
              ? arguments as int
              : DateTime.now().millisecondsSinceEpoch),
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _handleSelectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        if (widget.onSelected != null) {
          widget.onSelected!(newSelectedDate);
        }
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        // ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          height: 40,
          style: CustomButtonStyle.secondaryBlue,
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          child: Row(
            children: [
              const HeroIcon(
                HeroIcons.calendar,
                size: 20,
                color: CustomColors.slate700,
              ),
              6.kW,
              Text(_selectedDate.value != null
                  ? '${_selectedDate.value?.day}/${_selectedDate.value?.month}/${_selectedDate.value?.year}'
                  : widget.placeholder ?? 'Pick a date'),
            ],
          ),
        ),
      ],
    );
  }
}
