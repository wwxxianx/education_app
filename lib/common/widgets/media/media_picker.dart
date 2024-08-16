import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_app/common/theme/color.dart';
import 'package:education_app/common/utils/show_snackbar.dart';
import 'package:education_app/domain/model/image/image_model.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart' as videoPlayer;
// import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnail extends StatefulWidget {
  final File videoFile;
  const VideoThumbnail({
    super.key,
    required this.videoFile,
  });

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late videoPlayer.VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = videoPlayer.VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 84,
        height: 84,
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: videoPlayer.VideoPlayer(_controller),
              )
            : Container());
  }
}

class MediaPicker extends StatefulWidget {
  final bool isVideo;
  // Determine whether is multiple, and use to discard extra image
  final int limit;
  final void Function(List<File>)? onSelected;
  final List<File>? preview;
  final List<ImageModel> previewImageModels;
  final List<String> previewImageUrls;
  final void Function(ImageModel image)? onRemovePreviewImageModel;
  final void Function(String imageUrl)? onRemovePreviewImageUrl;
  final bool canRemove;

  const MediaPicker({
    super.key,
    this.isVideo = false,
    this.limit = 1,
    this.onSelected,
    this.preview,
    this.previewImageModels = const [],
    this.previewImageUrls = const [],
    this.onRemovePreviewImageModel,
    this.onRemovePreviewImageUrl,
    this.canRemove = true,
  });

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState<T> extends State<MediaPicker> {
  final picker = ImagePicker();
  List<File> selectedImages = [];
  File? videoThumbnail;
  List<String> previewImageUrls = [];

  @override
  void initState() {
    super.initState();
    if (widget.preview != null && widget.preview!.isNotEmpty) {
      selectedImages = widget.preview!;
    }
    if (widget.previewImageUrls.isNotEmpty) {
      previewImageUrls = widget.previewImageUrls;
    }
  }

  void _handlePickButtonPressed() async {
    final hasExceedLimit = (widget.previewImageModels.length +
            selectedImages.length +
            widget.previewImageUrls.length) >=
        widget.limit;
    if (hasExceedLimit) {
      context.showSnackBar(
          "You can only select ${widget.limit} ${widget.isVideo ? 'video' : 'image'}${widget.limit > 1 ? 's' : ''}");
      return;
    }
    if (!widget.isVideo) {
      if (widget.limit == 1) {
        // Single image
        XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          final imageFile = File(image.path);
          setState(() {
            selectedImages.add(imageFile);
            if (widget.onSelected != null) {
              widget.onSelected!([imageFile]);
            }
          });
        }
      } else {
        // Pick multiple image
        List<XFile> images = await picker.pickMultiImage();
        if (images.isNotEmpty) {
          // NOTE: The extra picked image from gallery will be discarded
          // Preview ImageModel need to delete manually and won't be auto discarded
          if ((images.length + widget.previewImageModels.length) >
              widget.limit) {
            images = images.sublist(images.length -
                (widget.limit - widget.previewImageModels.length));
          }
          if (images.length + selectedImages.length <= widget.limit) {
            // Enough space, append all selected image
            setState(() {
              selectedImages.addAll(images.map((e) => File(e.path)));
              if (widget.onSelected != null) {
                widget.onSelected!(selectedImages);
              }
            });
          } else {
            setState(() {
              selectedImages = images.map((e) => File(e.path)).toList();
              if (widget.onSelected != null) {
                widget.onSelected!(selectedImages);
              }
            });
          }
        }
      }
    } else {
      // Pick video
      XFile? video = await picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        final videoFile = File(video.path);
        setState(
          () {
            selectedImages.add(videoFile);
          },
        );
        if (widget.onSelected != null) {
          widget.onSelected!([videoFile]);
        }
      }
    }
  }

  List<Widget> _buildPreview() {
    if (widget.previewImageModels.isNotEmpty) {
      return widget.previewImageModels.map((image) {
        return ImagePreviewContainer(
          canRemove: widget.canRemove,
          onRemove: () {
            if (widget.onRemovePreviewImageModel != null) {
              widget.onRemovePreviewImageModel!(image);
            }
          },
          imageUrl: image.imageUrl,
        );
      }).toList();
    }

    if (previewImageUrls.isNotEmpty) {
      return previewImageUrls.map((imageUrl) {
        return ImagePreviewContainer(
          canRemove: widget.canRemove,
          onRemove: () {
            setState(() {
              previewImageUrls.remove(imageUrl);
            });
          },
          imageUrl: imageUrl,
        );
      }).toList();
    }
    return [const SizedBox()];
  }

  List<Widget> _buildContent() {
    if (selectedImages.isNotEmpty) {
      if (widget.isVideo) {
        return [
          VideoPreviewContainer(
            child: VideoThumbnail(videoFile: selectedImages[0]),
            onRemove: () {
              setState(() {
                selectedImages = [];
              });
            },
          ),
        ];
      }
      if (widget.limit == 1) {
        return [
          ImagePreviewContainer(
              canRemove: widget.canRemove,
              onRemove: () {
                setState(() {
                  selectedImages = [];
                });
              },
              file: selectedImages[0]),
        ];
      } else {
        // multiple images
        return selectedImages.map((image) {
          return ImagePreviewContainer(
              canRemove: widget.canRemove,
              onRemove: () {
                setState(() {
                  selectedImages.remove(image);
                });
              },
              file: image);
        }).toList();
      }
    } else {
      return [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CustomColors.containerBorderGrey,
              width: 1,
            ),
          ),
          child: HeroIcon(
            widget.isVideo ? HeroIcons.videoCamera : HeroIcons.photo,
            style: HeroIconStyle.solid,
            size: 38,
            color: CustomColors.containerBorderGrey,
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      direction: Axis.horizontal,
      children: [
        if (widget.previewImageModels.isNotEmpty ||
            widget.previewImageUrls.isNotEmpty)
          ..._buildPreview(),
        ..._buildContent(),
        InkWell(
          onTap: _handlePickButtonPressed,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CustomColors.containerBorderGrey,
                width: 1,
              ),
            ),
            child: const HeroIcon(
              HeroIcons.plus,
              style: HeroIconStyle.solid,
              size: 38,
              color: CustomColors.containerBorderGrey,
            ),
          ),
        ),
      ],
    );
  }
}

class VideoPreviewContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onRemove;
  const VideoPreviewContainer({
    super.key,
    required this.child,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CustomColors.containerBorderGrey,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: child,
          ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Color(0xFFFEFEFE)),
                boxShadow: CustomColors.cardShadow,
              ),
              padding: const EdgeInsets.all(4.0),
              child: const HeroIcon(
                HeroIcons.xMark,
                style: HeroIconStyle.mini,
                color: Color(0xFFAEAEAE),
                size: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImagePreviewContainer extends StatelessWidget {
  final bool canRemove;
  final String? imageUrl;
  final File? file;
  final VoidCallback onRemove;
  const ImagePreviewContainer({
    super.key,
    this.imageUrl,
    required this.onRemove,
    this.file,
    this.canRemove = true,
  });

  Widget _buildImage() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      file!,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CustomColors.containerBorderGrey,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: _buildImage(),
          ),
        ),
        if (canRemove)
          Positioned(
            right: -5,
            top: -5,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFFEFEFE)),
                  boxShadow: CustomColors.cardShadow,
                ),
                padding: const EdgeInsets.all(4.0),
                child: const HeroIcon(
                  HeroIcons.xMark,
                  style: HeroIconStyle.mini,
                  color: Color(0xFFAEAEAE),
                  size: 16.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
