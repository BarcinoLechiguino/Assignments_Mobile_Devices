import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddResult {
  AddResult();
}

class AddBookScreen extends StatefulWidget {
  AddBookScreen();
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  TextEditingController _bookController;
  bool                  finished;
  DocumentSnapshot      book;

  @override
  void initState() {
    _bookController = TextEditingController(text: "hola", );
    super.initState();
  }

  @override
  void dispose() {
    _bookController.dispose();
    super.dispose();
  }

  Widget _buildErrorPage(String message) {
    return Scaffold(
      body: Center(
        child: Text(message, style: TextStyle(color: Colors.red), /**/), 
      ),
    );
  }

  Widget _buildLoadingPage() {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Add Book'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_drop_up),
            onPressed: () { /*switchOrder(); //This makes my eyes hurt*/ }
          ),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildAddBookPage(QuerySnapshot snapshot) {
    final books = FirebaseFirestore.instance.collection('books');
    final docs = snapshot.docs;

    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Add Book'),
        backgroundColor: Colors.indigo 
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.done,),
        //child: Icon(Icons.dnd_forwardslash,),
        onPressed: () { Navigator.pop(context); },
      ),
    );
  }

  Widget build(BuildContext context) {
    final books = FirebaseFirestore.instance.collection('books');

    return StreamBuilder(
      stream: books.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) 
      {
        if (snapshot.hasError) { return _buildErrorPage(snapshot.error.toString()); }

        switch (snapshot.connectionState) 
        {
          case ConnectionState.waiting: { return _buildLoadingPage(); }
          case ConnectionState.active:  { return _buildAddBookPage(snapshot.data); }
          default:                      { return _buildErrorPage("unreachable!!!"); }
        }
      },
    );
  }
}