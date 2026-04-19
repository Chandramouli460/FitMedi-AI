import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _controller.text,
          'isUser': true,
        });
        _controller.clear();
      });

      // Simulate AI response after 1 second
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _messages.add({
            'text': 'Hello! How can I assist you today?',
            'isUser': false,
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with AI')), 
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message['text'], message['isUser']);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}