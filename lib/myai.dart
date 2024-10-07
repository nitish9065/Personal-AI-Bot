import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) => Container(
                        height: 100,
                        color: Colors.red,
                        margin: const EdgeInsets.all(10),
                      )),
            ),
            _chatInput()
          ],
        ),
      ),
    );
  }

  // bottom chat input field
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .01,
          horizontal: MediaQuery.of(context).size.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        // setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      // if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  //take audio from the user
                  IconButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                      },
                      
                      icon: const Icon(Icons.mic_none_rounded,
                          color: Colors.blueAccent, size: 26)),

                  //adding some space
                  // const SizedBox(width: 2),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              // if (_textController.text.isNotEmpty) {
              //   APIs.sendMessage(widget.user, _textController.text, Type.text);
              //   _textController.text = '';
              // }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}
