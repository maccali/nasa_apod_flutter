import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/apiNasa.dart';

class ApodList extends StatefulWidget {
  // var items = new List<Item>();
  var items = [];
  var endDate = "";
  var limitReq = 1;
  var countReq = 0;
  ApiNasa apiNasa = new ApiNasa();

  // limite de 6 request IM APOD API per second (5)
  // var endDate = new DateFormat("yMd");

  ApodList() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var formatted = formatter.format(now);

    endDate = formatted.toString();

    items = [];

    // ApiNasa apiNasa = new ApiNasa();
    apiNasa.endDate = endDate;
    apiNasa.startDate = '2020-1-1';

    print(apiNasa.apiUrl);
  }

  @override
  _ApodListState createState() => _ApodListState();
}

class _ApodListState extends State<ApodList> {
  Future fetchData() async {
    final res = await http.get(widget.apiNasa.apiUrl);

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
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var valueMap = [];
              String dataItem = snapshot.data;
              valueMap = json.decode(dataItem);
              Iterable inReverseValueMap = valueMap.reversed;
              valueMap = inReverseValueMap.toList();
              var c = 0;

              return ListView.builder(
                itemCount: valueMap.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  final item = valueMap[index];

                  c++;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white24,
                    ),
                    margin: new EdgeInsets.symmetric( vertical: 7.0),
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          (item["media_type"] == "image")
                              ?
                              // CachedNetworkImage(
                              //     imageUrl:
                              //         "http://via.placeholder.com/350x150",
                              //     placeholder: (context, url) =>
                              //         CircularProgressIndicator(),
                              //     errorWidget: (context, url, error) =>
                              //         Icon(Icons.error),
                              //   )
                              Container(
                                  child: HtmlWidget(
                                    '<img src="' + item['url'] + '">',
                                  ),
                                )
                              : HtmlWidget(
                                  '<iframe src="' + item['url'] + '" width="560" height="500"></iframe>',
                                  webView: true,
                                ),
                          Center(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 6.0),
                                padding: new EdgeInsets.symmetric(
                                    horizontal: 9.0, vertical: 7.0),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                ),
                                child: Text(
                                  item["date"],
                                  style: TextStyle(
                                    color: Colors.white,
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
                                const EdgeInsets.only(left: 8.0, top: 6.0, bottom: 6.0, right: 8.0),
                            
                            child: Text(
                              item['title'],
                              style: TextStyle(
                                color: Colors.white,
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
