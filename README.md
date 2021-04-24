# Field Suggestion 
[![codecov](https://codecov.io/gh/theiskaa/field_suggestion/branch/develop/graph/badge.svg)](https://codecov.io/gh/theiskaa/field_suggestion)
[![**Package** Version](https://img.shields.io/pub/v/field_suggestion?color=blue)](https://github.com/theiskaa/field_suggestion "Published package version")
[![LICENSE](https://img.shields.io/badge/License-MIT-red.svg)](https://github.com/theiskaa/insta-like-button/blob/main/LICENSE "Project's LICENSE section")

---
## Installing

### Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  field_suggestion: ^0.1.0
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
## About
`FieldSuggestion` help us to make type ahead fields. It takes a `TextEditingController` & suggestions list and
listens values of given TextEditingController and checks if the given value is in the list or not. 

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
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/docs/example/assets/default.gif" align = "right" height = "200px">

## Basic/Default usage.
```dart
FieldSuggestion(
  textController: emailEditingController,
  suggestionList: suggestionList,
  hint: 'Email',
),
```
---
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

### Result of custom usage: 
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/docs/example/assets/custom.gif" height = "300px">

To get more about `FieldSuggestion` check [example folder/repo](https://github.com/theiskaa/field_suggestion/example).


# Contributions
***Feel free to contribute to this project.***

**If you find a bug or want a feature, but don't know how to fix/implement it, please fill an *[issue](https://github.com/theiskaa/field_suggestion/issues)*.** <br/>
**If you fixed a bug or implemented a new feature, please send a *[pull request](https://github.com/theiskaa/field_suggestion/pulls)*.**