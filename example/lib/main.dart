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
      theme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final boxController = BoxController();
  final textController = TextEditingController();

  List<UserModel> suggestions = [
    UserModel(
      email: 'john-doe@gmail.com',
      username: 'Johnny',
      password: '1234567',
    ),
    UserModel(
      email: 'john-doe@gmail.com',
      username: 'Johnny',
      password: '1234567',
    ),
    UserModel(
      email: 'john-doe@gmail.com',
      username: 'Johnny',
      password: '1234567',
    ),
    UserModel(
      email: 'john-doe@gmail.com',
      username: 'Johnny',
      password: '1234567',
    ),
    UserModel(
      email: 'john-doe@gmail.com',
      username: 'Johnny',
      password: '1234567',
    ),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => boxController.close?.call(),
      child: Scaffold(
        appBar: AppBar(title: const Text("FieldSuggestion Example")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                FieldSuggestion<UserModel>(
                  inputDecoration: InputDecoration(
                    hintText: 'Email', // optional
                  ),
                  inputType: TextInputType.emailAddress,
                  textController: textController,
                  suggestions: suggestions,
                  boxController: boxController,
                  search: (item, input) {
                    // Disable box, if item selected.
                    if (item.email == input) return false;

                    return item.email
                        .toString()
                        .toLowerCase()
                        .contains(input.toLowerCase());
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          textController.text = suggestions[index].email!;
                        });
                        textController.selection = TextSelection.fromPosition(
                          TextPosition(offset: textController.text.length),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(suggestions[index].username!),
                          subtitle: Text(suggestions[index].email!),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              suggestions.removeAt(index);
                              boxController.refresh?.call();
                            },
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
