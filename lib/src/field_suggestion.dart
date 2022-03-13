import 'package:flutter/material.dart';

import 'box_controller.dart';
import 'styles.dart';
import 'utils.dart';

/// TODO: Add documentation with ASCI diagram.
class FieldSuggestion extends StatefulWidget {
  /// TODO: Add documentation for itemBuilder.
  final Widget Function(BuildContext, int)? itemBuilder;

  /// TODO: Add documentation for textController.
  final TextEditingController textController;

  /// TODO: Add documentation for suggestions.
  final List<dynamic> suggestions;

  /// TODO: Add documentation for search
  final bool Function(dynamic item, String input) search;

  /// TODO: Add documentation for boxController.
  final BoxController? boxController;

  /// TODO: Add documentation for box style.
  final SuggestionBoxStyle boxStyle;

  /// TODO: Add documentation for inputDecoration.
  final InputDecoration? inputDecoration;

  /// TODO: Add documentation for inputType.
  final TextInputType? inputType;

  /// TODO: Add documentation for focusNode.
  final FocusNode? focusNode;

  /// TODO: Add documentation for maxLines.
  final int? maxLines;

  /// TODO: Add documentation for suggestions scrollController.
  final ScrollController? scrollController;

  /// TODO: Add documentation for divider.
  final Widget? divider;

  /// TODO: Add documentation for spacer.
  final double spacer;

  /// TODO: Add documentation for sizeByItem.
  final int? sizeByItem;

  /// TODO: Add documentation for padding.
  final EdgeInsets padding;

  /// Boolean to disable/enable opacity animation of [SuggestionBox].
  ///
  /// As default it's disabled -> [false].
  final bool wOpacityAnimation;

  /// Boolean to enable/disable slide animation of [SuggestionBox].
  ///
  /// As default it's disabled -> [false].
  final bool wSlideAnimation;

  /// Duration of suggestion box animation.
  ///
  /// As default it's [400 milliseconds].
  final Duration animationDuration;

  /// Rotation slide to determine tween offset of slide animation.
  ///
  /// **Rigth to left [RTL], Left to right [LTR], Bottom to up [BTU], Up to down [UTD].**
  final SlideStyle slideStyle;

  /// Tween offset of slide animation.
  ///
  /// When you use `slideOffset`, then `slideStyle` automatically would be disabled.
  final Tween<Offset>? slideOffset;

  /// Curve for box slide animation.
  ///
  /// As default it's [Curves.decelerate].
  final Curve slideCurve;

  const FieldSuggestion({
    Key? key,
    required this.itemBuilder,
    required this.textController,
    required this.suggestions,
    required this.search,
    this.boxController,
    this.boxStyle = SuggestionBoxStyle.DefaultStyle,
    this.inputDecoration,
    this.inputType,
    this.focusNode,
    this.maxLines,
    this.scrollController,
    this.divider,
    this.spacer = 5.0,
    this.sizeByItem,
    this.padding = const EdgeInsets.all(12),
    this.wOpacityAnimation = false,
    this.wSlideAnimation = false,
    this.animationDuration = const Duration(milliseconds: 400),
    this.slideStyle = SlideStyle.RTL,
    this.slideOffset,
    this.slideCurve = Curves.decelerate,
  }) : super(key: key);

  @override
  _FieldSuggestionState createState() => _FieldSuggestionState(boxController);
}

