# Field Suggestion 
[![codecov](https://codecov.io/gh/theiskaa/field_suggestion/branch/develop/graph/badge.svg)](https://codecov.io/gh/theiskaa/field_suggestion)
[![**Package** Version](https://img.shields.io/pub/v/field_suggestion?color=blue)](https://github.com/theiskaa/field_suggestion "Published package version")
[![LICENSE](https://img.shields.io/badge/License-MIT-red.svg)](https://github.com/theiskaa/field_suggestion/blob/develop/LICENSE "Project's LICENSE section")
## Usage and overview
**Require to create a `TextEditingController` and suggestions list, e.g:**

```dart
final emailEditingController = TextEditingController();
// And 
List<String> suggestionList = [
 'test@gmail.com',
 'test1@gmail.com',
 'test2@gmail.com',
];
```
<br/>
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/default.gif" align = "right" height = "200px">

## Basic/Default usage.
```dart
FieldSuggestion(
  textController: emailEditingController,
  suggestionList: suggestionList,
  hint: 'Email',
),
```

## Custom usage.
```dart
FieldSuggestion(
  textController: secondTextController,
  suggestionList: suggestionList,
  fieldDecoration: InputDecoration(
    hintText: "Email",
    enabledBorder: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(),
  ),
  wDivider: true,
  divider: SizedBox(height: 5),
  wSlideAnimation: true,
  slideAnimationStyle: SlideAnimationStyle.LTR,
  slideCurve: Curves.linearToEaseOut,
  animationDuration: Duration(milliseconds: 300),
  suggestionItemStyle: SuggestionItemStyle.WhiteNeumorphismedStyle,
  suggestionBoxStyle: SuggestionBoxStyle(
    backgroundColor: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(.2),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  ),
)
```
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/custom.gif" height = "300px">


---
## Installing

### Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  field_suggestion: ^0.1.1
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

# Contributions
***Feel free to contribute to this project.***

**If you find a bug or want a feature, but don't know how to fix/implement it, please fill an *[issue](https://github.com/theiskaa/field_suggestion/issues)*.** 

**If you fixed a bug or implemented a new feature, please send a *[pull request](https://github.com/theiskaa/field_suggestion/pulls)*.**