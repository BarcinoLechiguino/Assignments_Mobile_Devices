import 'package:flutter/material.dart';
import 'package:firebase/Book/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/todo_list_screen.dart';

class EditResult {
  
  Book book; // null => cancellat
  EditResult({this.book});
}

class EditCourtScreen extends StatefulWidget {
  final String bookId;
  EditCourtScreen({ this.bookId});
  @override
  _EditCourtScreenState createState() => _EditCourtScreenState();
}

class _EditCourtScreenState extends State<EditCourtScreen> {
  TextEditingController _courtUserController;
  int index;
  bool finished;

  @override
  void initState() {
   
    _courtUserController = TextEditingController(
      text: FirebaseFirestore.instance.doc('to_dos/${this.widget.bookId }'),
    );
    finished = widget.book.finished;
    
    super.initState();
  }

  @override
  void dispose() {
    _courtUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final book = FirebaseFirestore.instance.doc('to_dos/${this.widget.bookId }'); //id here

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Court...",
        ),
        actions: [
        ]
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            TextField(
              controller: _courtUserController,
              decoration: InputDecoration(
                labelText: 'Court Player',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: finished,
                  onChanged: (newValue) {
                    setState(() {
                      finished = newValue;
                    });
                  },
                ),
                Text('Night Lights'),
              ],
            ),
            
            FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "Save Court Info",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(
                  EditResult(
                    book: Book(
                      _courtUserController.text,
                      'Puteta',
                      1000,
                      99,
                      finished,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
