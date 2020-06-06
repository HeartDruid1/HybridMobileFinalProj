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