import 'package:flutter/material.dart';
import 'package:field_suggestion/field_suggestion.dart';

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
  // A box controller for default and local usable FieldSuggestion.
  final boxController = BoxController();

  // A box controller for network usable FieldSuggestion.
  final boxControllerNetwork = BoxController();

  // A box controller for network target widget usable FieldSuggestion.
  final boxControllerNetworkTw = BoxController();

  // A text editing controller for default and local usable FieldSuggestion.
  final textController = TextEditingController();

  // A text editing controller for network usable FieldSuggestion.
  final textControllerNetwork = TextEditingController();

  // A text editing controller for network with target widget usable FieldSuggestion.
  final textControllerNetworkTw = TextEditingController();

  // A focus node manage textFormField in target widget demo.
  final FocusNode twFocusNode = FocusNode();

  // A ready data, that's used as suggestions for default widget and network future.
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
      username: 'Batu',
      password: 'test123',
    )
  ];

  // A fake future builder that waits for 1 second to complete search.
  final strSuggestions = ['Rasul', 'Andro', 'Onur', 'Ismael', 'Davit'];
  Future<List<String>> future(String input) => Future<List<String>>.delayed(
        const Duration(seconds: 1),
        () => strSuggestions
            .where((s) => s.toLowerCase().contains(input.toLowerCase()))
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        boxController.close?.call();
        boxControllerNetwork.close?.call();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("FieldSuggestion Example")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                /// The default local usage, which requires already built suggestions list.
                /// See line [135] for .network() variant implementation.
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

                const Divider(),
                SizedBox(height: 16),

                /// A network usage of [FieldSuggestion].
                FieldSuggestion<String>.network(
                  future: (input) => future.call(input),
                  boxController: boxControllerNetwork,
                  textController: textControllerNetwork,
                  inputDecoration: InputDecoration(
                    hintText: 'Username', // optional
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final result = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: result.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () => textControllerNetwork.text = result[index],
                            );

                            textControllerNetwork.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: textControllerNetwork.text.length),
                            );

                            boxControllerNetwork.close?.call();
                          },
                          child: Card(
                            child: ListTile(title: Text(result[index])),
                          ),
                        );
                      },
                    );
                  },
                ),

                const Divider(),
                SizedBox(height: 16),

                FieldSuggestion<String>.network(
                  future: (input) => future.call(input),
                  boxController: boxControllerNetworkTw,
                  textController: textControllerNetworkTw,
                  focusNode: twFocusNode,
                  targetWidget: Row(
                    children: <Widget> [
                      // prefix widget for the input description.
                      Text('Username', style: TextStyle(fontSize: 14, color: Colors.white),),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: TextFormField(
                          controller: textControllerNetworkTw,
                          focusNode: twFocusNode,
                          decoration: InputDecoration(
                            hintText: 'With Target Widget', // optional
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final result = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: result.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(
                                  () => textControllerNetworkTw.text = result[index],
                            );

                            textControllerNetworkTw.selection =
                                TextSelection.fromPosition(
                                  TextPosition(
                                      offset: textControllerNetworkTw.text.length),
                                );

                            boxControllerNetworkTw.close?.call();
                          },
                          child: Card(
                            child: ListTile(title: Text(result[index])),
                          ),
                        );
                      },
                    );
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
