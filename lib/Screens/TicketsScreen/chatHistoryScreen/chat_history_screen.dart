import 'package:flutter/material.dart';
import 'package:quickcash/Screens/TicketsScreen/chatHistoryScreen/model/chatHistoryApi.dart';
import 'package:quickcash/Screens/TicketsScreen/chatHistoryScreen/model/chatHistoryModel.dart';
import 'package:quickcash/constants.dart';

/*class ChatMessage {
  final String user;
  final String message;
  final DateTime timestamp;

  ChatMessage({required this.user, required this.message, required this.timestamp});
}*/

class ChatHistoryScreen extends StatefulWidget {
  final String? mID;
  const ChatHistoryScreen({super.key,required this.mID});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreen();
}

class _ChatHistoryScreen extends State<ChatHistoryScreen> {
  final ChatHistoryApi _chatHistoryApi = ChatHistoryApi();
  List<ChatDetail> chatMessages =[];
  bool isLoading = false;
  String? errorMessage;


/*  final List<ChatMessage> messages = [
    ChatMessage(user: "User1", message: "Hello!", timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
    ChatMessage(user: "User2", message: "Hi there!", timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
  ];*/

  final Map<String, String> userImages = {
    "Admin": "assets/images/profile_pic.png",
    "User": "assets/images/profile_pic.png",
  };

  @override
  void initState() {
    super.initState();
    mChatHistory();
  }

  Future<void> mChatHistory() async{
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try{

      final response = await _chatHistoryApi.chatHistoryApi(widget.mID);

      if(response.chatDetails !=null && response.chatDetails!.isNotEmpty){
        setState(() {
          chatMessages = response.chatDetails!;
          isLoading = false;
        });
      }else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Chat Details';
        });
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
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
      body:  isLoading ? const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ) : ListView.builder(
        itemCount: chatMessages.length,
        itemBuilder: (context, index) {
          final message = chatMessages[index];
          return Align(
            alignment: message.fromSide == "Admin" ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: message.fromSide == "Admin" ? Colors.blue[100] : Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.fromSide == "Admin") ...[
                    CircleAvatar(
                      backgroundImage: AssetImage(userImages[message.fromSide]!),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: message.fromSide == "Admin" ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        Text(
                          message.message!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${message.date}:${message.date ?? ''}',
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  if (message.fromSide == "User") ...[
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundImage: AssetImage(userImages[message.fromSide]!),
                      radius: 20,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
