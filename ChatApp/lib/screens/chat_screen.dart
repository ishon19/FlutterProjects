import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: StreamBuilder(
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapShot.data.documents;
          return ListView.builder(
            itemBuilder: (ctx, idx) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[idx]['text']),
            ),
            itemCount: documents.length,
          );
        },
        stream: Firestore.instance
            .collection('chats/mxSrsFfwFeGycek1lW6D/messages')
            .snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance.collection('chats/mxSrsFfwFeGycek1lW6D/messages').add({
            'text': 'Added on click'
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
