import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/edit_book_screen.dart';
import 'package:firebase/screens/add_book_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
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

  void _editBook(final _bookId) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditBookScreen(/*bookId:*/ bookIndex: _bookId, /*Get[index]*/ ), ),
    ).then((editResult) 
      {
        if (editResult != null) 
        {
          setState(() { /*final a = FirebaseFirestore.instance.doc(documentPath: "hey")*/ /*= editResult.book;*/ }); 
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
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildTodoListPage(QuerySnapshot snapshot) {
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
                        ("Alphabetical"),
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
                        ("Pages read"),
                        style: TextStyle(color: Color.fromRGBO(200, 200, 200, 1), ),
                      ),
                      onPressed: () 
                      {
                        setState(() { order = 'Pages Read'; } );
                        Navigator.pop(context);
                      }
                    ),
                  ],
                ),
              );
            }
            // onPressed: () {
            //   final batch = FirebaseFirestore.instance.batch();
            //   for (var item in docs) {
            //     if (item['done']) {
            //       batch.delete(todos.doc(item.id));
            //     }
            //   }
            //   batch.commit();
            // },
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
                  leading: IconButton(
                    icon: Icon(Icons.image, color: Colors.white70),
                    onPressed: () {},
                  ),
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
                    //_editBook(item.id);
                    _editBook(index);
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
            child: Padding(
              padding: EdgeInsets.all(12),
              child : IconButton(
                icon: Icon(Icons.add, color: Colors.white70, ),
                iconSize: 24.0,
                onPressed: () 
                { 
                  _addBook(); 
                },
              ),

              /*child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(),
                      cursorColor: Colors.white60,
                      controller: _controller,
                      style: TextStyle(color: Colors.white70, ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white70),
                    onPressed: () 
                    {
                      todos.add({
                        'Title': _controller.text,
                        'Author': "Default Author",
                        'Pages Read': Random().nextInt(500),
                        'Genre': "Educational",
                        'Total Pages': 500,
                      });

                      _controller.clear();
                    },
                  ),
                ],
              ),*/

            ),
          ),
        ],
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
          case ConnectionState.active:      { return _buildTodoListPage(snapshot.data); }
          default:                          { return _buildErrorPage("unreachable!!!"); }
        }
      },
    );
  }
}