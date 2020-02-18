import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;

import '../models/apiNasa.dart';

class ApodList extends StatefulWidget {
  @override
  _ApodListState createState() => _ApodListState();
}

class _ApodListState extends State<ApodList> {
  List items = [];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetchMore();

    _scrollController.addListener(() {
      if ((_scrollController.position.pixels - 800) ==
          (_scrollController.position.maxScrollExtent - 800)) {
        fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Apod'),
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            var item = items[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white24,
              ),
              margin: new EdgeInsets.symmetric(vertical: 7.0),
              child: Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    (item["media_type"] == "image")
                        ? Container(
                            child: HtmlWidget(
                              '<img src="' + item['url'] + '">',
                            ),
                          )
                        : HtmlWidget(
                            '<iframe src="' +
                                item['url'] +
                                '" width="560" height="500"></iframe>',
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
                      margin: const EdgeInsets.only(
                          left: 8.0, top: 6.0, bottom: 6.0, right: 8.0),
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
        ));
  }

  fetch() async {
    ApiNasa apiNasa = new ApiNasa();
    apiNasa.getCurrentUrl();
    apiNasa.setCurrentDate(apiNasa.currentDate.subtract(new Duration(days: 5)));

    print(apiNasa.apiUrl);
    final res = await http.get(apiNasa.apiUrl);

    if (res.statusCode == 200) {
      setState(() {
        items = items + json.decode(res.body).reversed.toList();
      });
    } else {
      throw ("some arbitrary error");
    }
  }

  fetchMore() {
    fetch();
  }
}
