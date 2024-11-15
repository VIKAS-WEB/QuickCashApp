import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

import 'model/chatHistoryApi.dart';
import 'model/chatHistoryModel.dart';

class ChatMessage {
  final String user;
  final String message;
  final DateTime timestamp;

  ChatMessage({required this.user, required this.message, required this.timestamp});
}

class ChatHistoryScreen extends StatefulWidget {
  final String? mID;
  const ChatHistoryScreen({super.key, required this.mID});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreen();
}

class _ChatHistoryScreen extends State<ChatHistoryScreen> {
  final List<ChatMessage> messages = [
    ChatMessage(user: "User1", message: "Hello!", timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
    ChatMessage(user: "User2", message: "Hi there!", timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
  ];

  final Map<String, String> userImages = {
    "User1": "assets/images/profile_pic.png",
    "User2": "assets/images/profile_pic.png",
  };

  final ChatHistoryApi _chatHistoryApi = ChatHistoryApi();
  List<ChatDetail> chatMessages = [];
  bool isLoading = false;
  String? errorMessage;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    mChatHistory();
  }

  Future<void> mChatHistory() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _chatHistoryApi.chatHistoryApi(widget.mID);

      if (response.chatDetails != null && response.chatDetails!.isNotEmpty) {
        setState(() {
          chatMessages = response.chatDetails!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Chat Details';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(
          ChatMessage(
            user: "User1", // Assuming message is from User1
            message: _controller.text,
            timestamp: DateTime.now(),
          ),
        );
        _controller.clear(); // Clear the input field after sending
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Chat History', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.user == "User1" ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message.user == "User1" ? Colors.blue[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.user == "User1") ...[
                          CircleAvatar(
                            backgroundImage: AssetImage(userImages[message.user]!),
                            radius: 20,
                          ),
                          const SizedBox(width: 10),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: message.user == "User1" ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              Text(
                                message.message,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${message.timestamp.hour}:${message.timestamp.minute < 10 ? '0' : ''}${message.timestamp.minute}',
                                style: const TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        if (message.user == "User2") ...[
                          const SizedBox(width: 10),
                          CircleAvatar(
                            backgroundImage: AssetImage(userImages[message.user]!),
                            radius: 20,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.none,
                    cursorColor: kPrimaryColor,
                    onSaved: (value){
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultPadding),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Type a message...",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      hintStyle: const TextStyle(color: kPrimaryColor),
                    ),
                    maxLines: 4,
                    minLines: 1,
                  ),
                ),
                /*Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultPadding),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    maxLines: 4,
                    minLines: 1,
                  ),
                ),*/
                const SizedBox(width: 10),
                // Right side: Send button
                FloatingActionButton(
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send,color: kPrimaryColor,),
                ),
               /* IconButton(
                  icon: const Icon(Icons.send,color: kPrimaryColor,),
                  onPressed: _sendMessage,
                ),*/
              ],
            ),
          ),
          const SizedBox(height: defaultPadding,),
        ],
      ),
    );
  }
}
