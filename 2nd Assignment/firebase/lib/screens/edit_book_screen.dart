import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditResult {
  EditResult();
}

class EditBookScreen extends StatefulWidget {
  final int bookIndex;
  final String bookId;
  final QueryDocumentSnapshot book;
  EditBookScreen({this.bookIndex, this.bookId, this.book});
  @override
  _EditBookScreenState createState() => _EditBookScreenState(bookIndex, bookId, book);
}

class _EditBookScreenState extends State<EditBookScreen> {
  int bookIndex;
  String bookId;
  QueryDocumentSnapshot book;
  _EditBookScreenState(this.bookIndex, this.bookId, this.book);

  TextEditingController _titleController;
  TextEditingController _authorController;
  TextEditingController _genreController;
  TextEditingController _readController;
  TextEditingController _totalController;
  TextEditingController _coverController;
  @override
  void initState() {
    
    _titleController = TextEditingController(
      text: book['Title'],
    );
    _authorController = TextEditingController(
      text: book['Author'],
    );
    _genreController = TextEditingController(
      text: book['Genre'],
    );
    _readController = TextEditingController(
      text: book['Pages Read'].toString(),
    );
    _totalController = TextEditingController(
      text: book['Total Pages'].toString(),
    );
    _coverController = TextEditingController(
      text: book['Cover URL'],
    );
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _genreController.dispose();
    _readController.dispose();
    _totalController.dispose();
    _coverController.dispose();
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
        title: Text('Edit Book'),
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

   QueryDocumentSnapshot book = docs[bookIndex];

    for(int i = 0; i< docs.length;i++)
    {
      if(docs[i].id == bookId)
      {
        book = docs[i];
        break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Edit Book'),
        backgroundColor: Colors.indigo,
      ),
     body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(50,50, 50, 1),borderRadius: BorderRadius.all(Radius.circular(5)) ),
              child: TextField(
                controller: _titleController,
                style: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))), 
                  labelText: "Title",
                  labelStyle: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                  
                ),
              ),
            ),
              Container(
              decoration: BoxDecoration(color: Color.fromRGBO(50,50, 50, 1),borderRadius: BorderRadius.all(Radius.circular(5)) ),
              child: TextField(
                controller: _authorController,
                style: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))), 
                  labelText: "Author",
                  labelStyle: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                  
                ),
              ),
            ),
             Container(
              decoration: BoxDecoration(color: Color.fromRGBO(50,50, 50, 1),borderRadius: BorderRadius.all(Radius.circular(5)) ),
              child: TextField(
                controller: _genreController,
                style: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))), 
                  labelText: "Genre",
                  labelStyle: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                  
                ),
              ),
            ),
             Container(
              decoration: BoxDecoration(color: Color.fromRGBO(50,50, 50, 1),borderRadius: BorderRadius.all(Radius.circular(5)) ),
              child: TextField(
                controller: _readController,
                style: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))), 
                  labelText: "Pages Read",
                  labelStyle: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                  
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(50,50, 50, 1),borderRadius: BorderRadius.all(Radius.circular(5)) ),
              child: TextField(
                controller: _totalController,
                style: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))), 
                  labelText: "Total",
                  labelStyle: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                  
                ),
              ),
            ),
             Container(
              decoration: BoxDecoration(color: Color.fromRGBO(50,50, 50, 1),borderRadius: BorderRadius.all(Radius.circular(5)) ),
              child: TextField(
                controller: _coverController,
                style: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))), 
                  labelText: "Cover URL",
                  labelStyle: TextStyle(color: Color.fromRGBO(255, 255,255, 1)),
                  
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.done,
        ),
        //child: Icon(Icons.dnd_forwardslash,),
        onPressed: () {
          if(int.parse(_readController.text) > int.parse(_totalController.text))
          {
            _readController.text = _totalController.text;
          }

          FirebaseFirestore.instance.collection('books').doc(book.id).update({
            'Title': _titleController.text,
            'Author': _authorController.text,
            'Genre': _genreController.text,
            'Pages Read': int.parse(_readController.text),
            'Total Pages': int.parse(_totalController.text),
            'Cover URL': _coverController.text,
          });

          Navigator.pop(context);
        },
      ),
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
