import 'package:education_app/common/widgets/media/auto_play_visible_video_player.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/domain/model/course/enum/course_enum.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_bloc.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLearningDetailsAppBar extends StatefulWidget {
  final ScrollController scrollController;
  const MyLearningDetailsAppBar({super.key, required this.scrollController});

  @override
  State<MyLearningDetailsAppBar> createState() =>
      _MyLearningDetailsAppBarState();
}

class _MyLearningDetailsAppBarState extends State<MyLearningDetailsAppBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _positionAnimation =
        Tween<Offset>(begin: const Offset(0, 30), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _scrollListener() {
    final scrollOffset = widget.scrollController.offset;
    final animationValue = (scrollOffset / 380).clamp(0.0, 1.0);
    _animationController.value = animationValue;
  }

  Widget _buildContent(CoursePart? currentPart) {
    if (currentPart == null) {
      return const Text("NULL");
    }
    switch (currentPart.resource.mimeTypeEnum) {
      case CourseResourceMimeType.DOCUMENT:
      case CourseResourceMimeType.TEXT:
        return const Text("DOCUMENT");
      case CourseResourceMimeType.VIDEO:
        return AutoPlayVisibleVideoPlayer(
          videoUrl: currentPart.resource.url,
          isInteractive: true,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF384d60),
      expandedHeight: MediaQuery.of(context).size.height / 3,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.translate(
                offset: _positionAnimation.value,
                child: Text("React JS Crash Course"),
              ),
            );
          },
        ),
        background: BlocBuilder<MyLearningDetailsBloc, MyLearningDetailsState>(
          builder: (context, state) {
            final currentPart = state.currentPart;
            return _buildContent(currentPart);
          },
        ),
      ),
    );
  }
}
