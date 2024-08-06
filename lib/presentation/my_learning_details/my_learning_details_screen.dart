import 'package:education_app/di/init_dependencies.dart';
import 'package:education_app/presentation/my_learning_details/tabs/curriculum_tab_content.dart';
import 'package:education_app/presentation/my_learning_details/widgets/my_learning_details_app_bar.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_bloc.dart';
import 'package:education_app/state_management/my_learning_details/my_learning_details_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLearningDetailsScreen extends StatefulWidget {
  final String courseId;
  const MyLearningDetailsScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<MyLearningDetailsScreen> createState() =>
      _MyLearningDetailsScreenState();
}

class _MyLearningDetailsScreenState extends State<MyLearningDetailsScreen>
    with TickerProviderStateMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return MyLearningDetailsBloc(fetchCourse: serviceLocator())
              ..add(OnFetchCourse(courseId: widget.courseId));
          },
        )
      ],
      child: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          body: SafeArea(
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  MyLearningDetailsAppBar(
                    scrollController: _scrollController,
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: "Curriculum"),
                          Tab(text: "More"),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  LearningDetailsCurriculumTabContent(),
                  Text("More"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
