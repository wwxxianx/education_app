import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/utils/extensions/sized_box_extension.dart';
import 'package:education_app/common/widgets/media/auto_play_visible_video_player.dart';
import 'package:education_app/common/widgets/media/gallery_photo_viewer.dart';
import 'package:education_app/domain/model/image/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

class MediaCarousel extends StatefulWidget {
  final double? height;
  final double? width;
  final List<ImageModel> images;
  final List<String> videoUrls;
  const MediaCarousel({
    super.key,
    this.height,
    this.width,
    required this.images,
    this.videoUrls = const [],
  });

  @override
  State<MediaCarousel> createState() => _MediaCarouselState();
}

class _MediaCarouselState extends State<MediaCarousel> {
  late PageController _pageViewController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  void _handlePageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _handleExpandImage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: widget.images,
          backgroundDecoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.width ?? MediaQuery.of(context).size.width,
          height: widget.height ?? MediaQuery.of(context).size.height / 2.45,
          child: PageView(
            controller: _pageViewController,
            onPageChanged: _handlePageChange,
            children: [
              if (widget.videoUrls.isNotEmpty)
                ...widget.videoUrls.map((url) {
                  return AutoPlayVisibleVideoPlayer(
                    videoUrl: url,
                    isInteractive: true,
                  );
                }).toList(),
              ...widget.images.mapWithIndex((image, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: image.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          _handleExpandImage(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black.withOpacity(0.4),
                            border: Border.all(
                              color: const Color(0xFFD2CFCF),
                              width: 1,
                            ),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/expand.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
        8.kH,
        // Indicator
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            (widget.images.length + widget.videoUrls.length),
            (index) => Container(
              margin: const EdgeInsets.only(right: 4.0),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                border: Border.all(
                    color: _currentPage == index
                        ? Colors.black
                        : Colors.transparent),
                color: _currentPage == index
                    ? CustomColors.primaryBlue
                    : const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
