import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'users.dart';
import 'dart:io';
import 'create_user.dart';
import 'delete_user.dart';
import 'update_user.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const CRUD());
}

class CRUD extends StatefulWidget {
  const CRUD({super.key});

  @override
  State<CRUD> createState() => _CRUDState();
}

class _CRUDState extends State<CRUD> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<User>> getRequest() async {
    String url = "https://10.0.2.2:7097/crud/Read";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    List<User> users = [];
    for (var singleUser in responseData) {
      User user = User(singleUser["id"], singleUser["name"], singleUser["age"],
          singleUser["city"], singleUser["picture"]);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            FilledButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateUser()));
              },
              child: const Text(
                "Create",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeleteUser()));
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpdateUser()));
              },
              child: const Text(
                "Update",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getRequest(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) => ListTile(
                  title: Text(snapshot.data[index].name +
                      "   " +
                      snapshot.data[index].age.toString() +
                      "   " +
                      snapshot.data[index].city.toString()),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
