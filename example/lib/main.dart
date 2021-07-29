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
  final textEditingController = TextEditingController();

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
    UserModel(email: 'test@gmail.com', username: 'user1', password: '1234567'),
    UserModel(email: 'test1@gmail.com', username: 'user2', password: 'test123'),
    UserModel(email: 'test2@gmail.com', username: 'user3', password: 'test123')
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        firstBoxController.close!();
        secondBoxController.close!();
        thirdBoxController.close!();
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
                  searchBy: ['email', 'username'],
                  itemTitleBy: 'username',
                  // If you provide [itemSubtitleBy] then suggestion item's
                  // subtitle automaticallty will be enabled.
                  itemSubtitleBy: 'email',
                  boxController: thirdBoxController,
                  textController: thirdTextController,
                  suggestionList: userSuggestions,
                  onItemSelected: (value) {
                    // The field suggestion needs toJson mehtod inside your model right?
                    // So that's mean it converts your model to json.
                    // Then the output has to be JSON (Map). So now we can get our value's email.
                    print(value['username']);
                  },
                ),

                const SizedBox(height: 100),

                // Usage of FieldSuggestion.builder
                FieldSuggestion.builder(
                  hint: 'Email',
                  textController: textEditingController,
                  suggestionList: stringSuggestions,
                  boxController: firstBoxController,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () =>
                          textEditingController.text = stringSuggestions[index],
                      child: Card(
                        child: ListTile(
                          title: Text(stringSuggestions[index]),
                          trailing: IconButton(
                            onPressed: () {
                              stringSuggestions
                                  .remove(stringSuggestions[index]);
                              firstBoxController.refresh!();
                            },
                            icon: Icon(Icons.clear),
                          ),
                          leading: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey, shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                stringSuggestions[index][0].toUpperCase(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
