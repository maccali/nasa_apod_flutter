import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class ApodList extends StatefulWidget {
  // var items = new List<Item>();
  var items = [];
  var startDate = "2019-12-14";
  var endDate = "";
  var limitReq = 5;
  var countReq = 0;

  // limite de 6 request IM APOD API per second (5)
  // var endDate = new DateFormat("yMd");

  ApodList() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var formatted = formatter.format(now);

    endDate = formatted.toString();

    items = [];
  }

  @override
  _ApodListState createState() => _ApodListState();
}

class _ApodListState extends State<ApodList> {
  Future fetchData(String startDate, String endDate) async {
    final res = await http.get(
        "https://api.nasa.gov/planetary/apod?api_key=8g23BupBSJXtE86RIMPOYki0ele3dSRvoshr5yLM&start_date=$startDate&end_date=$endDate");

    if (res.statusCode == 200) {
      var itemsStr = res.body;

      return itemsStr;
    } else {
      throw ("some arbitrary error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Apod'),
        ),
        body: FutureBuilder(
          future: fetchData(widget.startDate, widget.endDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var valueMap = [];
              String dataItem = snapshot.data;
              valueMap = json.decode(dataItem);
              Iterable inReverseValueMap = valueMap.reversed;
              valueMap = inReverseValueMap.toList();

              return ListView.builder(
                itemCount: valueMap.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  final item = valueMap[index];

                  print(item["media_type"]);
                  print(item['url']);
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: new BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.deepPurple)),
                    margin: new EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 7.0),
                    padding: new EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 7.0),
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          (item["media_type"] == "image")
                              ? ClipRRect(
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: item['url'],
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: new BorderRadius.circular(7.0),
                                )
                              : Text(""),
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
                                    borderRadius:
                                        new BorderRadius.circular(18.0),
                                    border:
                                        Border.all(color: Colors.deepPurple)),
                                child: Text(
                                  item["date"],
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
                            margin:
                                const EdgeInsets.only(top: 10.0, bottom: 6.0),
                            // color: Colors.red,
                            child: Text(
                              item['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              if (snapshot.hasError) {
                return Text(
                  "Erro",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                );
              }
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
