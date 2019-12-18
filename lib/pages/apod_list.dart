import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/models/item.dart';
import 'package:http/http.dart' as http;

class ApodList extends StatefulWidget {
  // var items = new List<Item>();
  var items = [];
  var startDate = "2019-12-1";
  var endDate = "2019-12-17";

  ApodList() {
    items = [];
    items.add(Item(title: "111"));
  }

  @override
  _ApodListState createState() => _ApodListState();
}

class _ApodListState extends State<ApodList> {
  Future fetchData(String startDate, String endDate) async {
    final res = await http.get(
        "https://api.nasa.gov/planetary/apod?api_key=8g23BupBSJXtE86RIMPOYki0ele3dSRvoshr5yLM&start_date=$startDate&end_date=$endDate");

    if (res.statusCode == 200) {
      var itemStr = res.body;

      return itemStr;
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

              // for (var f in valueMap) {
              // setState(() {
              //   widget.items = valueMap;
              // });
              // }

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
                    ),
                    margin: new EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 7.0),
                    padding: new EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 7.0),
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          (item["media_type"] == "image")
                              ? ClipRRect(
                                  child: Image.network(
                                    item['url'],
                                    // 'https://apod.nasa.gov/apod/image/1906/StrawberryMoon_Chasiotis_960.jpg',
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
                              item['title'],
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
              print("?");
              return CircularProgressIndicator();
            }
          },
        )
        // body: ListView.builder(
        //   itemCount: widget.items.length,
        //   itemBuilder: (BuildContext ctxt, int index) {
        //     final item = widget.items[index];
        //     // print(widget.items.length);

        //     print(widget.items.length);
        //     print(widget.items);
        //     return Container(
        //       decoration: BoxDecoration(
        //         color: Colors.grey[200],
        //         borderRadius: new BorderRadius.circular(8.0),
        //       ),
        //       margin: new EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
        //       padding: new EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
        //       child: Column(
        //         children: <Widget>[
        //           Stack(children: <Widget>[
        //             ClipRRect(
        //               child: Image.network(
        //                 'https://apod.nasa.gov/apod/image/1906/StrawberryMoon_Chasiotis_960.jpg',
        //                 fit: BoxFit.cover,
        //               ),
        //               borderRadius: new BorderRadius.circular(7.0),
        //             ),
        //             Center(
        //               child: Align(
        //                 alignment: Alignment.centerRight,
        //                 child: Container(
        //                   margin: new EdgeInsets.symmetric(
        //                       horizontal: 6.0, vertical: 6.0),
        //                   padding: new EdgeInsets.symmetric(
        //                       horizontal: 8.0, vertical: 5.0),
        //                   decoration: BoxDecoration(
        //                     color: Colors.grey[200],
        //                     borderRadius: new BorderRadius.circular(18.0),
        //                   ),
        //                   child: Text(
        //                     "15/12/2019",
        //                     style: TextStyle(
        //                       // fontWeight: FontWeight.bold,
        //                       fontSize: 15,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ]),
        //           Align(
        //             alignment: Alignment.centerLeft,
        //             child: Container(
        //               // color: Colors.red,
        //               child: Text(
        //                 "Título",
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 18,
        //                 ),
        //               ),
        //             ),
        //           ),
        //           Align(
        //             alignment: Alignment.centerLeft,
        //             child: Container(
        //               // color: Colors.red,
        //               child: Text("Descrição"),
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
