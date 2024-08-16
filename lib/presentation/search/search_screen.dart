import 'package:badges/badges.dart' as badges;
import 'package:education_app/common/theme/app_theme.dart';
import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/theme/dimension.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/badge/custom_badge.dart';
import 'package:education_app/common/widgets/button/custom_outlined_icon_button.dart';
import 'package:education_app/common/widgets/container/scaffold_mask.dart';
import 'package:education_app/common/widgets/course/course_list_tile.dart';
import 'package:education_app/data/network/api_result.dart';
import 'package:education_app/domain/model/course/course.dart';
import 'package:education_app/presentation/search/widgets/animated_search_bar.dart';
import 'package:education_app/presentation/search/widgets/animated_search_result_container.dart';
import 'package:education_app/presentation/search/widgets/filter_bottom_sheet.dart';
import 'package:education_app/state_management/search/search_course_bloc.dart';
import 'package:education_app/state_management/search/search_course_event.dart';
import 'package:education_app/state_management/search/search_course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:heroicons/heroicons.dart';

class SearchScreen extends StatefulWidget {
  static const String route = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _searchResultContainerController;
  late Animation<double> _searchResultContainerAnimation;
  final _searchTextController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchResultContainerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _searchResultContainerAnimation = CurvedAnimation(
        parent: _searchResultContainerController, curve: Curves.fastOutSlowIn);
    final bloc = context.read<SearchCourseBloc>();
    final coursesResult = bloc.state.coursesResult;
    if (coursesResult is! ApiResultSuccess<List<Course>>) {
      bloc.add(OnFetchCourses());
    }
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) async {
    //     final giftCardBloc = context.read<GiftCardBloc>();
    //     if (giftCardBloc.state.shouldShowGiftCardDialog) {
    //       context.displayDialog(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text("testing"),
    //           ],
    //         ),
    //         onClose: () {
    //           giftCardBloc.add(OnCloseDialog());
    //         },
    //       );
    //     }
    //   },
    // );
  }

  void _showSearchResultContainer() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _searchResultContainerController.forward();
    });
    setState(() {
      isSearching = true;
    });
  }

  void _hideSearchResultContainer() {
    _searchResultContainerController.reverse();
    setState(() {
      isSearching = false;
    });
  }

  void _handleSearch(BuildContext context, String value) {
    context.read<SearchCourseBloc>()
      ..add(OnSearchQueryChanged(searchQuery: value))
      ..add(OnFetchCourses());
    _hideSearchResultContainer();
  }

  Widget _buildCourseContentLayout(SearchCourseState state) {
    final coursesResult = state.coursesResult;
    if (coursesResult is ApiResultSuccess<List<Course>>) {
      if (coursesResult.data.isNotEmpty) {
        return AnimationLimiter(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: coursesResult.data.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                delay: const Duration(milliseconds: 200),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      // child: CampaignCard(
                      //   campaign: coursesResult.data[index],
                      //   onPressed: () {
                      //     context.push(CampaignDetailsScreen.generateRoute(
                      //         campaignId: coursesResult.data[index].id));
                      //   },
                      // ),
                      child: CourseListTile(
                        course: coursesResult.data[index],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
      return Text("Can't find any campaigns. Please try again");
    }

    if (coursesResult is ApiResultFailure) {
      return Text("Something went wrong...");
    }
    // Loading
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.screenHorizontalPadding,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          delay: const Duration(milliseconds: 200),
          child: const SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                // child: CampaignLoadingCard(),
                child: SizedBox(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme.copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      child: BlocBuilder<SearchCourseBloc, SearchCourseState>(
        builder: (context, state) {
          final isFilterEmpty = state.filterLength < 1;
          return Scaffold(
            bottomSheet: Container(
              margin: const EdgeInsets.only(bottom: 8.0, right: 16.0),
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // Filter button
                      CustomBadge(
                        badgeText: "${state.filterLength}",
                        showBadge: state.filterLength > 0,
                        position: badges.BadgePosition.topEnd(
                            end: isFilterEmpty ? 60 : 66),
                        child: Container(
                          margin:
                              EdgeInsets.only(right: isFilterEmpty ? 68 : 74),
                          child: CustomOutlinedIconButton(
                            border: Border.all(
                              color: CustomColors.containerBorderBlue,
                              width: 1.5,
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                isDismissible: true,
                                isScrollControlled: true,
                                elevation: 0,
                                context: context,
                                builder: (BuildContext ctx) {
                                  return BlocProvider.value(
                                    value: BlocProvider.of<SearchCourseBloc>(
                                        context),
                                    child: const CourseFilterBottomSheet(),
                                  );
                                },
                              );
                            },
                            icon: const HeroIcon(
                              HeroIcons.adjustmentsHorizontal,
                              size: 35.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isSearching)
                            AnimatedSearchResultContainer(
                              scaleAnimation: _searchResultContainerAnimation,
                            ),
                          12.kH,
                          CustomBadge(
                            showBadge: state.searchQuery != null &&
                                state.searchQuery!.isNotEmpty,
                            badgeText: "1",
                            child: AnimatedSearchBar(
                              autoFocus: true,
                              textInputAction: TextInputAction.search,
                              textController: _searchTextController,
                              width: MediaQuery.of(context).size.width -
                                  Dimensions.screenHorizontalPadding,
                              onSubmitted: (string) {
                                _handleSearch(context, string);
                              },
                              onSuffixTap: () {
                                _hideSearchResultContainer();
                              },
                              searchBarOpen: (integer) {
                                _showSearchResultContainer();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCourseContentLayout(state),
                    ],
                  ),
                ),
                if (isSearching) const ScaffoldMask()
              ],
            ),
          );
        },
      ),
    );
  }
}
