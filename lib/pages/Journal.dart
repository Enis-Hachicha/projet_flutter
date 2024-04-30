import 'package:flutter/material.dart';
import 'package:testapp/widgets/drawer_widget.dart';

import '../dataBase/dataBase.dart';

class Journal extends StatefulWidget {
  const Journal({Key? key}): super(key: key);

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  List todoList = [];
  String singlevalue = "";
  final DatabaseHelper _db = DatabaseHelper.instance;
  List<Map<String, dynamic>> _Journal= [];


  final textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    populateJournal();
  }

  addString(content) {
    setState(() {
      singlevalue = content;
    });
  }

  Future<void> populateJournal() async{
    final journalItems = await _db.getAllJournalItems();
    setState(() {
      _Journal = journalItems;
    });
  }

  Future<void> _addItem(String journalItemName) async {
    if (journalItemName.isNotEmpty) {
      await _db.insertJournalItem(journalItemName);
      populateJournal();
    }
  }
  Future<void> _deleteItem(int id) async {
    await _db.deleteJournalItem(id);
    populateJournal();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(

      ),
      appBar: AppBar(
        title: Text(
          "My Journal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 75,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: ListView.builder(
                  itemCount: _Journal.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blue[300],
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 80,
                                child: Text(
                                  _Journal[index]['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 30,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: TextButton(
                                      onPressed: () {
                                        _deleteItem(_Journal[index]['id']);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 70,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          controller: textcontroller,
                          onChanged: (content) {
                            addString(content);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor: Colors.blue[300],
                              filled: true,
                              labelText: 'Add to your journal....',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: 5,
                        )),
                    Expanded(
                        flex: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            _addItem(textcontroller.text);
                            textcontroller.clear();
                          },
                          child: Container(
                              height: 25,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("Add")),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}