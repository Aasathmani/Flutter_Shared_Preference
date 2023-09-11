import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_example/users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Prefernece",
      home: HomePage(
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _name= TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _phone=TextEditingController();

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initalGetSaved();
  }
  void initalGetSaved() async {
    sharedPreferences =await SharedPreferences.getInstance();

    Map<String,dynamic> jsonData=jsonDecode(sharedPreferences.getString('userdata')!);
    Users user=Users.fromJson(jsonData);

    if(jsonData.isNotEmpty)
      {
        _name.value=TextEditingValue(text: user.Name);
        _phone.value=TextEditingValue(text: user.Phone);
        _email.value=TextEditingValue(text: user.Email);
      }

  }

  void StoredData(){
    Users user=Users(_name.text,_phone.text,_email.text);

    String userdata=jsonEncode(user);
    print(userdata);

    sharedPreferences.setString("userdata", userdata);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shared preferneces'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter the name'),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter the email'),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: _phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter the Phone'),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('');
                  StoredData();
                },
                child: Text('Save the data'),
              ),
              ElevatedButton(
                onPressed: () {
                  sharedPreferences.remove('userdata');
                  _name.value=TextEditingValue(text: '');
                  _email.value=TextEditingValue(text: '');
                  _phone.value=TextEditingValue(text: '');
                },
                child: Text('clear'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
