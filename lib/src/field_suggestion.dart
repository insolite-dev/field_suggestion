import 'package:flutter/material.dart';

import 'package:field_suggestion/src/styles.dart';
import 'package:field_suggestion/src/suggestion_item.dart';
import 'package:field_suggestion/src/utils.dart';

/// [FieldSuggestion] require to take `textController` and `suggestionList`.
/// `textController` listen changing on field, and after listening it's create a custom matchers list.
/// Which is would be come with `SuggestionBox`.
/// #### Basic usage:
/// ```dart
///  FieldSuggestion(
///   hint: "Email",
///   textController: _textEditingController,
///   suggestionList: suggestionList,
/// ),
/// ```
/// And [FieldSuggestion] have other options like: `onTap`, `onIconTap`, `sizeByItem`, `suggestionBoxStyle`, `fieldDecoration`, etc.
/// In here we use `fieldDecoration` property for change style of **field**.
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
/// To get more info about [FieldSuggestion].
/// Check [README.md](https://github.com/theiskaa/field_suggestion/blob/develop/README.md) of repository.
class FieldSuggestion extends StatefulWidget {
  /// The text editing controller for listen field value changes.
  final TextEditingController textController;

  /// The main list as `String` which would be displayed into suggestion box.
  final List<String> suggestionList;

  /// To set custom `onTap` method.
  /// e.g you need open a page, when item selected.
  /// Then you should use [onTap] as Navigator..
  final VoidCallback onTap;

  /// As default we use `onIconTap` for remove tapped item which are in [suggestionList] and [matchers] list.
  /// This property make able to customize action.
  final VoidCallback onIconTap;

  /// For calucalte size of suggestionBox by per item.
  /// So if `sizeByItem == 1` then size will be `60`.
  /// The number increases in parallel so when `sizeByItem == 2` then size of suggestionBox will be `120`.
  final int sizeByItem;

  /// Custom style option of [SuggestionBox].
  ///
  /// It takes [SuggestionBoxStyle.DefaultStyle] as default.
  /// Able to set as Custom, like this:
  /// ```dart
  /// SuggestionBoxStyle(...)
  /// /// With following properties:  [backgroundColor], [border], [borderRadius], [gradient], [boxShadow], [padding], [shape].
  /// ```
  final SuggestionBoxStyle suggestionBoxStyle;

  /// `wDivider` if it equeals `true`,
  /// User would see a simple line, every suggestionItem's front.
  final bool wDivider;

  /// As default we have divider widget. To create your own divider widget,
  /// you should use [divider] property.
  final Widget divider;

  /// Custom style option of `SuggestionItem`.
  ///
  /// It takes, [SuggestionItemStyle.DefaultStyle] as default.
  /// Able to set as Custom, like this:
  /// ```dart
  /// SuggestionItemStyle(...)
  /// // With following properties:  [backgroundColor], [titleStyle], [icon], [iconSize], [iconColor], [border], [borderRadius], [gradient], [boxShadow], [margin].
  /// ```
  /// Also able to set by ready designs, e.g:
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

  /// Field hint property to set it without [fieldDecoration].
  final String hint;

  /// To set custom InputDecoration for `FieldSuggestion`.
  final InputDecoration fieldDecoration;

  /// To set TextInputType of field.
  final TextInputType fieldType;

  /// FocusNode for field.
  final FocusNode focusNode;

  /// Custom onChanged method for [FieldSuggestion].
  final Function(String) onChanged;

  /// To controle size of `field`.
  final int maxLines;

  /// To dissable default `onTap` method of `SuggestionItem`.
  final bool disabledDefaultOnTap;

  /// To dissable default `onIconTap` method of `SuggestionItem`.
  final bool disabledDefaultOnIconTap;

  final bool closeBoxAfterSelect;

  /// The scroll controller for `suggestionList`.
  final ScrollController scrollController;

  /// To set size between field and suggestionsBox.
  /// As default `spacer` is `5.0`.
  final double spacer;

  /// To disable or enable opacity animation.
  /// As default is [false]
  final bool wOpacityAnimation;

  /// To customize duration of suggestonBox animation.
  /// As default it's [Duration(milliseconds: 800)].
  final Duration animationDuration;

  /// To enable or disable slide animtaion of [SuggestionBox]. As default it's [false].
  final bool wSlideAnimation;

  /// Custom enum for set tween offset of slide animation.
  ///
  /// **Rigth to left [RTL], Left to right [LTR], Bottom to up [BTU], Up to down [UTD].**
  final SlideAnimationStyle slideAnimationStyle;

