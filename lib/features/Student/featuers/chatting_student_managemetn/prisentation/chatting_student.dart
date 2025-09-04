import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';
import 'dart:io';

import '../../../../util/colors.dart';


class ChattingStudent extends StatefulWidget {
  @override
  _ChattingStudentState createState() => _ChattingStudentState();
}

class _ChattingStudentState extends State<ChattingStudent> {
  final List<Message> messages = [
    Message(
      senderName: 'John',
      text: 'Hello',
      isMe: false,
    ),
    Message(
      senderName: 'Jane',
      text: 'Hi, how are you?',
      isMe: true,
    ),
    Message(
      senderName: 'John',
      text: 'I\'m doing great. How about you?',
      isMe: false,
    ),
    Message(
      senderName: 'Jane',
      text: 'I\'m good too. Thanks!',
      isMe: true,
    ),
  ];

  TextEditingController _textController = TextEditingController();
  FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus on the text field when the screen is loaded
    _requestFocusOnTextField();
  }

  void _requestFocusOnTextField() {
    Timer(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_textFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];

                return Align(
                  alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: message.isMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.senderName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: message.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          message.text,
                          style: TextStyle(
                            color: message.isMe ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
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
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    focusNode: _textFocusNode,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: mainColor,
                  radius: 22.r,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: fillColorInTextFormField,
                    ),
                    onPressed: () {
                      _textController.clear();
                      // You can perform your send message logic here
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String senderName;
  final String text;
  final bool isMe;

  Message({required this.senderName, required this.text, required this.isMe});
}
