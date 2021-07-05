# [v0.1.7] - 5/07/21
### News:

- Resolved: [#22](https://github.com/theiskaa/field_suggestion/issues/22) and [#23](https://github.com/theiskaa/field_suggestion/issues/23)

**Features**:
- onItemSelected property added
- subtitle added for suggestion item.
- searchBy converted to list so that's mean users are able to give mutiple properties to search. [See more.](https://github.com/theiskaa/field_suggestion/pull/25)

# [v0.1.6] - 19/06/21
### News:
- Logo was redesigned 🎉 New logo: 
 <img width="150" src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/logo.png" alt="Field Suggesion's Logo">

- Resolved: [#20](https://github.com/theiskaa/field_suggestion/issues/20)
  Now users are able to customize suggestion item much more than v0.1.5

  See the [readme](https://github.com/theiskaa/field_suggestion#custom-usage) to get more info.
# [v0.1.5] - 8/06/21
### News:
- FieldSuggestion logo is ready! 🎉

  <img width="150" src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/logo.png" alt="Field Suggesion's Logo">

- Resolved: [#19](https://github.com/theiskaa/field_suggestion/issues/19)
New feature: A model class suggestions.

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
# [v0.1.4] - 5/06/21
- Resolved [#17](https://github.com/theiskaa/field_suggestion/issues/17)
And now the `suggestionList` property can be `List<String>`, `List<int>`, `List<double>`.
See the [README.md](https://github.com/theiskaa/field_suggestion/blob/develop/README.md#custom-usage) for more.
# [v0.1.3] - 30/05/21
- **Enabled null safety**
# [v0.1.2] - 30/05/21
### News: 
- Tests were improved. current coverage:
 [![codecov](https://codecov.io/gh/theiskaa/field_suggestion/branch/develop/graph/badge.svg)](https://codecov.io/gh/theiskaa/field_suggestion)

- Resolved: [#13](https://github.com/theiskaa/field_suggestion/issues/13) 
  New feature: **External control.**
now users can control the suggestion boxes externally. 

### Example of external control:

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

# [v0.1.0] and [v0.1.1] - 30/04/21
- **First release**


