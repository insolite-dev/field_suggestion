# Field Suggestion 
[![codecov](https://codecov.io/gh/theiskaa/field_suggestion/branch/develop/graph/badge.svg)](https://codecov.io/gh/theiskaa/field_suggestion)
[![**Package** Version](https://img.shields.io/pub/v/field_suggestion?color=blue)](https://github.com/theiskaa/field_suggestion "Published package version")
[![LICENSE](https://img.shields.io/badge/License-MIT-red.svg)](https://github.com/theiskaa/field_suggestion/blob/develop/LICENSE "Project's LICENSE section")

---
## Installing

### Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  field_suggestion: <latest_version>
```

### Install it

You can install packages from the command line:

```sh
$ flutter pub get
```
### Import it

Now in your Flutter code, you can use:

```dart
import 'package:field_suggestion/field_suggestion.dart';
```
---


# Usage and overview
**Require to create a `TextEditingController` and suggestions list, e.g:**

```dart
final textEditingController = TextEditingController();
// And 
List<String> suggestionList = [
 'test@gmail.com',
 'test1@gmail.com',
 'test2@gmail.com',
];
```


## Basic/Default usage.
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/default.gif" align = "right" height = "200px">

```dart
FieldSuggestion(
  textController: textEditingController,
  suggestionList: suggestionList,
  hint: 'Email',
),
```

---

## Custom usage.
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/custom.gif" align = "right" height = "230px">

```dart
FieldSuggestion(
  textController: textEditingController,
  suggestionList: suggestionList,
  fieldDecoration: InputDecoration(
    hintText: "Email",
    enabledBorder: const OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(),
  ),
  wDivider: true,
  divider: const SizedBox(height: 5),
  wSlideAnimation: true,
  slideAnimationStyle: SlideAnimationStyle.LTR,
  slideCurve: Curves.linearToEaseOut,
  animationDuration: const Duration(milliseconds: 300),
  suggestionItemStyle: SuggestionItemStyle.WhiteNeumorphismedStyle,
  suggestionBoxStyle: SuggestionBoxStyle(
    backgroundColor: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(.2),
        spreadRadius: 5,
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  ),
)
```

## External control
Here we just wrapped our `Scaffold` with `GestureDetector` to handle gestures on the screen.
And now we can close box when we tap on the screen. (You can do it everywhere, where you used `FieldSuggestion` with `BoxController`).

<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/external-control.gif" align = "right" height = "250px">

```dart
 class Example extends StatelessWidget {
   final _textController = TextEditingController();
   final _boxController = BoxController();
 
   @override
   Widget build(BuildContext context) {
     return GestureDetector(
       onTap: () => _boxController.close(),
       child: Scaffold(
         body: Center(
           child: FieldSuggestion(
             hint: 'test',
             suggestionList: [], // Your suggestions list here...
             boxController: _boxController,
             textController: _textController,
           ),
         ),
       ),
     );
   }
 }
```

# Contributions
**If you find a bug or want a feature, but don't know how to fix/implement it, please fill an *[issue](https://github.com/theiskaa/field_suggestion/issues)*.**

**If you fixed a bug or implemented a new feature, please send a *[pull request](https://github.com/theiskaa/field_suggestion/pulls)*.**
