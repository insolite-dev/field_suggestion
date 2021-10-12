import 'package:flutter/material.dart';

import 'box_controller.dart';
import 'styles.dart';
import 'suggestion_item.dart';
import 'utils.dart';
import 'errors.dart';

/// FieldSuggestion is a widget that creates highly customizable, simple, and controllable autocomplete fields.
///
/// Require to take `textController` and `suggestionList`.
///
/// `textController` listens changing on the field,
/// and after listening it's create a custom matchers list, which is would come with `SuggestionBox`.
///
/// **Basic usage:**
/// ```dart
///  FieldSuggestion(
///   textController: _textEditingController,
///   suggestionList: suggestionList,
/// ),
/// ```
///
/// **Read the [official documentation](https://github.com/theiskaa/field_suggestion/wiki) to learn and understand [FieldSuggestion].**
class FieldSuggestion extends StatefulWidget {
  /// The main text editing controller.
  ///
  /// Used to listen field's value changes.
  final TextEditingController textController;

  /// The main list which would be displayed into suggestion box.
  /// Able to use as `List<String>`, `List<int>`, `List<double>` and Custom model class. e.g: `List<UserModel>`
  ///
  /// Article about FieldSuggestion's custom model classes: - https://github.com/theiskaa/field_suggestion/wiki/Class-suggestions
  final List<dynamic> suggestionList;

  /// It must be initilazed when `suggestionList` isn't `List<String>`, `List<int>`, or `List<double>`.
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

  /// As default, when you select any item from suggestions, it only fills text field with selected item's value.
  /// So, `onItemSelected` is a property that used to customize suggestion selection's act.
  ///
  /// Example:
  /// ```dart
  /// onItemSelected: (value) => print(value);
  /// ```
  /// Or
  /// ```dart
  /// onItemSelected: (value) => Navigator.push(...)
  /// ```
  final Function(dynamic)? onItemSelected;

  /// A controller for FieldSuggestion.
  ///
  /// By using it you can open/close your suggestions box externally. (From anywere, where you have access to initilazed box controller)
  /// And also can refresh state of your FieldSuggestion with it.
  ///
  /// For more information refer to the article about External Control - https://github.com/theiskaa/field_suggestion/wiki/External-control
  final BoxController? boxController;

  /// For calucalte size of suggestionBox by per item.
  /// So if `sizeByItem == 1` then size will be `60`.
  /// The number increases in parallel so when `sizeByItem == 2` then size of suggestionBox will be `120`. And so on ...
  final int? sizeByItem;

  /// `wDivider` if it equeals `true`,
  /// User would see a simple line, every suggestionItem's front.
  final bool wDivider;

  /// It appears only then, if `wDivider` setted to true.
  ///
  /// As default it is normal `Divider()`. So by using `divider` property you can customize it.
  final Widget divider;

  /// Sets size between field and suggestionsBox.
  /// As default it is `5.0`. (Can be imagined as *height* between field and suggestionsBox).
  final double spacer;

  /// Style of suggestion box.
  ///
  /// It takes [SuggestionBoxStyle.DefaultStyle] as default.
  /// Able to set as Custom, like this:
  /// ```dart
  /// SuggestionBoxStyle(...)
  /// /// With following properties:  [backgroundColor], [border], [borderRadius], [gradient], [boxShadow], [padding], [shape].
  /// ```
  final SuggestionBoxStyle boxStyle;

  /// **Style of suggestion item.**
  ///
  /// It takes, [SuggestionItemStyle.DefaultStyle] as default.
  /// Able to set as Custom, like this:
  /// ```dart
  /// SuggestionItemStyle(...)
  /// // With following properties:  [backgroundColor], [titleStyle], [icon], [iconSize], [iconColor], [border], [borderRadius], [gradient], [boxShadow], [margin].
  /// ```
  /// **Also able to set by ready designs, e.g:**
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

  /// [InputDecoration] for field.
  final InputDecoration? fieldDecoration;

  /// The input type of field.
  final TextInputType? fieldType;

  /// [FocusNode] of field.
  final FocusNode? focusNode;

  /// `onChanged` method of field.
  final Function(String)? onFieldChanged;

  /// `maxLines` property of field
  final int? maxLines;

