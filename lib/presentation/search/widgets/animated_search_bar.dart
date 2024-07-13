import 'dart:math';
import 'package:education_app/common/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';

class AnimatedSearch extends StatefulWidget {
  const AnimatedSearch({super.key});

  @override
  State<AnimatedSearch> createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends State<AnimatedSearch> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AnimatedSearchBar extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final Function(int) searchBarOpen;
  const AnimatedSearchBar({
    Key? key,

    /// The width cannot be null
    required this.width,
    required this.searchBarOpen,

    /// The textController cannot be null
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",

    /// Height of wrapper container
    this.height = 60,

    /// choose your custom color
    this.color = Colors.white,

    /// choose your custom color for the search when it is expanded
    this.textFieldColor = Colors.white,

    /// choose your custom color for the search when it is expanded
    this.searchIconColor = Colors.black,

    /// choose your custom color for the search when it is expanded
    this.textFieldIconColor = Colors.black,
    this.textInputAction = TextInputAction.done,

    /// The onSuffixTap cannot be null
    required this.onSuffixTap,
    this.animationDurationInMilli = 775,

    /// The onSubmitted cannot be null
    required this.onSubmitted,

    /// make the search bar to open from right to left
    this.rtl = false,

    /// make the keyboard to show automatically when the searchbar is expanded
    this.autoFocus = false,

    /// TextStyle of the contents inside the searchbar
    this.style,

    /// close the search on suffix tap
    this.closeSearchOnSuffixTap = false,

    /// enable/disable the box shadow decoration
    this.boxShadow = true,

    /// can add list of inputformatters to control the input
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  ///toggle - 0 => false or closed
  ///toggle 1 => true or open
  int toggle = 0;

  /// * use this variable to check current text from OnChange
  String textFieldValue = '';

  ///initializing the AnimationController
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,

      ///if the rtl is true, search bar will be from right to left
      alignment: widget.rtl ? Alignment.centerRight : Alignment(-1.0, 0.0),

      ///Using Animated container to expand and shrink the widget
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: widget.height,
        width: (toggle == 0) ? 60.0 : widget.width,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          /// can add custom  color or the color will be white
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Stack(
          children: [
            ///Using Animated Positioned widget to expand and shrink the widget
            // Right icon
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 15.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  // padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    /// can add custom color or the color will be white
                    color: widget.color,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: AnimatedBuilder(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          ///trying to execute the onSuffixTap function
                          widget.onSuffixTap();
                          unfocusKeyboard();
                          setState(() {
                            toggle = 0;
                          });
                          _con.reverse();
                          widget.textController.clear();
                          // * if field empty then the user trying to close bar
                          // if (textFieldValue.isEmpty) {
                          //   unfocusKeyboard();
                          //   setState(() {
                          //     toggle = 0;
                          //   });

                          //   ///reverse = close
                          //   _con.reverse();
                          // }

                          // ///closeSearchOnSuffixTap will execute if it's true
                          // if (widget.closeSearchOnSuffixTap) {
                          //   unfocusKeyboard();
                          //   setState(() {
                          //     toggle = 0;
                          //   });
                          // }
                        } catch (e) {
                          ///print the error if the try block fails
                          print(e);
                        }
                      },

                      ///suffixIcon is of type Icon
                      child: HeroIcon(
                        HeroIcons.xMark,
                        size: 30,
                      ),
                    ),
                    builder: (context, widget) {
                      ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                      return Transform.rotate(
                        angle: _con.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                  ),
                ),
              ),
            ),
            // TextField
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 50.0,
              curve: Curves.easeOut,
              top: 16.0,

              ///Using Animated opacity to change the opacity of th textField while expanding
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.7,
                  child: TextField(
                    ///Text Controller. you can manipulate the text inside this textField by calling this controller.
                    controller: widget.textController,
                    inputFormatters: widget.inputFormatters,
                    focusNode: focusNode,
                    textInputAction: widget.textInputAction,
                    cursorRadius: Radius.circular(10.0),
                    cursorWidth: 2.0,
                    onChanged: (value) {
                      setState(() {
                        textFieldValue = value;
                      });
                    },
                    onSubmitted: (value) => {
                      widget.onSubmitted(value),
                      unfocusKeyboard(),
                      setState(() {
                        toggle = 0;
                      }),
                    },
                    onEditingComplete: () {
                      /// on editing complete the keyboard will be closed and the search bar will be closed
                      unfocusKeyboard();
                      setState(() {
                        toggle = 0;
                      });
                    },

                    ///style is of type TextStyle, the default is just a color black
                    style: widget.style != null
                        ? widget.style
                        : TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: widget.helpText,
                      labelStyle: TextStyle(
                        color: Color(0xff5B5B5B),
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///Using material widget here to get the ripple effect on the prefix icon
            /// Left Icon and default icon
            InkWell(
              onTap: () {
                if (toggle == 0) {
                  // Searchbar is closed currently
                  setState(() {
                    toggle = 1;
                  });
                  Future.delayed(const Duration(milliseconds: 350), () {
                    setState(() {
                      ///if the autoFocus is true, the keyboard will pop open, automatically
                      if (widget.autoFocus)
                        FocusScope.of(context).requestFocus(focusNode);
                    });
                  });
                  // execute animation
                  _con.forward();
                } else {
                  setState(() {
                    toggle = 0;
                  });
                  unfocusKeyboard();
                  _con.reverse();
                }
                widget.searchBarOpen(toggle);
              },
              child: const SizedBox(
                width: 60.0,
                height: 60,
                child: HeroIcon(
                  HeroIcons.magnifyingGlass,
                  size: 30.0,
                  color: CustomColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