  /// Curve to initilaze custom transition curve.
  final Curve slideCurve;

  /// Offset with Tween for Slide animation.
  ///
  /// **Note:** when you use `slideTweenOffset`, otomaticly `slideAnimationStyle` would be disabled.
  final Tween<Offset> slideTweenOffset;

  const FieldSuggestion({
    Key key,
    @required this.textController,
    @required this.suggestionList,

    // SuggestionBox properties.
    this.spacer = 5.0,
    this.suggestionBoxStyle = SuggestionBoxStyle.DefaultStyle,
    this.divider,
    this.wDivider = false,
    this.sizeByItem,
    this.closeBoxAfterSelect = true,
    this.wOpacityAnimation = false,
    this.animationDuration = const Duration(milliseconds: 400),
    this.wSlideAnimation = false,
    this.slideCurve = Curves.decelerate,
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
    this.focusNode,
  }) : super(key: key);

  @override
  FieldSuggestionState createState() => FieldSuggestionState();
}

class FieldSuggestionState extends State<FieldSuggestion>
    with TickerProviderStateMixin {
  // We showing/closing SuggestionsBox by listening [showSuggestionBox].
  bool showSuggestionBox = false;

  // To collect and list the pwidget.suggestionList] elements matching the text of the [widget.textController] in a list.
  List<dynamic> matchers = <dynamic>[];

  OverlayEntry _overlayEntry;

  LayerLink _layerLink = LayerLink();

  // Animation and AnimationController of [SuggestionBox].
  AnimationController animationController;
  Animation<double> _opacity;
  Animation<Offset> _slide;

  // Overly list to manage overlays.
  var _overlaysList = [];

  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Add listener to textController, for listen field and create matchers list.
    widget.textController.addListener(_textListener);

    // Initilaze animations if any animaton is enabled.
    if (widget.wOpacityAnimation || widget.wSlideAnimation) {
      animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );

      if (widget.wOpacityAnimation) {
        _opacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animationController);
      }

      if (widget.wSlideAnimation) {
        var _offsetTween;
        if (widget.slideTweenOffset != null) {
          _offsetTween = widget.slideTweenOffset;
        } else {
          switch (widget.slideAnimationStyle) {
            case SlideAnimationStyle.RTL:
              _offsetTween = Tween<Offset>(
                begin: Offset(5, 0),
                end: Offset.zero,
              );
              break;
            case SlideAnimationStyle.LTR:
              _offsetTween = Tween<Offset>(
                begin: Offset(-5, 0),
                end: Offset.zero,
              );
              break;
            case SlideAnimationStyle.BTU:
              _offsetTween = Tween<Offset>(
                begin: Offset(0, 5),
                end: Offset.zero,
              );
              break;
            case SlideAnimationStyle.UTD:
              _offsetTween = Tween<Offset>(
                begin: Offset(0, -5),
                end: Offset.zero,
              );
              break;
            default:
          }
        }
        _slide = _offsetTween.animate(
          CurvedAnimation(
            parent: animationController,
            curve: widget.slideCurve,
          ),
        );
      }
    }
  }

  void _textListener() {
    if (widget.textController.text.length == 0)
      _customSetState(() => showSuggestionBox = false);
    else {
      matchers.clear();

      if (matchers.length == 0)
        _customSetState(() => showSuggestionBox = false);

      // Upper case every item which were into [suggestionList] for easy separation.
      // And than create [matchers] list by listening `textController`.
      widget.suggestionList.forEach((item) {
        if (item
            .toUpperCase()
            .contains(widget.textController.text.toUpperCase()))
          matchers.add(item);
      });

      if (matchers.length == 0)
        showSuggestionBox = false;
      else {
        if (matchers.length == 1 && matchers[0] == widget.textController.text) {
          widget.closeBoxAfterSelect
              ? showSuggestionBox = false
              : showSuggestionBox = true;
        } else {
          showSuggestionBox = true;
        }
      }
      _customSetState(() {});
    }

    // Run the appropriate method.
    if (showSuggestionBox)
      showBox();
    else
      closeBox();
  }

  // For avoid [setState() called after dispose()] issue
  void _customSetState(void Function() fn) {
    if (this.mounted) return setState(fn);
  }

  // Custom method for show suggestionBox.
  // First it clears _overlayEntry and creates new one.
  void showBox() {
    if (_overlayEntry != null && _overlaysList.isNotEmpty) {
      _overlayEntry.remove();
      setState(() => _overlayEntry = null);
    }
    _createOverlay(context);
    if (widget.wOpacityAnimation || widget.wSlideAnimation)
      animationController.forward();
  }

  // Custom method for close suggestionBox.
  void closeBox() {
    if (_overlayEntry != null && _overlaysList.isNotEmpty) {
      _overlayEntry.remove();
      if (widget.wOpacityAnimation || widget.wSlideAnimation)
        animationController.reverse();
      setState(() => _overlayEntry = null);
    }
  }

  // Default tap method of SuggestionItem.
  onItemTap(String selectedItem) {
    if (widget.disabledDefaultOnTap)
      widget.onTap();
    else {
      _customSetState(() {
        widget.textController.text = selectedItem;
        widget.textController.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.textController.text.length));
      });
      if (widget.onTap != null) widget.onTap();
      if (widget.closeBoxAfterSelect) closeBox();
    }
  }

  // Default tap method of SuggestionItem's tralling.
  onTrallingTap(String selectedItem) {
    if (widget.disabledDefaultOnIconTap)
      widget.onIconTap();
    else {
      widget.suggestionList.remove(selectedItem);
      matchers.remove(selectedItem);
      _customSetState(() {});

      if (widget.onIconTap != null) widget.onIconTap();

      if (matchers.length != 0)
        showBox();
      else {
        _customSetState(() => showSuggestionBox = false);
        closeBox();
      }
    }
  }

  @override
  Widget build(BuildContext context) => fieldSuggestion();

  // Method to display SuggestionBox.
  void _createOverlay(BuildContext context) {
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
      animationController.addListener(() {
        _overlayState.setState(() {});
      });
    }
    _overlayState.insert(_overlayEntry);
    _overlaysList.clear();

    // Add the [overlayEntry] to cleared list.
    _overlaysList.add(_overlayEntry);
  }

  // If the value present in the [textController],
  // matches whatever value in the list you have defined,
  // then the buildSuggestionBox will appear.
  Widget _buildSuggestionBox(BuildContext context) {
    // Default divider. Which would be displayed front of each [suggestionListItem].
    Widget _divider = Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 1,
      color: Colors.black.withOpacity(.3),
    );

    Widget _suggestionBox = Opacity(
      opacity: (widget.wOpacityAnimation) ? _opacity.value : 1,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: _suggestionBoxStyle,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            // Custom utility for manage the maxHeight of [_suggestionbox].
            maxHeight: maxSuggestionBoxHeight(
              matchersList: matchers,
              wDivider: widget.wDivider,
              sizeByItem: widget.sizeByItem,
            ),
          ),
          child: ListView.separated(
            controller: widget.scrollController,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: matchers.length,
            separatorBuilder: (context, index) {
              if (widget.wDivider) {
                if (widget.divider != null)
                  return widget.divider;
                else
                  return _divider;
              } else
                return SizedBox.shrink();
            },
            itemBuilder: (context, index) => suggestionListItem(index),
          ),
        ),
      ),
    );

    Widget _box() {
      // Show suggestionBox with [SlideTransition] animation,
      // if [wSlideAnimation] is enabled (equals true).
      if (widget.wSlideAnimation)
        return SlideTransition(
          position: _slide,
          child: _suggestionBox,
        );
      else
        return _suggestionBox;
    }

    return Material(child: _box());
  }

  // Items which were mapped from matchers in [suggestionList].
  Container suggestionListItem(int index) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: SuggestionItem(
                title: "${matchers[index]}",
                style: widget.suggestionItemStyle,
                onTap: () => onItemTap(matchers[index]),
                onIconTap: () => onTrallingTap(matchers[index]),
              ),
            ),
          ],
        ),
      );

  Widget fieldSuggestion() => CompositedTransformTarget(
        link: _layerLink,
        child: TextField(
          keyboardType: widget.fieldType,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          controller: widget.textController,
          maxLines: (widget.maxLines != null) ? widget.maxLines : 1,
          decoration: (widget.fieldDecoration != null)
              ? widget.fieldDecoration
              : InputDecoration(hintText: widget.hint, labelText: widget.hint),
        ),
      );

  // Get [_suggestionBoxStyle] by listening custom style widget [widget.suggestionBoxStyle].
  Decoration get _suggestionBoxStyle => BoxDecoration(
        color: widget.suggestionBoxStyle.backgroundColor,
        borderRadius: widget.suggestionBoxStyle.borderRadius,
        boxShadow: widget.suggestionBoxStyle.boxShadow,
        border: widget.suggestionBoxStyle.border,
      );
}
