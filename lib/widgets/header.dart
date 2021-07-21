import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fweather/services/dbHelper.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  String update;
  String name;
  String body;
  String date = DateTime.now().toString();
  String status;
  String temp;
  final dbHelper = DatabaseHelper.instance;
  Header(this.update, this.name, this.body, this.temp, this.status);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                Text(
                  update,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.save_alt),
                color: Colors.white.withOpacity(0.8),
                onPressed: () async {
                  Map<String, dynamic> row = {
                    DatabaseHelper.columnData: body,
                    DatabaseHelper.columnDate: date
                  };
                  final id = await dbHelper.insert(row);
                  print('inserted row id: $id');
                  Fluttertoast.showToast(
                      msg: 'Saved to Local Storage,Please Refresh',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.teal,
                      textColor: Colors.white,
                      timeInSecForIosWeb: 1,
                      fontSize: 16);
                },
                tooltip: 'Save Data',
              ),
              IconButton(
                icon: Icon(Icons.share),
                color: Colors.white.withOpacity(0.8),
                tooltip: 'Share Data',
                onPressed: () {
                  String subject = 'My Weather Info';
                  String shareTxt =
                      "Hey,this is my current loaction's weather using F-Weather :\n Location : $name\n Temperature : $temp\u00B0 C\n Status : $status";
                  final RenderBox box = context.findRenderObject();
                  Share.share(shareTxt,
                      subject: subject,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