class _FieldSuggestionState extends State<FieldSuggestion>
    with TickerProviderStateMixin {
  // Initialize BoxController closures.
  _FieldSuggestionState(BoxController? _boxController) {
    if (_boxController == null) return;

    _boxController.close = closeBox;
    _boxController.open = openBox;
    _boxController.refresh = refresh;
  }

  // The main overlay entry. Used to display suggestions' box.
  OverlayEntry? _overlayEntry;

  // List which helps to manage overlays.
  final List<dynamic> _overlaysList = [];

  // [FieldSuggestion] has two main parts:
  // field and suggestions box. LayerLink help us to use them together.
  final LayerLink _layerLink = LayerLink();

  late AnimationController _animationController;
  late Animation<double> _opacity;
  late Animation<Offset>? _slide;

  // To collect and list the [widget.suggestions] elements
  // matching the text of the [widget.textController] in a list.
  List matchers = <dynamic>[];

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

    // Initialize animations, if any animaton tpye was enabled.
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

      // Set slide animations if it was enabled.
      if (widget.wSlideAnimation) {
        _slide = FieldAnimationStyle.setBoxAnimation(
          slideStyle: widget.slideStyle,
          animationController: _animationController,
          slideTweenOffset: widget.slideOffset,
          slideCurve: widget.slideCurve,
        );
      }
    }
  }

  // Searches [input] in [suggestions] list by [search] method.
  void _textListener() {
    final input = widget.textController.text;

    // Should close box if input is empty.
    if (input.isEmpty) return closeBox();

    matchers = widget.suggestions.where((i) {
      return widget.search(i, input.toString());
    }).toList();

    return (matchers.isEmpty) ? closeBox() : openBox();
  }

  // A set-state wrapper to avoid [setState after dispose] error.
  void _mountedSetState(void Function() fn) {
    if (this.mounted) setState(fn);
  }

  // A external call back function used to refresh content state of box.
  // Uses clojure set-state and [_textListener] method to update state.
  void refresh() {
    _mountedSetState(() {});
    _textListener();
  }

  // TODO: Add documentation.
  void openBox() {
    if (_overlayEntry != null && _overlaysList.isNotEmpty) {
      _overlayEntry!.remove();
      _mountedSetState(() => _overlayEntry = null);
    }

    _generateOverlay(context);
    if (widget.wOpacityAnimation || widget.wSlideAnimation) {
      _animationController.forward();
    }
  }

  // TODO: Add documentation.
  void closeBox() {
    if (!(_overlayEntry != null && _overlaysList.isNotEmpty)) return;

    _overlayEntry!.remove();
    if (widget.wOpacityAnimation || widget.wSlideAnimation) {
      _animationController.reverse();
    }

    _mountedSetState(() => _overlayEntry = null);
  }

  // Creates the suggestion box (overlay entry).
  // Appends it to the overlay state and state overlay management list.
  void _generateOverlay(BuildContext context) {
    final _state = Overlay.of(context)!;
    final _size = (context.findRenderObject() as RenderBox).size;

    // Re-append overlay entry.
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: _size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, _size.height + widget.spacer),
          child: _buildSuggestionBox(context),
        ),
      ),
    );

    // Append refreshing functionality of overlay to the animation controller 
    // if one of the animation property was enabled.
    if (widget.wOpacityAnimation || widget.wSlideAnimation) {
      _animationController.addListener(() => _state.setState(() {}));
    }

    // Insert generated overlay entry to overlay stateç
    _state.insert(_overlayEntry!);

    // Add the overlay entry to cleared list.
    _overlaysList.clear();
    _overlaysList.add(_overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    // Layer linking adds normal widget's behaviour to overlay widget.
    // So, it follows [TextField] every time, and behaves as a normal non-hiddable widget.
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        keyboardType: widget.inputType,
        focusNode: widget.focusNode,
        // onChanged: widget.onFieldChanged,
        controller: widget.textController,
        maxLines: widget.maxLines,
        decoration: widget.inputDecoration,
      ),
    );
  }

  // Returns final suggestion box.
  Widget _buildSuggestionBox(BuildContext context) {
    final _box = Opacity(
      opacity: (widget.wOpacityAnimation) ? _opacity.value : 1,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.boxStyle.backgroundColor,
          borderRadius: widget.boxStyle.borderRadius,
          boxShadow: widget.boxStyle.boxShadow,
          border: widget.boxStyle.border,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: Utils.maxBoxHeight(
              matchersList: matchers,
              wDivider: widget.divider != null,
              sizeByItem: widget.sizeByItem,
            ),
          ),
          child: ListView.separated(
            controller: widget.scrollController,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: matchers.length,
            separatorBuilder: (_, __) {
              if (widget.divider != null) return widget.divider!;
              return const SizedBox.shrink();
            },
            itemBuilder: (context, index) {
              final List<int> indexes = matchers.map((e) {
                return widget.suggestions.indexOf(e);
              }).toList();

              return widget.itemBuilder!(context, indexes[index]);
            },
          ),
        ),
      ),
    );

    if (!widget.wSlideAnimation) return Material(child: _box);

    return Material(
      child: SlideTransition(position: _slide!, child: _box),
    );
  }
}
