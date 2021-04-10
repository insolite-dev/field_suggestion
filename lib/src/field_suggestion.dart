import 'package:field_suggestion/src/suggestion_item.dart';
import 'package:flutter/material.dart';
import 'package:field_suggestion/src/styles.dart';

/// [FieldSuggestion] just need to take, `textController` and `suggestionList`.
/// `textController` listen changing on field, and after listening it's create a custom matchers list.
/// which is would be come with `SuggestionBox`.
/// #### Basic usage:
/// ```dart
///  FieldSuggestion(
///   hint: "Email",
///   textController: _textEditingController,
///   suggestionList: suggestionList,
/// ),
/// ```
/// And [FieldSuggestion] have other options, like: `onTap`, `onIconTap`, `sizeByItem`, `suggestionBoxStyle`, `fieldDecoration`, etc.
/// In here we use `fieldDecoration` property for change style of [FieldSuggestion].
/// To change style and customize [SuggestionBox], we should use  `suggestionBoxStyle`.
/// and the custom style class we have created is [SuggestionItemStyle].
/// **we can use it like this:**
/// ```dart
///  FieldSuggestion(
///   hint: "Email",
///   suggestionItemStyle = SuggestionItemStyle.WhiteNeumorphismedStyle,
///   ...
/// ),
/// ```
/// And more..
class FieldSuggestion extends StatefulWidget {
  ///
  /// The text editing controller for listen field value changes. 
  final TextEditingController textController;

  /// The main list as `String` which would be displayed into suggestion box.
  final List<String> suggestionList;

  /// To set custom `onTap` method.
  /// For example: you need open a page, when item selected
  /// so you can use [onTap] as Navigator..
  final VoidCallback onTap;

  /// As default we use `onIconTap` for remove tapped item which are in [suggestionList] and [_matchers] list.
  /// this property make able to customize this.
  final VoidCallback onIconTap;

  /// To calucalte size of suggestionBox by per item.
  /// So if `sizeByItem == 1` then size will be `60` (and also as default). it's `60`.
  /// The number increases in parallel so when `sizeByItem == 2` then suggestionBox's size will be `120`.
  final int sizeByItem;

  /// Custom style option of [SuggestionBox], it takes [SuggestionBoxStyle.DefaultStyle] by default.
  /// Able to set as Custom, like this:
  /// ```dart
  /// SuggestionBoxStyle(...)
  /// /// With following properties:  [backgroundColor], [border], [borderRadius], [gradient], [boxShadow], [padding], [shape].
  /// ```
  /// also able to set by ready designs. for example:
  /// ```
  /// SuggestionBoxStyle.DefaultStyle
  /// ```
  final SuggestionBoxStyle suggestionBoxStyle;

  /// `wDivider` means - with divider? so if it equeals `true`, we can see a simple line,
  /// every suggestionItem's front.
  final bool wDivider;

  /// As default we have divider widget.To create your own divider widget,
  /// you should use [divider].
  final Widget divider;

  /// Custom style option of `SuggestionItem`, it takes, [SuggestionItemStyle.DefaultStyle] by default.
  /// Able to set as Custom, like this:
  /// ```dart
  /// SuggestionItemStyle(...)
  /// ```
  /// also able to set by ready designs. for example:
  /// ```
  /// SuggestionItemStyle.DefaultStyle
  /// ```
  /// ```
  /// SuggestionItemStyle.WhiteNeumorphismedStyle
  /// ```
  /// ```
  /// SuggestionItemStyle.BlackNeumorphismedStyle
  /// ```
  final SuggestionItemStyle suggestionItemStyle;

  /// When set `hint` whithout [fieldDecoration]
  /// it include suggestion field's hint & label.
  final String hint;

  /// To set custom InputDecoration for `FieldSuggestion`.
  final InputDecoration fieldDecoration;

  /// To set custom TextInputType.
  final TextInputType fieldType;

  /// Custom onChanged method as String function. for [FieldSuggestion].
  final Function(String) onChanged;

  /// To controle size of `FieldSuggestion`.
  final int maxLines;

  /// To dissable default `onTap` method of `SuggestionItem`.
  final bool disabledDefaultOnTap;

  /// To dissable default `onIconTap` method of `SuggestionItem`.
  final bool disabledDefaultOnIconTap;

  /// To do or don't closing `suggestionBox` after tapping -`SuggestionItem`.
  final bool closeBoxAfterSelect;

