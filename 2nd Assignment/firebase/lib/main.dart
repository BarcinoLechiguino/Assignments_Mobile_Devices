import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

void main()
{
  runApp(FirebaseApp());
}

class FirebaseApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: "Flutter Firebase",
      home: Scaffold(
        appBar: AppBar(title: Text('To-Dos Firebase')),
        body: StreamBuilder(
          stream: Firestore.instance.collection('to_dos').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if (!snapshot.hasData)
            {
              return Center(child: CircularProgressIndicator(), );
            }

            List<DocumentSnapshot> docs = snapshot.data.documents;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index)
              {
                Map<String, dynamic> data = docs[index].data;
                
                return ListTile(
                  leading: Checkbox(value: data['done'], ),
                  title: Text(data['what']),
                );
              }
            );
          }
        )
      ),
    );
  }
}