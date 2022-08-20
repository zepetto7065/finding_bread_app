import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpPage extends StatefulWidget {
  @override
  State<HttpPage> createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  List<Shop> _datas = [];
  var _text = "Http Example";

  void getShopList(query) async {
    String url = 'http://zepetto.synology.me:9090/api/shops?query=';
    final response = await http.get(Uri.parse(url + '금천'));
    _text = utf8.decode(response.bodyBytes);

    var dataObjsJson = jsonDecode(_text)['data'] as List;
    List<Shop> parsedResponse = dataObjsJson.map((e) => Shop.fromJson(e)).toList();

    setState(() {
      _datas.clear();
      _datas.addAll(parsedResponse);
    });

  }

  @override
  void initState() {
    super.initState();
    getShopList('금천');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _datas.length,
            itemBuilder:(context,  index) {
              final shop = _datas[index];
              return ListTile(
                title: Text(shop.title)
              );
            },
        ),
      )
    );
  }
}

class Shop {
  final int id;
  final String title;
  final String link;
  final String address;
  // final String telephone;
  final String roadAddress;
  final int mapx;
  final int mapy;
  final String createdDate;
  final String modifiedDate;

  Shop({
    required this.id,
    required this.title,
    required this.link,
    required this.address,
    // required this.telephone,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
    required this.createdDate,
    required this.modifiedDate
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
      return Shop(
        id: json['id'] as int,
        title: json['title'] as String,
        link: json['link'] as String,
        address: json['address'] as String,
        // telephone: json['telephone'] as String,
        roadAddress: json['roadAddress'] as String,
        mapx: json['mapx'] as int,
        mapy: json['mapy'] as int,
        createdDate: json['createdDate'] as String,
        modifiedDate: json['modifiedDate'] as String,
      );
    }

  @override
  String toString() {
    return '{${this.title}, ${this.address}';
  }
}