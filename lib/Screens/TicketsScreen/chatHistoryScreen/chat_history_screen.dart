import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:quickcash/Screens/TicketsScreen/chatHistoryScreen/replyModel/chatReplyApi.dart';
import 'package:quickcash/constants.dart'; // Replace with your constants import
import 'package:quickcash/util/auth_manager.dart';

import 'model/chatHistoryApi.dart';

class ChatMessage {
  final String? from;
  final String? to;
  final String? message;
  final String? createdAt;
  final String? user;

  ChatMessage({
    this.from,
    this.to,
    this.message,
    this.createdAt,
    this.user,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      from: json['from']?.toString(),
      to: json['to']?.toString(),
      message: json['message']?.toString(),
      createdAt: json['createdAt']?.toString(),
      user: json['user']?.toString(),
    );
  }
}

class ChatHistoryScreen extends StatefulWidget {
  final String? mID;
  final String? mChatStatus;
  const ChatHistoryScreen({super.key, required this.mID, required this.mChatStatus});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final ChatReplyApi _chatReplyApi = ChatReplyApi();

  final ChatHistoryApi _chatHistoryApi = ChatHistoryApi();
  List<ChatMessage> messages = [];
  bool isLoading = false;
  String? errorMessage;
  String? chatStatus;


  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    mChatHistory("No");
    chatStatus = widget.mChatStatus;
  }

  Future<void> mChatHistory(String s) async {
    setState(() {
      if (s == "No") {
        isLoading = true;
        errorMessage = null;
      } else {
        isLoading = false;
        errorMessage = null;
      }
    });

    try {
      final response = await _chatHistoryApi.chatHistoryApi(widget.mID);

      if (response.chatDetails != null && response.chatDetails!.isNotEmpty) {
        List<ChatMessage> tempMessages = [];
        for (var chatDetail in response.chatDetails!) {
          if (chatDetail.chat != null && chatDetail.chat!.isNotEmpty) {
            tempMessages.addAll(chatDetail.chat!);
          }
        }

        // Assuming the status is part of the response, you can set it like this:
        setState(() {
          messages = tempMessages;
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


  Future<void> sendTicketReply() async {
    File? attachmentFile;

    try{
      final response = await _chatReplyApi.replyTicket(
        support: widget.mID!,
        user: AuthManager.getUserId(),
        message: _controller.text,
        from: 'User',
        to: 'Admin',
        // attachment: attachmentFile,
      );

      if(response.message == "Success"){
        setState(() {
          mChatHistory("Yes");
          _controller.clear();
        });
      }else{
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? 'We are facing some issue!')),
          );
        });
      }
    }catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        sendTicketReply();
        /*messages.add(
          ChatMessage(
            from: "User", // Assuming message is from User
            message: _controller.text,
          ),
        );*/
      });
    }
  }

  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('h:mm a - dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return dateString;
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                ? Center(child: Text(errorMessage!))
                : ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isAdminMessage = message.from == "Admin";
                return Align(
                  alignment: isAdminMessage
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isAdminMessage
                          ? Colors.blue[100]
                          : Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isAdminMessage) ...[
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: kPurpleColor,
                            child: Text(
                              (message.from?.isNotEmpty ?? false) ? message.from![0] : 'N/A',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: isAdminMessage
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Text(
                                message.message ?? "",
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                formatDate(message.createdAt ?? ""),
                                style: const TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        if (!isAdminMessage) ...[
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 20, // Size of the circle
                            backgroundColor: kGreenColor,
                            child: Text(
                              (message.from?.isNotEmpty ?? false) ? message.from![0] : 'N/A', // Display the first letter
                              style: const TextStyle(
                                fontSize: 14, // Font size of the currency code
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Text color
                              ),
                            )

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
            child: chatStatus == "open"
                ? Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.none,
                    cursorColor: kPrimaryColor,
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
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    _sendMessage();
                  },
                  backgroundColor: kPrimaryColor,
                  child: const Icon(Icons.send, color: kWhiteColor),
                ),
              ],
            )
                : const SizedBox(),  // Hide the input field and send button if status is not "Open"
          ),
        ],
      ),
    );
  }
}


