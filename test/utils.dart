import 'package:flutter/widgets.dart';
import 'package:mockito/mockito.dart';

// Mock of AnimationController.
class MockAnimationController extends Mock implements AnimationController {
  // Could be changed
  AnimationStatus animationStatus = AnimationStatus.completed;

  @override
  AnimationStatus get status => animationStatus;
}


// Mock of BuildContext.
class MockBuildContext extends Mock implements BuildContext {}
