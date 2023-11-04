import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final pictureController = TextEditingController();
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
    pictureController.dispose();
    super.dispose();
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = nameController.text;
      String age = ageController.text;
      String city = cityController.text;
      String picture = pictureController.text;
      final body = {'name': name, 'age': age, 'city': city, 'picture': picture};
      String url = "https://10.0.2.2:7097/crud/Create";
      final response = await http.post(
        Uri.parse(url),
        body:jsonEncode(body),
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
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Full Name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Age";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your City";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: pictureController,
                decoration: const InputDecoration(
                  labelText: 'Picture',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Picture";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: submitForm, child: const Text("Add User"))
            ],
          )),
    ));
  }
}
