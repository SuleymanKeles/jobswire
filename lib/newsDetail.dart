import 'package:flutter/material.dart';
import 'model/DataModel.dart';

class DetailScreen extends StatefulWidget {
  final Result newsDetail;

  const DetailScreen({required Key key, required this.newsDetail})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState(newsDetail);
}

class _DetailScreenState extends State<DetailScreen> {



  final Result newsDetail;

  _DetailScreenState(this.newsDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          newsDetail.source,
          style: const TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.network(newsDetail.image),
                const SizedBox(
                  height: 10.0,
                ),
                Text(newsDetail.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  newsDetail.source,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  newsDetail.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

