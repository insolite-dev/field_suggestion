import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';

import 'user_model.dart';

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

  List<UserModel> userSuggestions = [
    UserModel(email: 'test@gmail.com', password: 'test123'),
    UserModel(email: 'test1@gmail.com', password: 'test123'),
    UserModel(email: 'test2@gmail.com', password: 'test123')
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
                  hint: 'Email', // optional
                  boxController: firstBoxController, // optional
                  textController: firstTextController,
                  suggestionList: stringSuggestions,
                ),

                const SizedBox(height: 100),

                // Custom usage with num type variables.
                FieldSuggestion(
                  textController: secondTextController, // Required
                  suggestionList: numSuggestions, // Required
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

                const SizedBox(height: 100),

                // Usage with custom class suggestions.
                FieldSuggestion(
                  hint: 'Email',
                  // If y're using list where are classes,
                  // Don't forget adding search by property.
                  searchBy: 'email',
                  boxController: thirdBoxController,
                  textController: thirdTextController,
                  suggestionList: userSuggestions,
                  onItemSelected: (value) {
                    // The field suggestion needs toJson mehtod inside your model right? 
                    // So that's mean it converts your model to json.
                    // Then the output have to be json (Map). So now we can get our value's email.
                    print(value['email']);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
