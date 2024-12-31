import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:market_app_bot/src/bot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool onHover = false;
  final boxDecoration = BoxDecoration(border: Border.all(color: Colors.green));
  final textController = TextEditingController();
  List<String> commands = [];
  List<String> command = [
    "start",
    "stop",
    "clear.console",
    "clear",
    "restart",
    "sendText",
  ];
  final _focusNode = FocusNode();
  String status = "offline";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.network("https://static-00.iconduck.com/assets.00/server-green-icon-1024x625-kcfnhq24.png"),
        ),
        title: const Text(
          "Market Bot Server",
          style: TextStyle(color: Colors.lightGreen),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: boxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Status: $status",
                        style: const TextStyle(color: Colors.lightGreen),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: boxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Commands:",
                                  style: TextStyle(color: Colors.lightGreen),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: boxDecoration,
                                          child: ListView.builder(
                                            itemCount: command.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                child: Text(
                                                  command[index],
                                                  style: const TextStyle(color: Colors.lightGreen),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Console",
                                  style: TextStyle(color: Colors.lightGreen),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: boxDecoration,
                                          child: ListView.builder(
                                            itemCount: commands.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                child: Text(
                                                  commands[index],
                                                  style: TextStyle(
                                                    color: command.contains(commands[index]) ? Colors.lightGreen : Colors.red,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: boxDecoration,
                                  child: TextField(
                                    focusNode: _focusNode,
                                    cursorErrorColor: Colors.red,
                                    controller: textController,
                                    onSubmitted: (value) {
                                      commands.add(value);
                                      textController.text = "";
                                      if (command.contains(value)) {
                                        switch (value) {
                                          case "start":
                                            Bot().run(true);
                                            status = "online";
                                          case "stop":
                                            Bot().run(false);
                                            status = "offline";
                                          case "clear.console":
                                            commands.clear();
                                          case "clear":
                                            break;
                                          case "restart":
                                            // Restart the bot
                                            break;
                                          case "sendText":
                                            // Send text to the bot
                                            break;
                                        }
                                      }
                                      setState(() {
                                        _focusNode.requestFocus();
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: SizedBox())
        ],
      ),
    );
  }
}