  /// The scroll controller for `suggestionList`.
  final ScrollController scrollController;

  /// To set size between [FieldSuggestion] and [SuggestionBox].
  /// As default `spacer` is `5.0`.
  final double spacer;

  /// To disable and enable opacity animation. in default is [true]
  final bool wOpacityAnimation;

  /// Duration property for customize duration of suggestonBox animation.
  /// As default it's returns [Duration(milliseconds: 800)].
  final Duration animationDuration;

  /// To enable or disable [SuggestionBox] slide animtaion. As default it's [false].
  final bool wSlideAnimation;

  /// Custom enum for set tween offset of slide animation.
  /// 
  /// **Rigth to left [RTL], Left to right [LTR], Bottom to up [BTU], Up to down [UTD].**
  final SlideAnimationStyle slideAnimationStyle;

  /// Curve property for initilaze custom transition curve.
  final Curve slideCurve;

  // Offset with Tween of Slide animation.
  final Tween<Offset> slideTweenOffset;

  const FieldSuggestion({
    Key key,

    // Required properties.
    @required this.textController,
    @required this.suggestionList,

    // General
    this.spacer = 5.0,

    // SuggestionBox properties.
    this.suggestionBoxStyle = SuggestionBoxStyle.DefaultStyle,
    this.divider,
    this.wDivider = false,
    this.sizeByItem,
    this.closeBoxAfterSelect = true,
    this.wOpacityAnimation = true,
    this.animationDuration,
    this.wSlideAnimation = false,
    this.slideCurve,
    this.slideTweenOffset,
    this.slideAnimationStyle = SlideAnimationStyle.RTL,

    // SuggestionItem properties.
    this.suggestionItemStyle = SuggestionItemStyle.DefaultStyle,
    this.onTap,
    this.onIconTap,
    this.disabledDefaultOnTap = false,
    this.disabledDefaultOnIconTap = false,
    this.scrollController,

    // FieldSuggestion properties.
    this.hint,
    this.fieldDecoration,
    this.fieldType,
    this.maxLines,
    this.onChanged,
  }) : super(key: key);

  @override
  FieldSuggestionState createState() => FieldSuggestionState();
}

