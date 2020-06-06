return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Insert'),
              Tab(text: 'View'),
              Tab(text: 'Query'),
              Tab(text: 'Update'),
              Tab(text: 'Delete'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: fnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: lnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: empNumController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Employee Number',
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Insert User Details'),
                    onPressed: () {
                      String fname = fnameController.text;
                      String lname = lnameController.text;
                      int empNum = int.parse(empNumController.text);
                      _insert(fname, lname, empNum);
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                itemCount: employees.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == employees.length) {
                    return RaisedButton(
                      child: Text('Refresh List'),
                      onPressed: () {
                        setState(() {
                          _queryAll();
                        });
                      },
                    );
                  }
                  return Container(
                      child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Employee id: ${employees[index].id}"),
                          Text(
                              "Full Name ${employees[index].fname} ${employees[index].lname}"),
                          Text("EmpNum: ${employees[index].empNum}"),
                        ],
                      ),
                    ),
                  ));
                },
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: queryController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                      ),
                      onChanged: (text) {
                        if (text.length >= 2) {
                          setState(() {
                            _queryByName(text);
                          });
                        } else {
                          setState(() {
                            employeeByName.clear();
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: employeeByName.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Center(
                            child: Text('${employeeByName[index].fname}'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: idUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Employee ID',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: fnameUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: lnameUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: empNumUpdateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Employee Number',
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Update User Details'),
                    onPressed: () {
                      int id = int.tryParse(idUpdateController.text);
                      String fname = fnameUpdateController.text;
                      String lname = lnameUpdateController.text;
                      int empNum = int.parse(empNumUpdateController.text);
                      _update(id, fname, lname, empNum);
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: empNumController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Employee Number',
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Delete User Details'),
                    onPressed: () {
                      int empNum = int.parse(empNumController.text);
                      _delete(empNum);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


    SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: pedals.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "Pedal Name ${pedals[index].pedalName} // ${pedals[index].effectType}"),
                          Text("Parameters: ${pedals[index].parameters}"),

                        ],
                      ),
                    ),
                  ));
                },
              ),
            ],
          ),
        ),
      ),