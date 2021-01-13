import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/todo_list_screen.dart';

class EditResult {
  EditResult();
}

class EditCourtScreen extends StatefulWidget {
  final String bookId;
  EditCourtScreen({this.bookId});
  @override
  _EditCourtScreenState createState() => _EditCourtScreenState();
}

class _EditCourtScreenState extends State<EditCourtScreen> {
  TextEditingController _courtUserController;
  String index;
  bool finished;
  DocumentSnapshot book;

  @override
  void initState() {
    _courtUserController = TextEditingController(
      text: "holA",
    );
    

    super.initState();
  }

  @override
  void dispose() {
    _courtUserController.dispose();
    super.dispose();
  }

  Widget _buildErrorPage(String message) {
    return Scaffold(
      body: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildLoadingPage() {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Edit Book'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: () {
                //switchOrder(); //This makes my eyes hurt
              }),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
          ),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEditBookPage(QuerySnapshot snapshot) {
    final todos = FirebaseFirestore.instance.collection('books');
    final docs = snapshot.docs;
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Book List'),
        backgroundColor: Colors.indigo )
    );
  }

  Widget build(BuildContext context) {
    final books = FirebaseFirestore.instance.collection('books');
    return StreamBuilder(
      stream: books.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorPage(snapshot.error.toString());
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _buildLoadingPage();
          case ConnectionState.active:
            return _buildEditBookPage(snapshot.data);
          default: // ConnectionState.none // ConnectionState.done
            return _buildErrorPage("unreachable!!!");
        }
      },
    );
  }
}
