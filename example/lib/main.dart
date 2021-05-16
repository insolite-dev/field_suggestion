import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

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
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firstTextController = TextEditingController();
  final secondTextController = TextEditingController();

  List<String> suggestionList = [
    'test@gmail.com',
    'test1@gmail.com',
    'test2@gmail.com',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FieldSuggestion Example")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              // Basic usage.
              FieldSuggestion(
                textController: firstTextController,
                suggestionList: suggestionList,
                hint: 'Email',
              ),

              SizedBox(height: 100),

              // Custom usage.
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
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
