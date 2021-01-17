import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/book_info_screen.dart';
import 'package:firebase/screens/add_book_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  TextEditingController _controller;

  bool ascending  = false;
  String order    = 'Title';
 
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void switchOrder() {
    setState(() { ascending = !ascending; } );
  }

  void _editBook(final _bookId,final book) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => BookInfoScreen(bookId:_bookId,book: book ), ),
    ).then((editResult) 
      {
        if (editResult != null) 
        {
          setState(() { }); 
        }
      }
    );
  }

  void _addBook() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddBookScreen(), ),
    ).then((addResult) 
      {
        if (addResult != null)
        {
          setState(() {});
        }
      }
    );
  }

  Widget _BookCoverImage(String url) {
    return (url != "[NONE]") ? Image.network(url, scale: 0.2, width: 50) : Icon(Icons.book, size: 50, color: Colors.white70);
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
        title: Text('Book List'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: () 
              {
                switchOrder(); //This makes my eyes hurt
              }),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(child: CircularProgressIndicator(), ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () { /*_addBook();*/ },
      ),
    );
  }

  Widget _buildBookListPage(QuerySnapshot snapshot) {
    final todos = FirebaseFirestore.instance.collection('books');
    final docs = snapshot.docs;
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('Book List'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_drop_up),
            onPressed: () 
            {
              switchOrder(); //This makes my eyes hurt
            }
          ),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () 
            {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Color.fromRGBO(100, 100, 100, 1),
                  title: Text(
                    ("Sort by"),
                    style: TextStyle(color: Color.fromRGBO(200, 200, 200, 1), ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text(
                        ("Title"),
                        style: TextStyle( color: Color.fromRGBO(200, 200, 200, 1), ),
                      ),
                      onPressed: () 
                      {
                        setState(() { order = 'Title'; } );
                        Navigator.pop(context);
                      }
                    ),
                     FlatButton(
                      child: Text(
                        ("Author"),
                        style: TextStyle(color: Color.fromRGBO(200, 200, 200, 1), ),
                      ),
                      onPressed: () 
                      {
                        setState(() { order = 'Author'; } );
                        Navigator.pop(context);
                      }
                    ),
                    FlatButton(
                      child: Text(
                        ("Pages read"),
                        style: TextStyle(color: Color.fromRGBO(200, 200, 200, 1), ),
                      ),
                      onPressed: () 
                      {
                        setState(() { order = 'Pages Read'; } );
                        Navigator.pop(context);
                      }
                    ),
                     FlatButton(
                      child: Text(
                        ("Total Pages"),
                        style: TextStyle(color: Color.fromRGBO(200, 200, 200, 1), ),
                      ),
                      onPressed: () 
                      {
                        setState(() { order = 'Total Pages'; } );
                        Navigator.pop(context);
                      }
                    ),
                    FlatButton(
                      child: Text(
                        ("Genre"),
                        style: TextStyle(color: Color.fromRGBO(200, 200, 200, 1), ),
                      ),
                      onPressed: () 
                      {
                        setState(() { order = 'Genre'; } );
                        Navigator.pop(context);
                      }
                    ),
                  ],
                ),
              );
            }
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, int index) 
              {
                final item = docs[index];
                return ListTile(
                  tileColor: Colors.white12,
                  leading: _BookCoverImage(item["Cover URL"].toString()),
                  title: Text(
                    (item['Title']),
                    style: TextStyle(decoration: TextDecoration.none, color: Colors.white70, ),
                  ),
                  subtitle: Text(
                    (item['Author']),
                    style: TextStyle(decoration: TextDecoration.none, color: Colors.white70, ),
                  ),
                  trailing: Text(
                    (item['Pages Read'].toString() + "/" + item['Total Pages'].toString() + " Pages"),
                    style: TextStyle(decoration: TextDecoration.none, color: Colors.white70, ),
                  ),
                  onTap: ()
                  {
                    _editBook(item.id,item);
                  },
                  onLongPress: () 
                  {
                    todos.doc(item.id).delete();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Deleted item "${item['what']}"'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () => todos.add(item.data()),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Material(
            elevation: 0.0,
            color: Colors.indigo,
            shape: CircleBorder(side: BorderSide.none),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
        onPressed: () { _addBook(); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final books = FirebaseFirestore.instance.collection('books');
    return StreamBuilder(
      stream: books.orderBy(order, descending: ascending).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) 
      {
        if (snapshot.hasError) { return _buildErrorPage(snapshot.error.toString()); }

        switch (snapshot.connectionState) 
        {
          case ConnectionState.waiting:     { return _buildLoadingPage(); }
          case ConnectionState.active:      { return _buildBookListPage(snapshot.data); }
          default:                          { return _buildErrorPage("unreachable!!!"); }
        }
      },
    );
  }
}