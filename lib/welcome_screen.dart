import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rlearn5/final_page.dart';

import 'dept_model.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Dept selectedDept;

  List<ListTile> topicList = [];

  @override
  Widget build(BuildContext context) {
    final _key = Key('dropdown2');
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Container(
          decoration: new BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/welcome_screen.png')),
            borderRadius: BorderRadius.all(Radius.circular(10.10)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0),
            // padding: const EdgeInsets.all(8.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Image.asset('images/logoimg2.png'),
                  height: 100.0,
                  alignment: Alignment.center,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("dept")
                      .snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("loading");
                    } else {
                      print('else');

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.grey[900],
                          child: Center(
                            child: DropdownButton<Dept>(
                              items: snapshot.data.docs.map(
                                    (e) {
                                  print(e.id);
                                  return DropdownMenuItem<Dept>(
                                    child: Text(
                                      e.id,
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    value: Dept.fromJson(e.data()),
                                  );
                                },
                              ).toList(),
                              onChanged: (deptValue) {

                                setState(() {
                                  selectedDept = deptValue;
                                  print('selected $deptValue');
                                });
                              },
                              isExpanded: false,
                              hint: Text(
                                "Choose dept",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey[900],
                    child: Center(
                      child: DropdownButton<Subject>(
                        key: _key,
                        items: (selectedDept == null)
                            ? [
                          DropdownMenuItem(
                            child: Text('No Item',style:TextStyle(color: Colors.white)),
                            value: null,
                          ),
                        ]
                            : List.generate(selectedDept?.subject?.length,
                                (index) {
                              return DropdownMenuItem<Subject>(
                                child: Text(
                                  selectedDept?.subject[index]?.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                value: selectedDept?.subject[index],
                              );

                            }),
                        onChanged: (courseData) {

                          if (selectedDept != null) {
                            List<ListTile> _topicList =
                            courseData.topics.map((topic) {
                              return ListTile(
                                title: Text(
                                  topic.topicName,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (context) => FinalScreen(
                                        data: topic,
                                      )));
                                },
                              );
                            }).toList();
                            setState(() {
                              topicList = _topicList;
                            });
                          }
                          
                        },
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey[900],
                    child: Center(
                      child: SingleChildScrollView(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(

                            topicList.length,
                                (index) {
                              return topicList[index];

                            },

                          ),
                        ),
                      ),
                    ),
                  ),
                ),



              ],

            ),

          ),
        ),
      ),
    );
  }
}
