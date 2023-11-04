import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  final _formkey = GlobalKey<FormState>();
  final idController = TextEditingController();
  void DeleteUser() async {
    if (_formkey.currentState!.validate()) {
      final id = idController.text;
      String url = "https://10.0.2.2:7097/crud/Delete/$id";
      final response = await http.delete(
        Uri.parse(url),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'Id',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter User's ID";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: DeleteUser, child: const Text("Add User"))
            ],
          ),
        ),
      ),
    );
  }
}
