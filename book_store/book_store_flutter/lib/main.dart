// ignore_for_file: use_super_parameters

import 'package:book_store_client/book_store_client.dart';
import 'package:book_store_flutter/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'loading_screen.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Serverpod Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {


  List<Book>? books;
  Exception? connectionException;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: books == null
      ? LoadingScreen(
          exception: connectionException,
          onTryAgain: () {
            // _loadBooks();
          },
        )
      : ListView.builder(
          itemCount: books!.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(books![index].name),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  var book = books![index];
                  setState(() {
                    books!.remove(book);
                  });
                  // _deleteBook(book);
                },
              ),
            );
          }),
        ),
    floatingActionButton: books == null
      ? null
      : FloatingActionButton(
          onPressed: () {
            showBookDialog(
              context: context,
              onSaved: (text) {
                var book = Book(
                  name: text, originalPrice: 30,
                );
                books!.add(book);

                // _createBook(book);
              },
            );
          },
          child: const Icon(Icons.add),
        ),
  );
}

// Future<void> _createBook(Book book) async {
//   try {
//     await client.book.createBook(book);
//     await _loadBooks();
//   } catch (e) {
//     _connectionFailed(e);
//   }
// }


  void _connectionFailed(dynamic exception) {
    setState(() {
      books = null;
      connectionException = exception;
    });
  }

  // Future<void> _loadBooks() async {
  //   final books = await client.book.list(pageNum: 1, pageSize: 10);
  //   this.books = books.data;
  //   setState(() { });
  // }


  // Future<void> _deleteBook(Book book) async {
  //   await client.book.deleteBook(book);
  //   await _loadBooks();
  // }

}
