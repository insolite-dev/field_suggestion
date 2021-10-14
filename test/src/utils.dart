import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart';

// Mock of AnimationController.
class MockAnimationController extends Mock implements AnimationController {
  // Can be changed
  AnimationStatus animationStatus = AnimationStatus.completed;

  @override
  AnimationStatus get status => animationStatus;
}
