import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user['avatar']),
            ),
            title: Text('${user['first_name']} ${user['last_name']}'),
            subtitle: Text(user['email']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final response =
            await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
        if (response.statusCode == 200) {
          setState(() {
            final jsonData = json.decode(response.body);
            users = jsonData['data'];
          });
        }
      }),
    );
  }
}

// Future<void> fetchData()