import 'package:flutter/material.dart';

import 'package:field_suggestion/src/box_controller.dart';
import 'package:field_suggestion/src/styles.dart';
import 'package:field_suggestion/src/suggestion_item.dart';
import 'package:field_suggestion/src/utils.dart';

/// [FieldSuggestion] require to take `textController` and `suggestionList`.
///
/// `textController` listens changing on the field, and after listening it's create a custom matchers list.
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
///
/// ---
///
/// Or if you wanna make your suggestion items more specific/custom, you can use FieldSuggestion.builder(...)
/// Require to take `suggestionList`, `textController`, and `itemBuilder`.
///
/// **Example:**
/// ```dart
/// FieldSuggestion.builder(
///   textController: textEditingController,
///   suggestionList: suggestionsList,
///   itemBuilder: (BuildContext context, int index) {
///      return GestureDetector(
///         onTap: () => textEditingController.text = suggestionsList[index],
///         onDoubleTap: () => suggestionsList.remove(suggestionsList[index]),
///         child: Card(
///           child: ListTile(
///             title: Text(suggestionsList[index]),
///           ),
///         ),
///       );
///    },
/// ),
/// ```
///
/// ### To get more, please check [official documentation](https://github.com/theiskaa/field_suggestion/blob/develop/README.md)
///
class FieldSuggestion extends StatefulWidget {
  /// The text editing controller for listen field value changes.
  final TextEditingController textController;

  /// The main list which would be displayed into suggestion box.
  /// Able to use as `List<String>`, `List<int>`, `List<double>` and Custom model class.
  ///
  /// For Example: `List<UserModel>`.
  /// If you wanna do this then `searchBy` property must be initilazed.
  /// **And one important part is that your model class must to have [toJson] method.**
  ///
  /// ### Complete model example which can be used in [suggestionList]:
  /// ```dart
  /// class UserModel {
  ///   final String? email;
  ///   final String? password;
  ///
  ///   const UserModel({this.email, this.password});
  ///
  ///   Map<String, dynamic> toJson() => {
  ///         'email': this.email,
  ///         'password': this.password,
  ///       };
  /// }
  /// ```
  final List<dynamic> suggestionList;

  /// It must be initilazed when suggestionList isn't `List<String>`, `List<int>`, or `List<double>`.
  ///
  /// Howeveer, when you give a suggestion list which includes custom classes,
  /// then you must to add the propert's name which you wanna search by.
  /// ---
  /// **For example:**
  ///
  /// I have a class like:
  /// ```dart
  /// class UserModel{
  ///  final String? email;
  ///  final String? password;
  /// }
  /// ```
  /// And my [suggestionList]'s runtimeType is List<UserModel>.
  /// Then have to add `searchBy: ['email']` or `searchBy: ['password']` or maybe together: `searchBy: ['email', 'password']`
  final List<String>? searchBy;

  /// To set custom `onTap` method.
  /// e.g you need open a page, when item selected.
  /// Then you should use [onTap] as Navigator..
  final Function? onTap;

  /// As default we use `onIconTap` for remove tapped item which are in [suggestionList] and [matchers] list.
  /// This property make able to customize action.
  final Function? onIconTap;

  /// As default its null.
  ///
  /// Function which takes the selected item's data. and makes that convenient.
  ///
  /// Example:
  /// ```dart
  /// onItemSelected: (value) => print(value);
  /// ```
  final Function(dynamic)? onItemSelected;

