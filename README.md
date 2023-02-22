<!-- 
LOGO: https://user-images.githubusercontent.com/59066341/137347177-c6800b7b-3725-4cdf-952d-e7f5bfdab0b1.png 
TITLE LOGO: https://user-images.githubusercontent.com/59066341/137352996-0d132ee0-0fe3-42da-90c4-f477ffa91228.png
-->

<p align="center">
  <br>
  <img width="320" src="https://user-images.githubusercontent.com/59066341/137347177-c6800b7b-3725-4cdf-952d-e7f5bfdab0b1.png" alt="Field Suggesion's Logo">
  <br>
  <br>
  <img width="380" src="https://user-images.githubusercontent.com/59066341/137352996-0d132ee0-0fe3-42da-90c4-f477ffa91228.png" alt="Field Suggesion's Title Logo">
  <br>
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

## Installing
- See the official installing guidline from [field_suggestion/install](https://github.com/insolite-dev/field_suggestion/wiki/Installing)

## Usage

- For more detailed examples refer to the official documentation from [field_suggestion/wiki](https://github.com/insolite-dev/field_suggestion/wiki)

In this example, we're using the `FieldSuggestion.network` widget to display suggestions for a username input field. We've provided an `inputDecoration` with a hint text, a `future` function that fetches the suggestions based on the user input, a `textController` that controls the text in the input field, a `boxController` that controls the visibility of the suggestion box, and a builder function that defines how the suggestions are displayed in the suggestion box.

Note that `FieldSuggestion` uses generics to allow for suggestions of different types. In the example above, we're using `String` as the type parameter for `FieldSuggestion.network` However, any other type can be used, depending on the type of suggestions being displayed.

<img align=right height=250px width=400px src="https://user-images.githubusercontent.com/59066341/220667553-d4d83c93-6e15-424c-b2d5-7a221f30069c.gif">

```dart
FieldSuggestion<String>.network(
  inputDecoration: InputDecoration(
    hintText: 'Username', // optional
  ),
  future: (input) => future.call(input),
  textController: controller,
  boxController: boxController, // optional
  builder: (context, snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return Center(child: CircularProgressIndicator());
    }

    final result = snapshot.data ?? [];
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() => controller.text = result[index]);
            boxControllerNetwork.close?.call();
          },
          child: Card(child: ListTile(title: Text(result[index]))),
        );
      },
    );
  },
)
```

## Contributing
- For information regarding contributions, please refer to [CONTRIBUTING.md](https://github.com/theiskaa/field_suggestion/blob/develop/CONTRIBUTING.md) file.
