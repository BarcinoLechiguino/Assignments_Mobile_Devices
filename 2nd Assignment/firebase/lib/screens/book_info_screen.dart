import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/edit_book_screen.dart';

class EditResult {
  EditResult();
}

class BookInfoScreen extends StatefulWidget {
  final String bookId;

  BookInfoScreen({this.bookId});

  @override
  _BookInfoScreenState createState() => _BookInfoScreenState(bookId);
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  TextEditingController _bookController;
  String bookId;

  _BookInfoScreenState(this.bookId);

  @override
  void initState() {
    _bookController = TextEditingController(
      text: "hola",
    );
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
        child: Text(
          message,
          style: TextStyle(color: Colors.red), /**/
        ),
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
              onPressed: () {/*switchOrder(); //This makes my eyes hurt*/}),
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
    bool completed = false;

    for (int i = 0; i < docs.length; i++) {
      if (docs[i].id == bookId) {
        book = docs[i];
        bookIndex = i;
        break;
      }
    }

    completed = (book["Pages Read"] == book["Total Pages"]);

    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Book Info'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0)),
                  Image.network(book['Cover URL'], scale: 1.5, width: 150),
                  Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container( 
                        width: 200,
                        child: Text(book["Title"],
                          style: TextStyle(color: Colors.white70,fontSize: 20,)
                          ),
                        ),
                      Container(height:10,),
                      Container(
                        width: 200,
                        child: Text(book["Author"],
                        style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      (!completed) ? "In Progress": "Completed!", 
                      style: TextStyle(color: (!completed) ? Colors.white : Colors.green)
                    ),

                    LinearProgressIndicator(
                      backgroundColor: Colors.white12,
                      valueColor: new AlwaysStoppedAnimation<Color>((!completed) ? Colors.indigo : Colors.green),
                      value: book["Pages Read"] / book["Total Pages"],
                      semanticsLabel: "% Read",
                      //value: book["Pages Read"],
                    ),
                  ],
                ),
              ),
              
              Padding(padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0)),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(50, 50, 50, 1),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Column(children: [
                  Text(
                    ("Pages: " + book["Pages Read"].toString() + "/" + book["Total Pages"].toString()),
                    style: TextStyle(color: Colors.white70)
                  ),
                  Text(
                    ("Genre: " + book["Genre"]),
                    style: TextStyle(color: Colors.white70)
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 328.0),
                  ),
                ]),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditBookScreen(
                    bookIndex: bookIndex, bookId: bookId, book: book),
              ),
            );
          }),
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
            {
              return _buildLoadingPage();
            }
          case ConnectionState.active:
            {
              return _buildEditBookPage(snapshot.data);
            }
          default:
            {
              return _buildErrorPage("unreachable!!!");
            }
        }
      },
    );
  }
}
