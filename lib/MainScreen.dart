import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobswire/newsDetail.dart';
import 'model/DataModel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<Result>> getData() {
    var httpsUri = Uri(
      scheme: 'https',
      host: 'api.collectapi.com',
      path: '/news/getNews',
      queryParameters: {'country': 'de', 'tag': 'sport'},
    );
    return http.get(httpsUri, headers: {
      'content-type': 'application/json',
      'authorization': 'apikey 4GBAhmgZzHJYyljHyEab6X:3NHy2ZQKiPmDgFTwd0g9XK'
    }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      var jsonArray = jsonDecode(res);
      Data data;
      List<Result> newList = [];
      if (statusCode == 200) {
        data = Data.fromMap(jsonArray);
        newList = data.result;
      }
      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Result>> newsData;
    newsData = getData();
    MediaQueryData _mediaQueryData;
    double screenWidth;
    double screenHeight;
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: const Text("Main Screen")),
      body: SafeArea(
        child: FutureBuilder<List<Result>>(
          future: newsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Result result = snapshot.data!.elementAt(index);
                    return buildNewsCard(screenWidth, result);
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Card buildNewsCard(double screenWidth, Result result) {
    Key key = Key(result.key);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            width: screenWidth * 0.8,
            child: Image.network(
              result.image,
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            title: Text(result.name),
            subtitle: Text(
              "Kaynak : " + result.source,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: const Color(0xFF6200EE),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(key: key, newsDetail: result)),
                  );
                },
                child: const Text('Detay'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
