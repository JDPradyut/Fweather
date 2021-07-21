import 'package:flutter/material.dart';
import 'package:fweather/models/curdata.dart';
import 'package:fweather/services/dbHelper.dart';

class SavedData extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saved Data',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            height: 150,
            child: FutureBuilder(
              future: dbHelper.queryAllRows(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          CurDataModel savedData =
                              curDataModelFromJson(snapshot.data[index].row[1]);
                          var sdate =
                              snapshot.data[index].row[2].toString().split(' ');
                          String date = sdate[0];
                          var stime = sdate[1].split('.');
                          String time = stime[0];
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    savedData.main.temp.toString() + '\u00B0',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 40,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'City : ' + savedData.name.toString(),
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      Text(
                                        'Status : ' + savedData.weather[0].main,
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      Text(
                                        'Date : ' + date,
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      Text(
                                        'Time : ' + time,
                                        style: TextStyle(color: Colors.white70),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
