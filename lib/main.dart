import 'package:flutter/material.dart';
import 'package:flutter_manager_contact/models/contact.dart';

const darkBlueColor = Color(0xff486579);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqlite Demo',
      theme: ThemeData(
        primaryColor: darkBlueColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  Contact _contact = Contact();
  List<Contact> _listContact = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: darkBlueColor),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(), _list()],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _form() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "full name"),
                onSaved: (val) => setState(() => _contact.name = val),
                validator: (val) =>
                    (val.length == 0 ? 'this field is required' : null),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Mobile"),
                onSaved: (val) => setState(() => _contact.mobile = val),
                validator: (val) =>
                    (val.length <= 5 ? 'this field is most 5' : null),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () => _onSubmit(),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  ),
                  color: darkBlueColor,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
          key: _formKey,
        ),
      );

  _onSubmit() {
    var form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      print("name  ${_contact.name}");
      setState(() {
        _listContact.add(_contact);
      });
    }
  }

  _list() => Expanded(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 30, 30, 0),
          child: ListView.builder(
            padding: EdgeInsets.all(9),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.account_balance,
                      color: darkBlueColor,
                      size: 40,
                    ),
                    title: Text(
                      _listContact[index].name.toUpperCase(),
                      style: TextStyle(
                          color: darkBlueColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 5,
                  )
                ],
              );
            },
            itemCount: _listContact.length,
          ),
        ),
      );
}