class FieldSuggestionState extends State<FieldSuggestion>
    with TickerProviderStateMixin {
  // To controle [suggestionBox].
  bool showSuggestionBox = false;

  // To collect and list the `widget.suggestionList` elements matching the text of the `widget.textController` in a list.
  List<dynamic> _matchers = <dynamic>[];

  // Default overlay.
  OverlayEntry _overlayEntry;

  // Node for focus `FieldSuggestion`.
  FocusNode _node = FocusNode();

  LayerLink _layerLink = LayerLink();

  // Animation and AnimationController of [SuggestionBox].
  AnimationController _animationController;
  Animation<double> _opacity;
  Animation<Offset> _slide;

  // Overly list to manage overlays easily.
  var _overlaysList = [];

  @override
  void initState() {
    super.initState();
    // Add listener to textController, for listen field and create matchers list.
    widget.textController.addListener(_textListener);

    // Initilaze animations if any animaton is enabled.
    if (widget.wOpacityAnimation || widget.wSlideAnimation) {
      // Implement _animationController.
      _animationController = AnimationController(
        vsync: this,
        duration: (widget.animationDuration != null)
            ? widget.animationDuration
            : Duration(milliseconds: 400),
      );

      // Initilaze opacity [_animation] if [widget.wOpacityAnimation] is true.
      if (widget.wOpacityAnimation) {
        _opacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(_animationController);
      }

      // Initilaze the [_slide] animation if [widget.wRotationAnimation] is true.
      if (widget.wSlideAnimation) {
        var _offsetTween;
        if (widget.slideTweenOffset != null) {
          _offsetTween = widget.slideTweenOffset;
        } else {
          // Set _offsetTween for SlideAnimationStyle.RTL.
          if (widget.slideAnimationStyle == SlideAnimationStyle.RTL) {
            _offsetTween = Tween<Offset>(
              begin: Offset(5, 0),
              end: Offset.zero,
            );
          }
          // Set _offsetTween for SlideAnimationStyle.LTR.
          else if (widget.slideAnimationStyle == SlideAnimationStyle.LTR) {
            _offsetTween = Tween<Offset>(
              begin: Offset(-5, 0),
              end: Offset.zero,
            );
          }
          // Set _offsetTween for SlideAnimationStyle.BTU.
          else if (widget.slideAnimationStyle == SlideAnimationStyle.BTU) {
            _offsetTween = Tween<Offset>(
              begin: Offset(0, 5),
              end: Offset.zero,
            );
          }
          // Set _offsetTween for SlideAnimationStyle.UTD.
          else if (widget.slideAnimationStyle == SlideAnimationStyle.UTD) {
            _offsetTween = Tween<Offset>(
              begin: Offset(0, -5),
              end: Offset.zero,
            );
          }
        }
        _slide = _offsetTween.animate(
          CurvedAnimation(
            parent: _animationController,
            curve: (widget.slideCurve != null)
                ? widget.slideCurve
                : Curves.decelerate,
          ),
        );
      }
    }
  }

  void _textListener() {
    if (widget.textController.text.length > 0) {
      // Clear all matcher items.
      _matchers.clear();

      if (_matchers.length == 0)
        _customSetState(setState(() => showSuggestionBox = false));

      // Upper case every item which were into `suggestionList` for easy separation.
      // Create [_matchers] list by listening `textController`.
      widget.suggestionList.forEach((item) {
        if (item.toUpperCase().contains(
              widget.textController.text.toUpperCase(),
            )) _matchers.add(item);
      });

      // Manage [showSuggestionBox] value
      if (_matchers.length > 0) {
        if (_matchers.length == 1 &&
            _matchers[0] == widget.textController.text) {
          if (widget.closeBoxAfterSelect) {
            showSuggestionBox = false;
          } else {
            showSuggestionBox = true;
          }
        } else {
          showSuggestionBox = true;
        }
      } else {
        showSuggestionBox = false;
      }
      _customSetState(setState(() {}));
    } else {
      _customSetState(setState(() => showSuggestionBox = false));
    }

    // Run the appropriate method.
    if (showSuggestionBox)
      _showBox();
    else
      _closeBox();
  }

  // For avoid this issue: [setState() called after dispose()]
  void _customSetState(void setS) {
    if (this.mounted) return setS;
  }

  // Custom method for show suggestionBox.
  // so creating overlay by listening `overlaysList`.
  void _showBox() {
    if (_overlayEntry != null) {
      if (_overlaysList.isNotEmpty) {
        _overlayEntry.remove();
        setState(() => _overlayEntry = null);
      }
    }
    _overlay(context);
    if (widget.wOpacityAnimation || widget.wSlideAnimation)
      _animationController.forward();
  }

  // Custom method for close suggestionBox.
  // so removing overlay by listening `overlaysList`.
  void _closeBox() {
    if (_overlayEntry != null) {
      if (_overlaysList.isNotEmpty) {
        _overlayEntry.remove();
        if (widget.wOpacityAnimation || widget.wSlideAnimation)
          _animationController.reverse();
        setState(() => _overlayEntry = null);
      }
    }
  }

  // Default list item tap method.
  _onItemTap(String selectedItem) {
    if (widget.disabledDefaultOnTap != null &&
        widget.disabledDefaultOnTap != false) {
      widget.onTap();
    } else {
      _customSetState(setState(() {
        widget.textController.text = selectedItem;
        widget.textController.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.textController.text.length));
        if (widget.onTap != null) widget.onTap();
      }));
      if (widget.closeBoxAfterSelect == true) _closeBox();
    }
  }

  // Default Tralling icon tap method.
  _onTrallingTap(String selectedItem) {
    if (widget.disabledDefaultOnIconTap != null &&
        widget.disabledDefaultOnIconTap != false) {
      widget.onIconTap();
    } else {
      widget.suggestionList.remove(selectedItem);
      _matchers.remove(selectedItem);

      if (_matchers.length == 0) {
        _customSetState(setState(() {
          showSuggestionBox = false;
        }));
        _closeBox();
      }
      _customSetState(setState(() {}));
      if (widget.onIconTap != null) widget.onIconTap();
      _showBox();
    }
  }

  @override
  Widget build(BuildContext context) => _fieldSuggestion();

  // Method to set overlay entry and insert it.
  void _overlay(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    OverlayState _overlayState = Overlay.of(context);
    var size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + widget.spacer),
          child: _buildSuggestionBox(context),
        ),
      ),
    );

    // Determine the method to be defined by listening to the animation values.
    if (widget.wOpacityAnimation || widget.wSlideAnimation) {
      _animationController.addListener(() {
        _overlayState.setState(() {});
      });
    }
    _overlayState.insert(_overlayEntry);

    // Clear the overlay list.
    _overlaysList.clear();

    // Add the [overlayEntry] to cleared list.
    _overlaysList.add(_overlayEntry);
  }

  // If the value present in the [textController],
  // matches whatever value in the list you have defined,
  // then the buildSuggestionBox will appear.
  Widget _buildSuggestionBox(BuildContext context) {
    // Default divider, which would be displayed between [suggestionListItem].
    // If [wDivider] would be [true].
    Widget _divider = Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 1,
      color: Colors.black.withOpacity(.3),
    );

    Widget _suggestionbox = Opacity(
      opacity: (widget.wOpacityAnimation) ? _opacity.value : 1,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: _suggestionBoxStyle,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: _maxHeight(),
          ),
          child: ListView.separated(
            controller: widget.scrollController,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _matchers.length,
            separatorBuilder: (context, index) {
              if (widget.wDivider != null && widget.wDivider != false) {
                if (widget.divider != null) {
                  return widget.divider;
                } else {
                  return _divider;
                }
              } else
                return SizedBox.shrink();
            },
            itemBuilder: (context, index) => _suggestionListItem(index),
          ),
        ),
      ),
    );

    Widget _box() {
      // Enable slide animation by listening [wSlideAnimation].
      if (widget.wSlideAnimation) {
        return SlideTransition(
          position: _slide,
          child: _suggestionbox,
        );
      }

      return _suggestionbox;
    }

    return Material(child: _box());
  }

  // Items which were mapped from _matchers in [suggestionList].
  Container _suggestionListItem(int index) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: SuggestionItem(
                title: "${_matchers[index]}",
                style: widget.suggestionItemStyle,
                onTap: () => _onItemTap(_matchers[index]),
                onIconTap: () => _onTrallingTap(_matchers[index]),
              ),
            ),
          ],
        ),
      );

  // Main TextField widget which are returned into build method.
  Widget _fieldSuggestion() => CompositedTransformTarget(
        link: _layerLink,
        child: TextField(
          keyboardType: widget.fieldType,
          focusNode: _node,
          onChanged: widget.onChanged,
          controller: widget.textController,
          maxLines: (widget.maxLines != null) ? widget.maxLines : 1,
          decoration: (widget.fieldDecoration != null)
              ? widget.fieldDecoration
              : InputDecoration(hintText: widget.hint, labelText: widget.hint),
        ),
      );

  // Get right max height by listening `suggestionItemStyle`, `wDivider` and `sizeByItem`.
  double _maxHeight() {
    double size;

    // Set size by listening [suggestionItemStyle] and [wDivider].
    if (widget.suggestionItemStyle ==
            SuggestionItemStyle.WhiteNeumorphismedStyle ||
        widget.wDivider == true ||
        widget.suggestionItemStyle ==
            SuggestionItemStyle.BlackNeumorphismedStyle) {
      if (widget.suggestionItemStyle ==
              SuggestionItemStyle.WhiteNeumorphismedStyle ||
          widget.suggestionItemStyle ==
                  SuggestionItemStyle.BlackNeumorphismedStyle &&
              widget.wDivider == true) {
        size = 70;
      }
      size = 65;
    } else {
      size = 60;
    }

    // Set size by listening [sizeByItem].
    if (widget.sizeByItem != null) {
      if (widget.sizeByItem == 1) {
        return size;
      } else {
        return size * widget.sizeByItem.roundToDouble();
      }
    }

    // Set size by listening [_matchers.length].
    else {
      if (_matchers.length == 1) {
        return size;
      } else if (_matchers.length == 2) {
        return size * _matchers.length.roundToDouble();
      } else {
        return size * 3.toDouble();
      }
    }
  }

  // Get [_suggestionBoxStyle] by listening [suggestionBoxStyle].
  Decoration get _suggestionBoxStyle => BoxDecoration(
        color: widget.suggestionBoxStyle.backgroundColor,
        borderRadius: widget.suggestionBoxStyle.borderRadius,
        boxShadow: widget.suggestionBoxStyle.boxShadow,
        border: widget.suggestionBoxStyle.border,
      );
}
