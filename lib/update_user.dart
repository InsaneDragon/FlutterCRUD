import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<UpdateUser> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final pictureController = TextEditingController();

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = nameController.text;
      String age = ageController.text;
      String city = cityController.text;
      String picture = pictureController.text;
      String id = idController.text;
      final body = {
        'id': id,
        'name': name,
        'age': age,
        'city': city,
        'picture': picture
      };
      String url = "https://10.0.2.2:7097/crud/Update";
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'ID',
                ),
                  validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter User's ID";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                ),
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
              ),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
              ),
              TextFormField(
                controller: pictureController,
                decoration: const InputDecoration(
                  labelText: 'Picture',
                ),
              ),
              ElevatedButton(
                  onPressed: submitForm, child: const Text("Update User"))
            ],
          )),
    ));
  }
}
