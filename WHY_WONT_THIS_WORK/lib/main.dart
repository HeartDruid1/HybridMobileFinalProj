import 'package:flutter/material.dart';

import './models/pedalSettings.dart';
import 'package:Phonegazer/databaseHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonegazer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Phonegazer'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // create databaseHelper instance
  final dbHelper = DataBaseHelper.instance;

  List<Pedal> pedals = [];
  List<Pedal> pedalsByName = [];

  // Insert controllers
  TextEditingController pedalNameController = TextEditingController();
  TextEditingController effectTypeController = TextEditingController();
  TextEditingController parametersController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  // update controllers
  TextEditingController idUpdateController = TextEditingController();
  TextEditingController pedalNameUpdateController = TextEditingController();
  TextEditingController effectTypeUpdateController = TextEditingController();
  TextEditingController parametersUpdateController = TextEditingController();
  TextEditingController notesUpdateController = TextEditingController();

  // Query Controller
  TextEditingController queryController = TextEditingController();

  // unique key across the entire app
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Phonegazer'),
        backgroundColor: Colors.purple[200],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // there has to be a better way to do this but I'm pressed for time rn
                setState(() {
                  _queryAll();
                });
              })
        ],
      ),
      body: ListView.builder(
          itemCount: pedals.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                onTap: () {
                  setState(() {
                    int _idKey = index;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.purple[400],
                          title: Text('Phonegazer'),
                        ),
                        body: Column(
                          children: <Widget>[
                            Center(
                              child:
                                  Text('Number in list: ${pedals[index].id}'),
                            ),
                            Center(
                              child: Text(
                                  'Pedal Name: ${pedals[index].pedalName}'),
                            ),
                            Center(
                                child: Text(
                                    'Effect Type: ${pedals[index].effectType}')),
                            Center(
                                child: Text(
                                    'Parameters/Settings: ${pedals[index].parameters}')),
                            Center(
                                child: Text('Notes: ${pedals[index].notes}')),
                            Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: FloatingActionButton.extended(
                                      onPressed: () {
                                        _delete(index);
                                      },
                                      label: Text('Delete'),
                                      icon: Icon(Icons.delete)),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton.extended(
                                    backgroundColor: Colors.purple[400],
                                    label: Text('Update'),
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      int id =
                                          int.tryParse(idUpdateController.text);
                                      String pedalName =
                                          pedalNameUpdateController.text;
                                      String effectType =
                                          effectTypeUpdateController.text;
                                      String parameters =
                                          parametersUpdateController.text;
                                      String notes = notesUpdateController.text;
                                      _update(id, pedalName, effectType,
                                          parameters, notes);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                },
                title: Text(pedals[index].pedalName),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.purple[400],
          label: Text('Add a Pedal'),
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Scaffold(
                  // holy shit there has to be a better way to do this
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: Text('Phonegazer'),
                    backgroundColor: Colors.purple[200],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: pedalNameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Pedal Name',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: effectTypeController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Effect Type',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: parametersController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Effect Parameters',
                                  ),
                                  minLines: 5,
                                  maxLines: 8,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: notesController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Notes',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    backgroundColor: Colors.purple[400],
                    label: Text('Add to Library'),
                    icon: Icon(Icons.add_box),
                    onPressed: () {
                      String pedalName = pedalNameController.text;
                      String effectType = effectTypeController.text;
                      String parameters = parametersController.text;
                      String notes = notesController.text;
                      _insert(pedalName, effectType, parameters, notes);
                    },
                  ),
                );
              }),
            );
          }),
    );
  }

  void _insert(pedalName, effectType, parameters, notes) async {
    Map<String, dynamic> row = {
      DataBaseHelper.colPedalName: pedalName,
      DataBaseHelper.colEffectType: effectType,
      DataBaseHelper.colParameters: parameters,
      DataBaseHelper.colNotes: notes,
    };
    Pedal pedals = Pedal.fromMap(row);
    final id = await dbHelper.insert(pedals);
    _showMessageInScaffold("Inserted row id is $id");
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    pedals.clear(); //clear out list
    allRows.forEach((row) => pedals.add(Pedal.fromMap(row)));
    _showMessageInScaffold("Query done.");
    setState(() {});
  }

  void _queryByName(name) async {
    final allRows = await dbHelper.queryRows(name);
    pedalsByName.clear(); //clear out list
    allRows.forEach((row) => pedalsByName.add(Pedal.fromMap(row)));
    _showMessageInScaffold("Query done.");
    setState(() {});
  }

  void _update(id, pedalName, effectType, parameters, notes) async {
    Pedal pedals = Pedal(id, pedalName, effectType, parameters, notes);
    final rowsAffected = await dbHelper.update(pedals);
    _showMessageInScaffold('Updated $rowsAffected row(s)');
  }

  void _delete(id) async {
    final rowsDelete = await dbHelper.delete(id);
    _showMessageInScaffold("Deleted $rowsDelete rows(s)");
  }
}