  /// As we know, field has it's default onTap function. Which, just fills text field with selected item's value.
  ///
  /// So, to disable that method. setting `disabledDefaultOnTap` to `true` is enough.
  final bool disabledDefaultOnTap;

  /// Boolean property to decide close or not suggestion box after selecting the item.
  ///
  /// As default it is `true`. So, we do close after selecting the item.
  final bool closeBoxAfterSelect;

  /// The scroll controller fo `suggestionList`.
  final ScrollController? scrollController;

  /// Boolean property to disable/enable opacity animation.
  ///
  /// As default is disabled, so `false`.
  final bool wOpacityAnimation;

  /// Duration of suggestion box animation.
  ///
  /// As default it is `Duration(milliseconds: 800)`
  final Duration animationDuration;

  /// Boolean to enable/disable slide animtaion of [SuggestionBox].
  ///
  ///  As default it is disabled, so `false`.
  final bool wSlideAnimation;

  /// Custom enum to set tween offset of slide animation.
  ///
  /// **Rigth to left [RTL], Left to right [LTR], Bottom to up [BTU], Up to down [UTD].**
  final SlideStyle slideStyle;

  /// Custom curve for box's slide animation.
  ///
  /// As default it is [Curves.decelerate].
  final Curve slideCurve;

  /// Tween for suggestion box's slide animation.
  ///
  /// **Note:** when you use `slideTweenOffset`, automatically `slideAnimationStyle` would be disabled.
  final Tween<Offset>? slideTweenOffset;

  /// Should be used as `FieldSuggestion.builder(...)`.
  final Widget Function(BuildContext, int)? itemBuilder;

  /// Makes able to implement custom searching/sorting functionality, instead of default contains fun.
  ///
  /// Recivies item and current input of user. Then you have to return a non-nullable boolean value.
  /// You could do comparing with item and input. Or even return your own custom value.
  ///
  /// For more information refer to the [Tips and Tricks of FieldSuggestion](https://github.com/theiskaa/field_suggestion/wiki/Tips-and-Tricks).
  final bool Function(dynamic, String)? customSearch;

  const FieldSuggestion({
    Key? key,
    required this.textController,
    required this.suggestionList,
    this.searchBy,
    this.itemBuilder,
    this.customSearch,

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
    this.slideStyle = SlideStyle.RTL,

    // SuggestionItem properties.
    this.itemStyle = SuggestionItemStyle.DefaultStyle,
    this.onItemSelected,
    this.disabledDefaultOnTap = false,
    this.scrollController,

    // FieldSuggestion properties.
    this.fieldDecoration,
    this.fieldType,
    this.maxLines = 1,
    this.onFieldChanged,
    this.focusNode,
  }) : super(key: key);

  @override
  _FieldSuggestionState createState() => _FieldSuggestionState(boxController);

  /// Builder factory of FieldSuggestion.
  /// Makes able to create very custom suggestion items.
  ///
  /// Require to take `suggestionList`, `textController`, and `itemBuilder`.
  ///
  /// For more information refer to the documentation of [Builder Factory](https://github.com/theiskaa/field_suggestion/wiki/Builder-factory)
  factory FieldSuggestion.builder({
    Key? key,
    required List<dynamic> suggestionList,
    required TextEditingController textController,
    required Widget Function(BuildContext, int) itemBuilder,
    BoxController? boxController,
    List<String>? searchBy,
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
    SlideStyle slideStyle = SlideStyle.RTL,
    Curve slideCurve = Curves.decelerate,
    Tween<Offset>? slideTweenOffset,
    bool closeBoxAfterSelect = true,
    bool Function(dynamic, String)? customSearch,
  }) {
    return FieldSuggestion(
      key: key,
      itemBuilder: itemBuilder,
      textController: textController,
      suggestionList: suggestionList,
      boxController: boxController,
      searchBy: searchBy,
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
      slideStyle: slideStyle,
      slideCurve: slideCurve,
      slideTweenOffset: slideTweenOffset,
      closeBoxAfterSelect: closeBoxAfterSelect,
      customSearch: customSearch,
    );
  }
}

