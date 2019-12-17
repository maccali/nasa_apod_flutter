import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/models/item.dart';

class ApodList extends StatefulWidget {
  var items = new List<Item>();

  ApodList() {
    items = [];
    items.add(Item(title: "test 1", done: false));
    items.add(Item(title: "test 2", done: false));
    items.add(Item(title: "test 3", done: false));

    dateArray();
  }

  @override
  _ApodListState createState() => _ApodListState();
}

dateArray() {
  DateTime startDate = new DateTime(1995, 6, 15);
  DateTime endDate = new DateTime.now();
  print(startDate);
  print(endDate);
}

convertDate(){
  
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
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.items[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              // border: Border.all(color: Colors.yellowAccent[700]),
              borderRadius: new BorderRadius.circular(8.0),
            ),
            margin: new EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
            padding: new EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
            child: Column(
              children: <Widget>[
                Stack(children: <Widget>[
                  ClipRRect(
                    child: Image.network(
                      // 'http://www2.carosouvintes.org.br/wp-content/uploads/cat-pixabay-3442257_1280.jpg',
                      'https://apod.nasa.gov/apod/image/1906/StrawberryMoon_Chasiotis_960.jpg',
                      // 'https://i.ytimg.com/vi/Hov5Sv8fBDY/hqdefault.jpg',
                      // 'https://i.ytimg.com/vi/iAczTzD5Sko/maxresdefault.jpg',
                      fit: BoxFit.cover,
                    ),
                    borderRadius: new BorderRadius.circular(7.0),
                  ),
                  // DecoratedBox(
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: NetworkImage(
                  //             "https://apod.nasa.gov/apod/image/1906/StrawberryMoon_Chasiotis_960.jpg"),
                  //         fit: BoxFit.cover),
                  //   ),
                  //   // child: Center(child: FlutterLogo(size: 300)),
                  // ),
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
                          // border: Border.all(color: Colors.yellowAccent[700]),
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
