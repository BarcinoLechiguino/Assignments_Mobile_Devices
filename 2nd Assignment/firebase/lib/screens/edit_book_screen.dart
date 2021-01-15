import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditResult {
  EditResult();
}

class EditBookScreen extends StatefulWidget {
  final int bookIndex;

  final QueryDocumentSnapshot book;

  EditBookScreen({this.bookIndex, this.book});
  @override
  _EditBookScreenState createState() => _EditBookScreenState(bookIndex, book);
}

class _EditBookScreenState extends State<EditBookScreen> {
  int bookIndex;
  QueryDocumentSnapshot book;
  _EditBookScreenState(this.bookIndex, this.book);

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
    final book = docs[bookIndex];

    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Edit Book'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            //decoration: BoxDecoration(color: Color.fromRGBO(100,100, 100, 1)),
            child: TextField(
              controller: _titleController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                labelText: "Title"
                
              ),
            ),
          ),
           Container(
            //decoration: BoxDecoration(color: Color.fromRGBO(100,100, 100, 1)),
            child: TextField(
              controller: _authorController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                labelText: "Author"
                
              ),
            ),
          ),
           Container(
            //decoration: BoxDecoration(color: Color.fromRGBO(100,100, 100, 1)),
            child: TextField(
              controller: _genreController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                labelText: "Genre"
                
              ),
            ),
          ),
           Container(
            //decoration: BoxDecoration(color: Color.fromRGBO(100,100, 100, 1)),
            child: TextField(
              controller: _readController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                labelText: "Pages Read"
                
              ),
            ),
          ),
          Container(
            //decoration: BoxDecoration(color: Color.fromRGBO(100,100, 100, 1)),
            child: TextField(
              controller: _totalController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                labelText: "Total Pages"
                
              ),
            ),
          ),
           Container(
            //decoration: BoxDecoration(color: Color.fromRGBO(100,100, 100, 1)),
            child: TextField(
              controller: _coverController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                labelText: "Cover URL"
                
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(
          Icons.done,
        ),
        //child: Icon(Icons.dnd_forwardslash,),
        onPressed: () {
          FirebaseFirestore.instance.collection('books').doc(book.id).update({
            'Title': _titleController.text,
            'Author': _authorController.text,
            'Genre': _genreController.text,
            'Pages Read': int.parse(_readController.text),
            'Total Pages': int.parse(_readController.text),
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
