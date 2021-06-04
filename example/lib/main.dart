import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FieldSuggestion Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firstTextController = TextEditingController();
  final secondTextController = TextEditingController();
  final thirdTextController = TextEditingController();

  final firstBoxController = BoxController();
  final secondBoxController = BoxController();
  final thirdBoxController = BoxController();

  List<String> stringSuggestions = [
    'test@gmail.com',
    'test1@gmail.com',
    'test2@gmail.com',
  ];

  List<int> numSuggestions = [
    13187829696,
    13102743803,
    15412917703,
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        firstBoxController.close!();
        secondBoxController.close!();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("FieldSuggestion Example")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                // Basic usage.
                FieldSuggestion(
                  boxController: firstBoxController,
                  textController: firstTextController,
                  suggestionList: stringSuggestions,
                  hint: 'Email',
                ),

                const SizedBox(height: 100),

                // With num type variables.
                FieldSuggestion(
                  boxController: secondBoxController,
                  textController: secondTextController,
                  suggestionList: numSuggestions,
                  hint: 'Phone Number',
                ),
                const SizedBox(height: 100),

                // Custom usage.
                FieldSuggestion(
                  boxController: thirdBoxController,
                  textController: thirdTextController,
                  suggestionList: stringSuggestions,
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
                  suggestionItemStyle:
                      SuggestionItemStyle.WhiteNeumorphismedStyle,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
