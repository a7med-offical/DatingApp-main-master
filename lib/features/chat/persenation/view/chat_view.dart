import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/core/utlis/custom_text_field.dart';
import 'package:dating_app/features/chat/data/services/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final String name;
  final String uid;

  const ChatView({Key? key, required this.name, required this.uid})
      : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserProfileImage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserProfileImage() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('AddUserChat')
          .doc(widget.uid)
          .get();
      setState(() {
        _profileImageUrl = userDoc['image_url'];
      });
    } catch (e) {
      print("Failed to fetch user profile image: $e");
    }
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.uid, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: _profileImageUrl != null
                  ? NetworkImage(_profileImageUrl!)
                  : const AssetImage('Assets/images/1.jpg') as ImageProvider,
            ),
          ),
          title: Text(widget.name,
              style: const TextStyle(
                  color: Color.fromARGB(255, 92, 14, 105),
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        body: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _chatService.getMessage(widget.uid, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final messages = snapshot.data!.docs;

        if (messages.isEmpty) {
          print('Number of messages: ${messages.length}');
          return const Center(
            child: Text('No messages'),
          );
        }

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index].data() as Map<String, dynamic>;
            final isCurrentUser =
                message['senderId'] == _firebaseAuth.currentUser!.uid;
            final alignment =
                isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: alignment,
              child: Column(
                children: [
                  MessageCard(
                      message: message['message'],
                      color: isCurrentUser ? Colors.blue : Colors.black)
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
            controller: _messageController,
            hintText: 'Type... ',
            iconData: Icons.brush_rounded,
            onChanged: (p0) => null,
          )),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  final String message;
  final Color color;

  const MessageCard({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8),
        color: color,
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
