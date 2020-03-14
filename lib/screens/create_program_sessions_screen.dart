import 'package:falah/models/program_model.dart';
import 'package:falah/models/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:falah/models/session_model.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class CreateProgramSessionsScreen extends StatefulWidget {
  CreateProgramSessionsScreen({this.userRepo, this.jsonData});

  Map<String, dynamic> jsonData;
  UserRepository userRepo;

  @override
  _CreateProgramSessionsScreenState createState() =>
      _CreateProgramSessionsScreenState();
}

class _CreateProgramSessionsScreenState
    extends State<CreateProgramSessionsScreen> {
  List<DateTime> dates = [];
  final formatter = new DateFormat('hh:mm aaa EEEE, LLLL d, y');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _layoutSessions() {
    print("building");
    List<Widget> children = [];
    int numDates = 0;
    for (int i = 0; i < dates.length; i++) {
      if (dates[i] != null) {
        numDates++;
      }
    }
    print(dates);
    int highestIndx;
    for (int i = 0; i < (dates.length) / 2; i++) {
      if (dates[2 * i] != null) {
        highestIndx = 2 * i + 1;
        print("Adding index " +
            (2 * i).toString() +
            " to " +
            (2 * i + 1).toString());
        children.add(_buildSessionField(2 * i));
      }
    }
    print("(Blank) adding index " +
        (highestIndx == null ? 0 : highestIndx + 1).toString() +
        " to " +
        (highestIndx == null ? 1 : highestIndx + 2).toString());
    children.add(_buildSessionField(highestIndx == null ? 0 : highestIndx + 1));
    return Column(
      children: children,
    );
  }

  Widget _buildSessionField(int id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Start: "),
                _buildDateTimeField(id),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("End: "),
                _buildDateTimeField(id + 1),
              ],
            ),
          ],
        ),
        id == 0
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildRemoveSession(id),
                ],
              )
      ],
    );
  }

  void addSession() {
    setState(() {
      dates = dates;
    });
  }

  void removeSession(int id) {
    print("removing " + id.toString() + " to " + (id + 1).toString());
    setState(() {
      if (dates.length - 1 < id) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("No need to remove an empty session"),
        ));
        return;
      }
      dates[id] = null;
      if (dates.length - 1 < id + 1) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("No need to remove an empty session"),
        ));
        return;
      }
      dates[id + 1] = null;
    });
  }

  Widget _buildAddSession() {
    return FloatingActionButton(
      onPressed: addSession,
      tooltip: 'Add session',
      child: Icon(Icons.add),
    );
  }

  Widget _buildRemoveSession(int id) {
    return GestureDetector(
      onTap: () => removeSession(id),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: 60,
        child: RaisedButton(
            onPressed: () => removeSession(id),
            elevation: 5,
            padding: EdgeInsets.all(15),
            shape: CircleBorder(side: BorderSide(width: 1.0)),
            color: Theme.of(context).primaryColor,
            child: Icon(Icons.remove)),
      ),
    );
  }

  Widget _buildDateTimeField(int id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 200,
              child: DateTimeField(
                key: UniqueKey(),
                initialValue: dates.length - 1 < id ? null : dates[id],
                onChanged: (DateTime newVal) {
                  print(id);
                  while (dates.length - 1 < id) {
                    dates.add(null);
                  }
                  dates[id] = newVal;
                  print(dates);
                },
                format: formatter,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate:
                          currentValue ?? DateTime.now().add(Duration(days: 7)),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
  _handleUpload(Map<String, dynamic> json) async {
    Program res = await widget.userRepo.uploadProgram(json);
    if (res != null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Failed to upload. Try again later."),
        ));
    }
  }
  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: 200,
        child: RaisedButton(
          onPressed: () {
            var json = widget.jsonData;
            var isStart = true;
            List<Session> sessions = [];
            Map<String, DateTime> sessionJson;
            for (var date in dates) {
              if (date != null) {
                if (isStart) {
                  sessionJson["start"] = date;
                } else {
                  sessionJson["stop"] = date;
                  sessions.add(Session.fromJson(sessionJson));
                  sessionJson = null;
                  isStart = !isStart;
                }
              }
            }
            json["sessions"] = sessions;
            _handleUpload(json);
          },
          elevation: 5,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme.of(context).primaryColor,
          child: Text(
            "Submit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        alignment: Alignment.center,
        child: FlatButton(
          onPressed: () => Navigator.pop(
              context), //Navigator.push(context, MaterialPageRoute(builder: (_) => PasswordResetScreen(user))),
          child: Text("Back"),
        ),
      ),
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                "Create a program",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                "Sessions",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _layoutSessions(),
            SizedBox(height: 20.0),
            _buildAddSession(),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 0,
              ),
              child: _buildNextButton(),
            ),
            _buildBackButton()
          ],
        ),
      ),
    );
  }
}
