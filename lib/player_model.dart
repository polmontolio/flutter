import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Player {
  final String name;
  final String position;
  final String description;
  String imageUrl;

  int rating = 10;

  Player(this.name, this.position, this.description);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = new HttpClient();
    try {
      var uri = new Uri.http('raw.githubusercontent.com', '/polmontolio/flutter/master/players/'+ this.name + ".json");
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      imageUrl = json.decode(responseBody)['message'];
    } catch (exception) {
      print(exception);
    }
  }
}
