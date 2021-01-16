import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/edit_book_screen.dart';

class EditResult {
  EditResult();
}

class BookInfoScreen extends StatefulWidget {
  final String bookId;

  BookInfoScreen( {this.bookId} );

  @override
  _BookInfoScreenState createState() => _BookInfoScreenState(bookId);
}

class _BookInfoScreenState extends State<BookInfoScreen> {
 
  TextEditingController _bookController;
  String bookId;


  _BookInfoScreenState( this.bookId );

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
    final docs = snapshot.docs;
    int bookIndex = 0;
    QueryDocumentSnapshot book = docs[0];

    for(int i = 0; i < docs.length;i++)
    {
      if(docs[i].id == bookId)
      {
        book = docs[i];
        bookIndex = i;
        break;
      }
    }

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
          
          Image.network(book['Cover URL'], scale: 1.5, ),
          
          Text("Pages: " + book["Pages Read"].toString() + "/" +  book["Total Pages"].toString(), style: TextStyle(color: Colors.white70)),
          Text("Title: " + book["Title"], style: TextStyle(color: Colors.white70)),
          Text("Author: " + book["Author"], style: TextStyle(color: Colors.white70)),
          Text("Genre: " + book["Genre"], style: TextStyle(color: Colors.white70)),

          Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 80.0),)
        ]
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.edit),
        onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditBookScreen(bookIndex: bookIndex, bookId:bookId, book:book), ), ); }
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