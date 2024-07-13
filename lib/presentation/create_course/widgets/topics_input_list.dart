import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/typography.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/button/custom_button.dart';
import 'package:education_app/presentation/create_course/widgets/input_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class InputListTileItem {
  int? index;
  String text;
  InputListTileItem(
    this.index,
    this.text,
  );
}

class ReorderableInputList extends StatefulWidget {
  final void Function(List<InputListTileItem>) onFinished;
  final List<InputListTileItem> Function() onInit;
  const ReorderableInputList({
    super.key,
    required this.onFinished,
    required this.onInit,
  });

  @override
  State<ReorderableInputList> createState() => _ReorderableInputListState();
}

class _ReorderableInputListState extends State<ReorderableInputList> {
  late List<InputListTileItem> topicInputList;

  @override
  void initState() {
    super.initState();
    topicInputList = widget.onInit();
  }

  void _handleRemoveTopic(int index) {
    setState(() {
      topicInputList.removeAt(index);
    });
    widget.onFinished(topicInputList);
  }

  void _handleAddTopic() {
    setState(() {
      topicInputList.add(InputListTileItem(topicInputList.length, ''));
    });
    // Show maximum error
  }

  void _handleReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      final topicItem = topicInputList.removeAt(oldIndex);
      topicInputList.insert(newIndex, topicItem);
    });
    widget.onFinished(topicInputList);
  }

  void _handleInputChanged(int index, String value) {
    setState(() {
      topicInputList[index].text = value;
    });
    widget.onFinished(topicInputList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: topicInputList.length * 60,
          child: ReorderableListView.builder(
            itemCount: topicInputList.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            onReorder: _handleReorder,
            itemBuilder: (context, index) {
              return Container(
                key: ObjectKey(topicInputList[index]),
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: InputListTile(
                    initialValue: topicInputList[index].text,
                    onTrailingPressed: () {
                      _handleRemoveTopic(index);
                    },
                    onChanged: (value) {
                      _handleInputChanged(index, value);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        CustomButton(
          style: CustomButtonStyle.secondaryBlue,
          onPressed: _handleAddTopic,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeroIcon(
                HeroIcons.plus,
                style: HeroIconStyle.mini,
                size: 20,
                color: CustomColors.primaryBlue,
              ),
              6.kW,
              Text(
                "Add more",
                style: CustomFonts.labelMedium.copyWith(
                  color: CustomColors.primaryBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
