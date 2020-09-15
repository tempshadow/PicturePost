import 'dart:convert';
import 'package:Picturepost/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PostData.dart';

Future<List<PostData>> fetchPhotos(http.Client client) async {
  final response =
  await client.get('https://picturepost.ou.edu/app/GetPostList');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<PostData> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<PostData>((json) => PostData.fromJson(json)).toList();
}


// ignore: must_be_immutable
class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new Stack(
          children: <Widget>[
            Container(
              child: new Image.asset("assets/splash.png",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,)
            ),
            Container(
              child: FutureBuilder<List<PostData>>(
                future: fetchPhotos(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? MyApp(posts: snapshot.data,)
                      : new Positioned(
                      child: new Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: CircularProgressIndicator())
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}