class _FieldSuggestionState extends State<FieldSuggestion>
    with TickerProviderStateMixin {
  // Initialize BoxController closures.
  _FieldSuggestionState(BoxController? _boxController) {
    if (_boxController != null) {
      _boxController.close = closeBox;
      _boxController.open = openBox;
      _boxController.refresh = refresh;
    }
  }

  // The main overlay entry. Used to display suggestions box.
  OverlayEntry? _overlayEntry;

  // List which helps to manage overlays.
  final List<dynamic> _overlaysList = [];

  // [FieldSuggestion] has two main parts:
  // field and suggestions box. LayerLink help us to use them together.
  final LayerLink _layerLink = LayerLink();

  late AnimationController _animationController;
  late Animation<double> _opacity;
  Animation<Offset>? _slide;

  // To collect and list the [widget.suggestionList] elements
  // matching the text of the [widget.textController] in a list.
  List<dynamic> matchers = <dynamic>[];

  // Used to find right index of concrete item when it's object.
  // We return it on ln 702-704.
  List<dynamic> objectSuggestionsAsJson = <dynamic>[];

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

    // Initilaze animations, if any animaton tpye was enabled.
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

      // Set slide animations if it was enalbed.
      if (widget.wSlideAnimation) {
        _slide = FieldAnimationStyle.chooseBoxAnimation(
          slideStyle: widget.slideStyle,
          animationController: _animationController,
          slideTweenOffset: widget.slideTweenOffset,
          slideCurve: widget.slideCurve,
        );
      }
    }
  }

  // Basically, used to avoid "setState() called after dispose()" issue.
  void _mountedSetState(void Function() fn) {
    if (this.mounted) return setState(fn);
  }

  // Used to refresh state/view.
  // Basically, just calls _textListener function, because it's enough to reset/refresh FieldSuggestion.
  // Also used as BoxController's refresh function.
  void refresh() {
    _mountedSetState(() {});
    _textListener();
  }

  void _textListener() {
    final input = widget.textController.text;

    bool isMatcherSelected = isSelected(
      widget.suggestionList,
      input,
      matchers,
      widget.searchBy ?? [],
    );

    if (widget.textController.text.length == 0 || isMatcherSelected) {
      closeBox();
      if (isMatcherSelected) {
        widget.textController.selection = TextSelection.fromPosition(
          TextPosition(offset: input.length),
        );
      }
      return;
    }

    if (isObjList(widget.suggestionList)) {
      // Refresh objectSuggestionsAsJson if something was changed in widget.suggestionList.
      if (widget.suggestionList.length != objectSuggestionsAsJson.length) {
        objectSuggestionsAsJson =
            widget.suggestionList.map((e) => e.toJson().toString()).toList();
      }

      // At this time, `searchBy` and `customSearch` must not be null.
      // Because renderObjList (which fill's matchers) must have [searchBy] properties,
      // Or if [searchBy] is empty then [customSearch] must be not null.
      // Because if [customSearch] isn't implemented, widget need to know which properties to search by.
      if (widget.searchBy == null && widget.customSearch == null) {
        throw FlutterError(Errors.searchByORcustomSearchIsNull);
      }

      matchers = renderObjList(
        widget.suggestionList,
        input,
        searchBy: widget.searchBy,
        customSearch: widget.customSearch,
      );
    } else {
      matchers = widget.suggestionList.where((item) {
        // If we call toUperrCase on int or on double then we'll get error.
        // So that's why we check type of list and return suitable method.
        if (widget.suggestionList is List<int> ||
            widget.suggestionList is List<double>) {
          // If custom search was enabled, checks matching from custom search function.
          if (widget.customSearch != null) {
            return widget.customSearch!(item.toString(), input.toString());
          }

          // Default searching style. Returns if [item] contains [input].
          return item.toString().contains(input.toString());
        }

        // If custom search was enabled, checks matching from custom search function.
        if (widget.customSearch != null) {
          return widget.customSearch!(item.toUpperCase(), input.toUpperCase());
        }

        return item.toUpperCase().contains(input.toUpperCase());
      }).toList();
    }

    return (matchers.isNotEmpty) ? openBox() : closeBox();
  }

  @override
  Widget build(BuildContext context) {
    // Layer linking adds normal widget's behaviour to overlay widget.
    // So, it follows [TextField] every time, and behaves as a normal non-hiddable widget.
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        keyboardType: widget.fieldType,
        focusNode: widget.focusNode,
        onChanged: widget.onFieldChanged,
        controller: widget.textController,
        maxLines: widget.maxLines,
        decoration: widget.fieldDecoration,
      ),
    );
  }

  // Function, that used to open suggestions box.
  // First it clears _overlayEntry and creates new one.
  void openBox() {
    if (_overlayEntry != null && _overlaysList.isNotEmpty) {
      _overlayEntry!.remove();
      _mountedSetState(() => _overlayEntry = null);
    }
    _createOverlay(context);
    if (widget.wOpacityAnimation || widget.wSlideAnimation) {
      _animationController.forward();
    }
  }

  // Function, that used to close suggestions box.
  // It just clears/removes overlay entry, and as a result box closes.
  void closeBox() {
    if (_overlayEntry != null && _overlaysList.isNotEmpty) {
      _overlayEntry!.remove();

      if (widget.wOpacityAnimation || widget.wSlideAnimation) {
        _animationController.reverse();
      }
      _mountedSetState(() => _overlayEntry = null);
    }
  }

  // Default `onItemSelected` function.
  // It fills field with value of selected item.
  // And if `closeBoxAfterSelect` is enabled (as default it's enabled), it closes suggestions box after selecting the item.
  onItemSelected(dynamic selectedItem) {
    if (widget.disabledDefaultOnTap) {
      if (widget.onItemSelected != null) widget.onItemSelected!(selectedItem);
      return;
    }

    _mountedSetState(() {
      if (!isObjList(widget.suggestionList)) {
        widget.textController.text = selectedItem.toString();
      } else {
        widget.textController.text =
            selectedItem['${widget.searchBy![0]}'].toString();
      }

      widget.textController.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.textController.text.length),
      );
    });

    if (widget.onItemSelected != null) widget.onItemSelected!(selectedItem);
    if (widget.closeBoxAfterSelect) closeBox();
  }

  // Creates suggestion box as overlay entry, and puts it to general `_overlayEntry`.
  // We use `_overlaysList` to manage all overlays in this state.
  void _createOverlay(BuildContext context) {
    // Takes size from context's renderbox
    final Size size = (context.findRenderObject() as RenderBox).size;

    final OverlayState _overlayState = Overlay.of(context)!;

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

  // Returns final suggestion box.
  Widget _buildSuggestionBox(BuildContext context) {
    Widget _suggestionBox = Opacity(
      opacity: (widget.wOpacityAnimation) ? _opacity.value : 1,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _suggestionBoxStyle,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
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
            separatorBuilder: (_, __) {
              if (widget.wDivider) return widget.divider;
              return const SizedBox.shrink();
            },
            itemBuilder: (_, i) {
              // Return default list items, when item builder is null.
              if (widget.itemBuilder == null) return suggestionListItem(i);

              // We need indexes to determine right index of concrete item to pass it to builder.
              final List<int> indexes = matchers.map((e) {
                // If suggestion list isn't Object list then just return index of current element.
                if (!isObjList(widget.suggestionList)) {
                  return widget.suggestionList.indexOf(e);
                }

                return objectSuggestionsAsJson.indexOf(e.toString());
              }).toList();

              return widget.itemBuilder!(context, indexes[i]);
            },
          ),
        ),
      ),
    );

    if (!widget.wSlideAnimation) return Material(child: _suggestionBox);

    return Material(
      child: SlideTransition(position: _slide!, child: _suggestionBox),
    );
  }

  /// A card which returns suggestion item widget.
  /// It used in ListView builder so it has ability to fill its data by given index/
  Widget suggestionListItem(int index) {
    // If suggestion list contains objects then it will return title from searchBy's first item.
    // Unless it will return directly a title from matchers list.
    var title = isObjList(widget.suggestionList)
        ? "${matchers[index][widget.searchBy![0]]}"
        : "${matchers[index]}";

    return SuggestionItem(
      key: const Key('suggested.item'),
      title: title,
      style: widget.itemStyle,
      onTap: () => onItemSelected(matchers[index]),
    );
  }

  // Get [_suggestionBoxStyle] by listening custom style widget [widget.suggestionBoxStyle].
  Decoration get _suggestionBoxStyle {
    return BoxDecoration(
      color: widget.boxStyle.backgroundColor,
      borderRadius: widget.boxStyle.borderRadius,
      boxShadow: widget.boxStyle.boxShadow,
      border: widget.boxStyle.border,
    );
  }
}