  /// Controller to use suggeestion box externally.
  /// It makes able to "show" and "close" suggestion box, whenever/everywhere you want.
  ///
  /// **Example:**
  /// ```dart
  /// class Example extends StatelessWidget {
  ///   final _textController = TextEditingController();
  ///   final _boxController = BoxController();
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return GestureDetector(
  ///       onTap: () => _boxController.close(),
  ///       child: Scaffold(
  ///         body: Center(
  ///           child: FieldSuggestion(
  ///             hint: 'test',
  ///             suggestionList: [], // Your suggestions list here...
  ///             boxController: _boxController,
  ///             textController: _textController,
  ///           ),
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  /// Here we just wrapped our `Scaffold` with `GestureDetector` to handle gestures on the screen.
  /// And now we can close box when we tap on the screen.
  final BoxController? boxController;

  /// As default it will be your [searchBy]'s first value.
  ///
  /// If you wanna see other values as a title, just provide a property from [searchBy] list.
  final String? itemTitleBy;

  /// As default it's [null].
  ///
  /// If you wanna subtitle on suggestion item, just provide a property from [searchBy] list.
  /// It automatically will be enabled.
  final String? itemSubtitleBy;

  /// For calucalte size of suggestionBox by per item.
  /// So if `sizeByItem == 1` then size will be `60`.
  /// The number increases in parallel so when `sizeByItem == 2` then size of suggestionBox will be `120`.
  final int? sizeByItem;

  /// Custom style option of [SuggestionBox].
  ///
  /// It takes [SuggestionBoxStyle.DefaultStyle] as default.
  /// Able to set as Custom, like this:
  /// ```dart
  /// SuggestionBoxStyle(...)
  /// /// With following properties:  [backgroundColor], [border], [borderRadius], [gradient], [boxShadow], [padding], [shape].
  /// ```
  final SuggestionBoxStyle boxStyle;

  /// `wDivider` if it equeals `true`,
  /// User would see a simple line, every suggestionItem's front.
  final bool wDivider;

  /// As default FieldSuggestion has divider widget. To create your own divider widget,
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
  final SuggestionItemStyle itemStyle;

  /// Disables default trailing [X] icon.
  /// As default it isn't disabled so `false`.
  final bool disableItemTrailing;

  /// Field hint property to set it without [fieldDecoration].
  final String? hint;

  /// To set custom InputDecoration for `FieldSuggestion`.
  final InputDecoration? fieldDecoration;

  /// To set TextInputType of field.
  final TextInputType? fieldType;

  /// FocusNode for field.
  final FocusNode? focusNode;

  /// Custom onChanged method for [FieldSuggestion].
  final Function(String)? onFieldChanged;

  /// To controle size of `field`.
  final int? maxLines;

  /// To dissable default `onTap` method of `SuggestionItem`.
  final bool disabledDefaultOnTap;

  /// To dissable default `onIconTap` method of `SuggestionItem`.
  final bool disabledDefaultOnIconTap;

  final bool closeBoxAfterSelect;

  /// The scroll controller for `suggestionList`.
  final ScrollController? scrollController;

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
  final Tween<Offset>? slideTweenOffset;

  /// Used to make custom suggestion items. So it designed for just development.
  /// However maybe it could be used as customization property.
  ///
  /// **But suggested to use `FieldSuggestion.builder()`**
  final Widget Function(BuildContext, int)? itemBuilder;

  const FieldSuggestion({
    Key? key,
    required this.textController,
    required this.suggestionList,
    this.searchBy,
    this.itemBuilder,

    // SuggestionBox properties.
    this.boxController,
    this.spacer = 5.0,
    this.boxStyle = SuggestionBoxStyle.DefaultStyle,
    this.divider = const Divider(),
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
    this.itemStyle = SuggestionItemStyle.DefaultStyle,
    this.onTap,
    this.onIconTap,
    this.onItemSelected,
    this.itemTitleBy,
    this.itemSubtitleBy,
    this.disabledDefaultOnTap = false,
    this.disabledDefaultOnIconTap = false,
    this.scrollController,
    this.disableItemTrailing = false,

    // FieldSuggestion properties.
    this.hint,
    this.fieldDecoration,
    this.fieldType,
    this.maxLines,
    this.onFieldChanged,
    this.focusNode,
  }) : super(key: key);

  @override
  _FieldSuggestionState createState() => _FieldSuggestionState(boxController);

  /// Makes able to make very custom suggestion items.
  ///
  /// Require to take `suggestionList`, `textController`, and `itemBuilder`.
  ///
  /// **Example:**
  /// ```dart
  /// class BuilderExample extends StatelessWidget {
  ///   final textEditingController = TextEditingController();
  ///   List<String> suggestionsList = ['test@gmail.com', 'test1@gmail.com'];
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       body: FieldSuggestion.builder(
  ///         hint: 'Email',
  ///         textController: textEditingController,
  ///         suggestionList: suggestionsList,
  ///         itemBuilder: (BuildContext context, int index) {
  ///           return GestureDetector(
  ///             onTap: () => textEditingController.text = suggestionsList[index],
  ///             child: Card(
  ///               child: ListTile(
  ///                 title: Text(suggestionsList[index]),
  ///                 leading: Container(
  ///                   height: 30,
  ///                   width: 30,
  ///                   decoration: BoxDecoration(
  ///                     color: Colors.blueGrey,
  ///                     shape: BoxShape.circle,
  ///                   ),
  ///                   child: Center(
  ///                     child: Text(suggestionsList[index][0].toUpperCase()),
  ///                   ),
  ///                 ),
  ///               ),
  ///             ),
  ///           );
  ///         },
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  factory FieldSuggestion.builder({
    Key? key,
    required List<dynamic> suggestionList,
    required TextEditingController textController,
    required Widget Function(BuildContext, int) itemBuilder,
    BoxController? boxController,
    List<String>? searchBy,
    String? hint,
    int? sizeByItem,
    SuggestionBoxStyle boxStyle = SuggestionBoxStyle.DefaultStyle,
    bool wDivider = false,
    Widget divider = const Divider(),
    InputDecoration? fieldDecoration,
    TextInputType? fieldType,
    FocusNode? focusNode,
    Function(String)? onFieldChanged,
    int? maxLines,
    final ScrollController? scrollController,
    double spacer = 5.0,
    bool wOpacityAnimation = false,
    Duration animationDuration = const Duration(milliseconds: 400),
    bool wSlideAnimation = false,
    SlideAnimationStyle slideAnimationStyle = SlideAnimationStyle.RTL,
    Curve slideCurve = Curves.decelerate,
    Tween<Offset>? slideTweenOffset,
    bool closeBoxAfterSelect = true,
  }) {
    return FieldSuggestion(
      key: key,
      itemBuilder: itemBuilder,
      textController: textController,
      suggestionList: suggestionList,
      boxController: boxController,
      searchBy: searchBy,
      hint: hint,
      sizeByItem: sizeByItem,
      boxStyle: boxStyle,
      wDivider: wDivider,
      divider: divider,
      fieldDecoration: fieldDecoration,
      fieldType: fieldType,
      focusNode: focusNode,
      onFieldChanged: onFieldChanged,
      maxLines: maxLines,
      scrollController: scrollController,
      spacer: spacer,
      wOpacityAnimation: wOpacityAnimation,
      animationDuration: animationDuration,
      wSlideAnimation: wSlideAnimation,
      slideAnimationStyle: slideAnimationStyle,
      slideCurve: slideCurve,
      slideTweenOffset: slideTweenOffset,
      closeBoxAfterSelect: closeBoxAfterSelect,
    );
  }
}

class _FieldSuggestionState extends State<FieldSuggestion>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => fieldSuggestion();

  // Sets boxController values by current state values.
  _FieldSuggestionState(BoxController? _boxController) {
    if (_boxController != null) {
      _boxController.close = closeBox;
      _boxController.show = showBox;
    }
  }

  // To collect and list the [widget.suggestionList] elements
  // matching the text of the [widget.textController] in a list.
  List<dynamic> matchers = <dynamic>[];

  // Used to find right index of concrete item when it's object.
  // We return it on ln 702-704.
  List<dynamic> objectSuggestionsAsJson = <dynamic>[];

  OverlayEntry? _overlayEntry;

  LayerLink _layerLink = LayerLink();

  late AnimationController _animationController;
  late Animation<double> _opacity;
  Animation<Offset>? _slide;

  // List which helps to manage overlays.
  var _overlaysList = [];

  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (isObjList(widget.suggestionList)) {
      objectSuggestionsAsJson =
          widget.suggestionList.map((e) => e.toJson().toString()).toList();
    }

    // Add listener to textController, for listen field and create matchers list.
    widget.textController.addListener(_textListener);

    // Initilaze animations if any animaton was enabled.
    if (widget.wOpacityAnimation || widget.wSlideAnimation) {
      _animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );

      if (widget.wOpacityAnimation) {
        _opacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(_animationController);
      }

      if (widget.wSlideAnimation) return initilazeSlideAnimation();
    }
  }

  void _textListener() {
    if (widget.textController.text.length == 0) {
      closeBox();
    } else {
      final inputText = widget.textController.text;

      if (isObjList(widget.suggestionList)) {
        // At this time, `searchBy` must not be null.
        // Because renderObjList (which fill's matchers) must have [searchBy] properties,
        // to know which variable you wanna search by.
        if (widget.searchBy == null) {
          throw FlutterError(
            "If given suggestionList's runtimeType isn't List<String>, List<int> or List<double>. That means, you was gave a List which includes dart classes. So then [searchBy] can't be null.",
          );
        }
        matchers = renderObjList(
          widget.suggestionList,
          inputText,
          widget.searchBy,
        );
      } else {
        matchers = widget.suggestionList.where((item) {
          // Need list type checking here because if list contains int or double,
          // then we needn't to upper case item data and also we can't do it in dart.
          if (widget.suggestionList is List<int> ||
              widget.suggestionList is List<double>) {
            return item.toString().contains(inputText.toString());
          }
          return item.toUpperCase().contains(inputText.toUpperCase());
        }).toList();
      }

      if ((matchers.isNotEmpty && matchers[0] != inputText) ||
          !widget.closeBoxAfterSelect) {
        showBox();
      } else
        closeBox();
    }
  }

  // Detects [slideAnimationStyle] and sets valid [_offsetTween].
  // After that initilazes [_slide] animation, with setted [_offsetTween].
  void initilazeSlideAnimation() {
    var _offsetTween;
    if (widget.slideTweenOffset != null)
      _offsetTween = widget.slideTweenOffset;
    else {
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

    // Initialze setted [_offsetTween] as [_slide] animation.
    _slide = _offsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.slideCurve,
      ),
    );
  }

  // For avoid [setState() called after dispose()] issue
  void _customSetState(void Function() fn) {
    if (this.mounted) return setState(fn);
  }

  // Custom method for show suggestionBox.
  // First it clears _overlayEntry and creates new one.
  void showBox() {
    if (_overlayEntry != null && _overlaysList.isNotEmpty) {
      _overlayEntry!.remove();
      _customSetState(() => _overlayEntry = null);
    }
    _createOverlay(context);
    if (widget.wOpacityAnimation || widget.wSlideAnimation)
      _animationController.forward();
  }

  // Custom method for close suggestionBox.
  // It just clears/removes overlay entry.
  void closeBox() {
    if (_overlayEntry != null && _overlaysList.isNotEmpty) {
      _overlayEntry!.remove();
      if (widget.wOpacityAnimation || widget.wSlideAnimation)
        _animationController.reverse();
      _customSetState(() => _overlayEntry = null);
    }
  }

  // Default tap method of SuggestionItem.
  // It fills value of field with title of selected item.
  // And if `closeBoxAfterSelect` is enabled (as default it's enabled),
  // It closes suggestions box after tapping the item.
  onItemTap(dynamic selectedItem) {
    if (widget.disabledDefaultOnTap) {
      widget.onTap!();
      if (widget.onItemSelected != null) widget.onItemSelected!(selectedItem);
      return;
    }

    _customSetState(() {
      widget.textController.text = isObjList(widget.suggestionList)
          ? selectedItem['${widget.itemTitleBy ?? widget.searchBy![0]}']
              .toString()
          : selectedItem.toString();
      widget.textController.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.textController.text.length),
      );
    });

    if (widget.onTap != null) widget.onTap!();
    if (widget.onItemSelected != null) widget.onItemSelected!(selectedItem);
    if (widget.closeBoxAfterSelect) closeBox();
  }

  // Default tap method of SuggestionItem's tralling .
  // It removes selected item from [widget.suggestionList] and [matchers].
  onTrallingTap(dynamic selectedItem) {
    if (widget.disabledDefaultOnIconTap) return widget.onIconTap!();

    widget.suggestionList.remove(selectedItem);
    matchers.remove(selectedItem);

    if (widget.onIconTap != null) widget.onIconTap!();
    (matchers.length != 0) ? showBox() : closeBox();
  }

  // Creates SuggestionsBox as overlay,
  // it's sticking to down of [fieldSuggestion] by using [_layerLink].
  void _createOverlay(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    OverlayState _overlayState = Overlay.of(context)!;
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
      _animationController.addListener(() => _overlayState.setState(() {}));
    }
    _overlayState.insert(_overlayEntry!);
    _overlaysList.clear();

    // Add the [overlayEntry] to cleared list.
    _overlaysList.add(_overlayEntry);
  }

  // If the value present in the [textController], matches whatever value in the
  // list you have defined, then the buildSuggestionBox will appear.
  Widget _buildSuggestionBox(BuildContext context) {
    Widget _suggestionBox = Opacity(
      opacity: (widget.wOpacityAnimation) ? _opacity.value : 1,
      child: Container(
        padding: const EdgeInsets.all(12),
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
            separatorBuilder: (_, __) =>
                (widget.wDivider) ? widget.divider : const SizedBox.shrink(),
            itemBuilder: (widget.itemBuilder == null)
                ? (_, i) => suggestionListItem(i)
                : (_, i) {
                    // We need indexes to determine right index of concrete item.
                    var indexes = matchers.map((e) {
                      // If suggestion list isn't Object list then just return index of "e".
                      if (!isObjList(widget.suggestionList))
                        return widget.suggestionList.indexOf(e);

                      return objectSuggestionsAsJson.indexOf(e.toString());
                    }).toList();

                    return widget.itemBuilder!(context, indexes[i]);
                  },
          ),
        ),
      ),
    );

    Widget box = !widget.wSlideAnimation
        ? _suggestionBox
        : SlideTransition(position: _slide!, child: _suggestionBox);

    return Material(child: box);
  }

  /// A card which returns suggestion item widget.
  /// It used in ListView builder so it has ability to fill its data by given index/
  Widget suggestionListItem(int index) {
    // If suggestion list contains objects then it will return title from itemTitleBy or searchBy's first item.
    // Unless it will return directly a title from matchers list.
    var title = isObjList(widget.suggestionList)
        ? "${matchers[index][widget.itemTitleBy] ?? matchers[index][widget.searchBy![0]]}"
        : "${matchers[index]}";

    var subTitle = (widget.itemSubtitleBy != null)
        ? "${matchers[index][widget.itemSubtitleBy]}"
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: SuggestionItem(
        key: const Key('suggested.item'),
        disableItemTrailing: widget.disableItemTrailing,
        title: title,
        subTitle: subTitle,
        style: widget.itemStyle,
        onTap: () => onItemTap(matchers[index]),
        onIconTap: () => onTrallingTap(matchers[index]),
      ),
    );
  }

  Widget fieldSuggestion() => CompositedTransformTarget(
        link: _layerLink,
        child: TextField(
          keyboardType: widget.fieldType,
          focusNode: widget.focusNode,
          onChanged: widget.onFieldChanged,
          controller: widget.textController,
          maxLines: (widget.maxLines != null) ? widget.maxLines : 1,
          decoration: (widget.fieldDecoration != null)
              ? widget.fieldDecoration
              : InputDecoration(hintText: widget.hint, labelText: widget.hint),
        ),
      );

  // Get [_suggestionBoxStyle] by listening custom style widget [widget.suggestionBoxStyle].
  Decoration get _suggestionBoxStyle => BoxDecoration(
        color: widget.boxStyle.backgroundColor,
        borderRadius: widget.boxStyle.borderRadius,
        boxShadow: widget.boxStyle.boxShadow,
        border: widget.boxStyle.border,
      );
}
