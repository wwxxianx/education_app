import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/input/outlined_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';

class InputListTile extends StatefulWidget {
  final String? initialValue;
  final void Function(String)? onChanged;
  final Widget? leading;
  final VoidCallback? onTrailingPressed;
  const InputListTile({
    super.key,
    this.onChanged,
    this.leading,
    this.onTrailingPressed,
    this.initialValue,
  });

  @override
  State<InputListTile> createState() => _InputListTileState();
}

class _InputListTileState extends State<InputListTile> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.leading != null) widget.leading!,
        if (widget.leading != null) 4.kW,
        Flexible(
          child: CustomOutlinedTextfield(
            key: widget.key,
            initialValue: widget.initialValue,
            // controller: textController,
            onChanged: widget.onChanged,
          ),
        ),
        IconButton(
          onPressed: widget.onTrailingPressed,
          icon: const HeroIcon(
            HeroIcons.trash,
            size: 20,
            color: CustomColors.alert,
          ),
        ),
        SvgPicture.asset(
          'assets/icons/drag.svg',
          color: Colors.black45,
          width: 20,
          height: 20,
        ),
      ],
    );
  }
}
