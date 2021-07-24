<p align="center">
  <img width="250" src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/logo.png" alt="Field Suggesion's Logo">
</p>

 <p align="center">
  <div align="center">
  <a href="https://pub.dev/packages/field_suggestion">
    <img src="https://img.shields.io/pub/v/field_suggestion?color=blue"
      alt="pub version" />
  </a>
  <a href="https://github.com/theiskaa/field_suggestion/blob/develop/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-red.svg"
      alt="License: MIT" />
  </a>
  <a href="https://codecov.io/gh/theiskaa/field_suggestion">
    <img src="https://codecov.io/gh/theiskaa/field_suggestion/branch/develop/graph/badge.svg"
      alt="Coverage" />
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
  UserModel(email: 'test@gmail.com', username: 'user1', password: '1234567'),
  UserModel(email: 'test1@gmail.com', username: 'user2', password: 'test123'),
  UserModel(email: 'test2@gmail.com', username: 'user3', password: 'test123')
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

## Builder
Also you can create your own suggestionItems by using `FieldSuggestion.builder()`.
Require to take `suggestionList`, `textController`, and `itemBuilder`.

<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/external-control.gif" align = "right" height = "300px">

```dart
class BuilderExample extends StatelessWidget {
  final textEditingController = TextEditingController();
  List<String> suggestionsList = ['test@gmail.com', 'test1@gmail.com'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FieldSuggestion.builder(
        hint: 'Email',
        textController: textEditingController,
        suggestionList: suggestionsList,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => textEditingController.text = suggestionsList[index],
            child: Card(
              child: ListTile(
                title: Text(suggestionsList[index]),
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(suggestionsList[index][0].toUpperCase()),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
```


## External control
Here we just wrapped our `Scaffold` with `GestureDetector` to handle gestures on the screen.
And now we can close box when we tap on the screen. (You can do it everywhere, where you used `FieldSuggestion` with `BoxController`).

<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/builder.gif" align = "right" height = "250px">

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
  final String? username;
  final String? password;

  const UserModel({this.email, this.username, this.password});

  // If we wanna use this model class into FieldSuggestion,
  // then we must to have toJson method. Like that:
  Map<String, dynamic> toJson() => {
        'email': this.email,
        'username': this.username,
        'password': this.password,
      };
}
```
If we gave a `userSuggestions` which is `List<UserModel>`. 
Then we must add the `searchBy` property. Otherwise we will get an error like:

`If given suggestionList's runtimeType isn't List<String>, List<int> or List<double>. That means, you was gave a List which includes dart classes. So then [searchBy] can't be null.`

Our model has *email*, *username*, and *password*, right? So then we can implement it like:
`searchBy: ['email']` or `searchBy: ['email', 'username']`.

<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/obj-list.gif" align = "right" height = "250px">

```dart
FieldSuggestion(
  hint: 'Email',
  // If y're using list where are classes,
  // Don't forget adding search by property.
  searchBy: ['email', 'username'],
  itemTitleBy: 'username',
  // If you provide [itemSubtitleBy] then suggestion 
  // item's subtitle automaticallty will be enabled.
  itemSubtitleBy: 'email',
  boxController: thirdBoxController,
  textController: thirdTextController,
  suggestionList: userSuggestions,
  onItemSelected: (value) {
    // The field suggestion needs toJson mehtod inside your model right?
    // So that's mean it converts your model to json.
    // Then the output has to be JSON (Map). So now we can get our value's email.
    print(value['passoword']);
  },
),
```

## Contributing
For information regarding contributions, please refer to [CONTRIBUTING.md](https://github.com/theiskaa/field_suggestion/blob/develop/CONTRIBUTING.md) file.
