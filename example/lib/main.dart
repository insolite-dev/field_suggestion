import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';

import 'user_model.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final boxController = BoxController();
  final textController = TextEditingController();

  var theme = ThemeData.light();

  /*
  List<UserModel> suggestions = [
    UserModel(
      email: 'john-doe@gmail.com',
      username: 'Johnny',
      password: '1234567',
    ),
    UserModel(
      email: 'charlie@icloud.com',
      username: 'Charlie',
      password: 'test123',
    ),
    UserModel(
      email: 'batu@yandex.com',
      username: 'Batuu',
      password: 'test123',
    )
  ];
  */

  List<String> suggestions = List.generate(
    1500,
    (index) => index.toString(),
  );

  // List suggestions = ['Ahmet', 'Mehmet', 'Musa', 'Ayse'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'FieldSuggestion Example',
      home: GestureDetector(
        onTap: () => boxController.close?.call(),
        child: Scaffold(
          appBar: AppBar(title: const Text("FieldSuggestion Example")),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                children: [
                  FieldSuggestion(
                    inputDecoration: InputDecoration(
                      hintText: 'Email', // optional
                    ),
                    inputType: TextInputType.emailAddress,
                    textController: textController,
                    suggestions: suggestions,
                    boxController: boxController,
                    search: (item, input) {
                      return item
                          .toUpperCase()
                          .toString()
                          .contains(input.toUpperCase());
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            textController.text = suggestions[index];
                          });
                          textController.selection = TextSelection.fromPosition(
                            TextPosition(offset: textController.text.length),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(suggestions[index]),
                            trailing: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                suggestions.removeAt(index);
                                boxController.refresh?.call();
                              },
                            ),
                            leading: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  'n'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    child: Text('CHANGE THEME'),
                    onPressed: () {
                      if (theme.brightness == Brightness.dark) {
                        theme = ThemeData.light();
                      } else {
                        theme = ThemeData.dark();
                      }

                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
