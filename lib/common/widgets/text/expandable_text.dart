import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

bool hasTextOverflow(
  String text,
  TextStyle? style, {
  double textScaleFactor = 1.0,
  double minWidth = 0,
  double maxWidth = double.maxFinite,
  int maxLines = 2,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
    textScaleFactor: textScaleFactor,
  )..layout(minWidth: minWidth, maxWidth: maxWidth);
  return textPainter.didExceedMaxLines;
}

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  const ExpandableText({
    super.key,
    required this.text,
    required this.maxLines,
    this.style = CustomFonts.bodyMedium,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;
  void _handleExpandToggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.maxLines,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
          style: widget.style,
        ),
        if (hasTextOverflow(widget.text, widget.style,
            maxWidth: MediaQuery.of(context).size.width))
          InkWell(
            onTap: _handleExpandToggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isExpanded ? "See less" : "See more",
                  style: CustomFonts.labelMedium,
                ),
                HeroIcon(
                  isExpanded ? HeroIcons.chevronUp : HeroIcons.chevronDown,
                  size: 16,
                )
              ],
            ),
          ),
        // 50.kH
      ],
    );
  }
}
