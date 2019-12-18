import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/models/item.dart';
import 'package:http/http.dart' as http;


class ApodList extends StatefulWidget {
  var items = new List<Item>();

  var days = [];

  ApodList() {
    items = [];

    // items.add(Item(title: "test 1"));
    // items.add(Item(title: "test 2"));
    // items.add(Item(title: "test 3"));

    dateArray();
    fetchItem("2019-12-1", "2019-12-17");
  }

  Future fetchItem(String startDate, String endDate) async {
    // https://api.nasa.gov/planetary/apod?api_key=8g23BupBSJXtE86RIMPOYki0ele3dSRvoshr5yLM&start_date=2019-1-1&end_date=2019-12-17
    final response = await http.get(
        'https://api.nasa.gov/planetary/apod?api_key=8g23BupBSJXtE86RIMPOYki0ele3dSRvoshr5yLM&start_date=$startDate&end_date=$endDate');

    if (response.statusCode == 200) {
      // var ret = Item.fromJson(json.decode(response.body));
      var ret = json.decode(response.body);
      // If server returns an OK response, parse the JSON.
      print(ret);
      return ret;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  dateArray() {
    DateTime startDate = new DateTime.now();

    var ano = startDate.year.toInt();
    var mes = startDate.month.toInt();
    var dia = startDate.day.toInt();

    while (ano >= 2019) {
      while (mes >= 1) {
        while (dia >= 1) {
          DateTime currentDate = DateTime(ano, mes, dia);
          if (currentDate != null) {
            var currentDay = "$ano-$mes-$dia";
            days.add("$currentDay");
          }
          dia--;
        }
        dia = 31;
        mes--;
      }
      mes = 12;
      ano--;
    }
  }

  @override
  _ApodListState createState() => _ApodListState();
}

class _ApodListState extends State<ApodList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Apod'),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        // itemCount: 1,
        // itemCount: 20,
        itemBuilder: (BuildContext ctxt, int index) {
          // final item = widget.items[index];

          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: new BorderRadius.circular(8.0),
            ),
            margin: new EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
            padding: new EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
            child: Column(
              children: <Widget>[
                Stack(children: <Widget>[
                  ClipRRect(
                    child: Image.network(
                      'https://apod.nasa.gov/apod/image/1906/StrawberryMoon_Chasiotis_960.jpg',
                      fit: BoxFit.cover,
                    ),
                    borderRadius: new BorderRadius.circular(7.0),
                  ),
                  Center(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: new EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 6.0),
                        padding: new EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          "15/12/2019",
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    // color: Colors.red,
                    child: Text(
                      "Título",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    // color: Colors.red,
                    child: Text("Descrição"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
