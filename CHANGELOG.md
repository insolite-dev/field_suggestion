# [v0.2.2] - 14/10/2021
### News:
- Resolved: [General Improvments #36](https://github.com/theiskaa/field_suggestion/issues/36)
- Re-designed logo: 

 <img width="150" src="https://user-images.githubusercontent.com/59066341/137347177-c6800b7b-3725-4cdf-952d-e7f5bfdab0b1.png" alt="Field Suggesion's Logo">

Clear code & faster field suggestion.

---

# [v0.2.1] - 04/10/2021
### News:
- Resolved: [#34](https://github.com/theiskaa/field_suggestion/issues/34)
- Improved documentation - [Official Documentation](https://github.com/theiskaa/field_suggestion/wiki)

**Overview:**

Now we can use our own searching strategies/functionalities instead of using default contains functionality.

And now we have cleaner and better documentation

---

# [v0.2.0] - 17/08/2021
### News:
- Resolved: [#31](https://github.com/theiskaa/field_suggestion/issues/31)
- Published special package - [highlightable](https://pub.dev/packages/highlightable)

**Overview**
<img width="300" src="https://user-images.githubusercontent.com/59066341/129528482-910218f8-5b96-4608-a10a-eddd625c6f25.gif" alt="Example From Medium Article">

---

# [v0.1.9] - 27/07/2021
### News:

- Resolved: [#29](https://github.com/theiskaa/field_suggestion/issues/29)

**Features/Bug-fixes**:
- Added refresh functionality to BoxController
- Fixed `closeBoxAfterCompleting` problem
- Added functionality, which automatically moves indicator to text's right position when suggestion item is selected

**Example of the main issue-resolving:**
Need a boxController first of all. Create it and give it to the suggestion field. Then just call `boxController.refresh!()` when you want to update your FieldSuggestion widget.

**Overview**:
<img src="https://user-images.githubusercontent.com/59066341/127190309-5b93c3ef-9118-4767-8ff1-0292f82d07ac.gif" height = "230px">

---

# [v0.1.8] - 26/07/2021
### News:

- Resolved: [#26](https://github.com/theiskaa/field_suggestion/issues/26)

**Features**:
- Added builder factory (i.e FielsSuggestion.builder)
By using builder users can make custom suggestion items. So that improves the package's UI/UX.
Now it has more ability to customize as we wish. So that means

**Overview**:
<img src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/builder.gif" height = "200px">

---

# [v0.1.7] - 5/07/2021

### News:

- Resolved: [#22](https://github.com/theiskaa/field_suggestion/issues/22) and [#23](https://github.com/theiskaa/field_suggestion/issues/23)

**Features**:
- onItemSelected property added
- subtitle added for suggestion item.
- searchBy converted to list so that's mean users are able to give mutiple properties to search. [See more.](https://github.com/theiskaa/field_suggestion/pull/25)

---

# [v0.1.6] - 19/06/2021
### News:
- Logo was redesigned 🎉 New logo: 
 <img width="150" src="https://raw.githubusercontent.com/theiskaa/field_suggestion/develop/example/assets/logo.png" alt="Field Suggesion's Logo">

- Resolved: [#20](https://github.com/theiskaa/field_suggestion/issues/20)
  Now users are able to customize suggestion item much more than v0.1.5

  See the [readme](https://github.com/theiskaa/field_suggestion#custom-usage) to get more info.

---
# [v0.1.5] - 8/06/2021
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

---

# [v0.1.4] - 5/06/2021
- Resolved [#17](https://github.com/theiskaa/field_suggestion/issues/17)
And now the `suggestionList` property can be `List<String>`, `List<int>`, `List<double>`.
See the [README.md](https://github.com/theiskaa/field_suggestion/blob/develop/README.md#custom-usage) for more.

---
# [v0.1.3] - 30/05/2021
- **Enabled null safety**

---
# [v0.1.2] - 30/05/2021
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
---

# [v0.1.0] and [v0.1.1] - 30/04/2021
- **First releases**


