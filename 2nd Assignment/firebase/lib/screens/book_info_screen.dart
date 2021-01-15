import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/edit_book_screen.dart';

class EditResult {
  EditResult();
}

class BookInfoScreen extends StatefulWidget {
  final String  bookId = "[NONE]";
  final int     bookIndex;

  //EditBookScreen( {this.bookId} );
  BookInfoScreen( {this.bookIndex} );

  @override
  _BookInfoScreenState createState() => _BookInfoScreenState(bookIndex);
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  TextEditingController _bookController;
  String                _bookId;
  int                   bookIndex;
  bool                  finished;
  DocumentSnapshot      book;

  _BookInfoScreenState( this.bookIndex );

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
        title: Text('Book Info'),
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

  Widget _buildEditBookPage(QuerySnapshot snapshot) {
    final books = FirebaseFirestore.instance.collection('books');
    //final book = snapshot.docs[bookId];
    final docs = snapshot.docs;
    final book = docs[bookIndex];

    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Book Info'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Row(mainAxisAlignment: MainAxisAlignment.center,),
          
          Image.network("https://images-na.ssl-images-amazon.com/images/I/51IRl5e5R9L._SX342_SY445_QL70_ML2_.jpg", scale: 1.5, ),
          //Image.network(book["Cover URL"], scale: 1.5, ),
          
          Text("Pages: " + book["Pages Read"].toString() + "/" +  book["Total Pages"].toString(), style: TextStyle(color: Colors.white70)),
          Text(book["Title"], style: TextStyle(color: Colors.white70)),
          Text(book["Author"], style: TextStyle(color: Colors.white70)),
          Text(book["Genre"], style: TextStyle(color: Colors.white70)),

          Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 80.0),)
        ]
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.edit),
        onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditBookScreen(), ), ); }
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
          case ConnectionState.active:  { return _buildEditBookPage(snapshot.data); }
          default:                      { return _buildErrorPage("unreachable!!!"); }
        }
      },
    );
  }
}