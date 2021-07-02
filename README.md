<p align="center">
  <img width="250" src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/logo.png" alt="Field Suggesion's Logo">
</p>

 <p align="center">
  <div align="center">
  <a href="https://codecov.io/gh/theiskaa/field_suggestion">
    <img src="https://codecov.io/gh/theiskaa/field_suggestion/branch/develop/graph/badge.svg"
      alt="Coverage" />
  </a>
    <a href="https://github.com/theiskaa/field_suggestion/blob/develop/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-red.svg"
      alt="License: MIT" />
  </a>
  <br>
    <a href="https://pub.dev/packages/field_suggestion">
    <img src="https://img.shields.io/pub/v/field_suggestion?color=blue"
      alt="pub version" />
  </a>
  <a href="https://github.com/theiskaa/field_suggestion/releases">
    <img src="https://img.shields.io/github/v/release/theiskaa/field_suggestion?label=last%20release"
      alt="last release" />
  </a>
  <a href="https://github.com/theiskaa/anon/stargazers">
    <img src="https://img.shields.io/github/stars/theiskaa/field_suggestion?label=%20stargazers&style=social"
      alt="Stars" />
  </a> 
</div><br>

# Usage & Overview

Make ready your home widget by creating required options for FieldSuggestion.
```dart
final textEditingController = TextEditingController();

// And 
List<String> suggestionList = [
 'test@gmail.com',
 'test1@gmail.com',
 'test2@gmail.com',
];

// Or
List<int> numSuggestions = [
  13187829696,
  13102743803,
  15412917703,
];

// Or 
// Note: Take look at [Class suggestions] part.
List<UserModel> userSuggestions = [
  UserModel(email: 'test@gmail.com', password: 'test123'),
  UserModel(email: 'test1@gmail.com', password: 'test123'),
  UserModel(email: 'test2@gmail.com', password: 'test123')
];
```


## Basic usage.
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/default.gif" align = "right" height = "200px">

```dart
FieldSuggestion(
  textController: textEditingController,
  suggestionList: suggestionList,
  hint: 'Email',
),
```

## Custom usage.
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/custom.gif" align = "right" height = "230px">

```dart
FieldSuggestion(
  textController: secondTextController,
  suggestionList: numSuggestions,
  boxController: secondBoxController,
  onItemSelected: (value) {
    // Do Something...
  },
  fieldDecoration: InputDecoration(
    hintText: "Phone Number",
    enabledBorder: const OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(),
  ),
  wDivider: true,
  divider: const SizedBox(height: 5),
  wSlideAnimation: true,
  slideAnimationStyle: SlideAnimationStyle.LTR,
  slideCurve: Curves.linearToEaseOut,
  animationDuration: const Duration(milliseconds: 300),
  itemStyle: SuggestionItemStyle(
    leading: const Icon(Icons.person),
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      const BoxShadow(
        blurRadius: 1,
        spreadRadius: 1,
        offset: Offset(0, 2),
        color: Color(0xffD5D5D5),
      ),
    ],
  ),
  disableItemTrailing: true,
  boxStyle: SuggestionBoxStyle(
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
),
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

## Class suggestions
`UserModel` class, we would use it into `suggestionList`.
**Note:** You must have `toJson` method in your model class.
```dart
class UserModel {
  final String? email;
  final String? password;

  const UserModel({this.email, this.password});

  // If we wanna use this model class into FieldSuggestion.
  // Then we must have toJson method, like this:
  Map<String, dynamic> toJson() => {
        'email': this.email,
        'password': this.password,
      };
}
```
If we gave a `userSuggestions` which is `List<UserModel>`. 
Then we must add the `searchBy` property.
Our model has just *email* and *password*, right? So then we can implement it like:
`searchBy: 'email'` or `searchBy: 'password'`.
```dart
FieldSuggestion(
  hint: 'Email',
  textController: textEditingController,
  suggestionList: userSuggestions,
  searchBy: 'email' // Or 'password'
),
```


# Contributions
**If you find a bug or want a feature, but don't know how to fix/implement it, please fill an *[issue](https://github.com/theiskaa/field_suggestion/issues)*.**

**If you fixed a bug or implemented a new feature, please send a *[pull request](https://github.com/theiskaa/field_suggestion/pulls)*.**
