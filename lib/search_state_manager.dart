//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:flutter/material.dart';

class SearchState<T> {
  /// A async snapshot value of [List] of [T], used as main matchers holder of the state.
  AsyncSnapshot<List<T>> snapshot;

  /// A async snapshot vlaue of [List] of [T] that is the previous state of [snapshot].
  ///
  /// Which is used to keep storing the previous state.
  AsyncSnapshot<List<T>>? previousSnapshot;

  /// An object that identifies the currently active callbacks. Used to avoid
  /// calling setState from stale callbacks, e.g. after disposal of this state,
  /// or after widget reconfiguration to a new Future.
  ///
  /// For more refer to: [FutureBuilder] line: 591 | file: async.dart
  Object? activeCallbackIdentity;

  /// A value holder used to check if we have to call for [future] or not.
  /// If current provided value in the [search] method of [SearchStateManager] is same as [lastInput].
  /// We've to ignore calling and waiting for it.
  String lastInput;

  SearchState({
    required this.snapshot,
    this.previousSnapshot,
    this.activeCallbackIdentity,
    this.lastInput = '',
  });
}

/// A custom [ValueNotifier] implementation for managing [SearchState] via [search] method.
///
/// [future], [onData], [onError], [onLoad], and [onEmptyData] these properties should be
/// imported from [FieldSuggestion.network]'s constructuor.
class SearchStateManager<T> extends ValueNotifier<SearchState<T>> {
  final AsyncSnapshot<List<T>> initialState;
  final Future<List<T>> Function(String input)? future;
  void Function(AsyncSnapshot<List<T>>)? onData;
  void Function(AsyncSnapshot<List<T>>)? onError;
  void Function(AsyncSnapshot<List<T>>)? onLoad;
  void Function(AsyncSnapshot<List<T>>)? onEmptyData;

  SearchStateManager({
    required this.initialState,
    required this.future,
    this.onData,
    this.onError,
    this.onLoad,
    this.onEmptyData,
  }) : super(SearchState(snapshot: initialState));

  /// Search is the main search state manager method that calls [future].
  /// and emits resulted [AsyncSnapshot] to [ValueNotifier].
  ///
  /// Before calling the [future], [value.snapshot]'s state will be updated
  /// with [ConnectionState.waiting].
  Future<void> search(String input) async {
    input = input.trim();
    if (future == null) return;

    if (value.lastInput == input) return;
    value.lastInput = input;
    if (input.isEmpty) return onEmptyData?.call(value.snapshot);

    final prev = value.previousSnapshot;
    if (prev == null || prev.connectionState != value.snapshot.connectionState) {
      value.snapshot = value.snapshot.inState(ConnectionState.waiting);
      notifyListeners();
      onLoad?.call(value.snapshot);
    }

    final Object callbackIdentity = Object();
    value.activeCallbackIdentity = callbackIdentity;

    future!.call(input).then<void>((List<T> data) {
      value.snapshot = AsyncSnapshot<List<T>>.withData(
        ConnectionState.done,
        data,
      );

      // TODO: find a way to compare [value.previousSnapshot] and [value.snapshot] 's data.
      notifyListeners();

      if (data.isEmpty) return onEmptyData?.call(value.snapshot);
      onData?.call(value.snapshot);
    }, onError: (Object error, StackTrace stackTrace) {
      value.snapshot = AsyncSnapshot<List<T>>.withError(
        ConnectionState.done,
        error,
        stackTrace,
      );

      notifyListeners();
      onError?.call(value.snapshot);

      assert(() {
        if (FutureBuilder.debugRethrowError) {
          Future<Object>.error(error, stackTrace);
        }
        return true;
      }());
    });

    // Update the previous value.
    value.previousSnapshot = value.snapshot;
  }
}
