import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_api_prak/model/dataclass.dart';

class List_Page extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<List_Page> {
  late Future<List<Lipstick>> _lipstickList;

  @override
  void initState() {
    super.initState();
    _lipstickList = _fetchLipstickData();
  }

  Future<List<Lipstick>> _fetchLipstickData() async {
    final response = await http.get(
        Uri.parse('https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Lipstick.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data produk');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<Lipstick>>(
        future: _lipstickList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final lipstick = snapshot.data![index];
                return ListTile(
                  title: Text(lipstick.name),
                  onTap: () {
                    // Navigasi ke halaman detail saat item diklik
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail_Page(lipstick: lipstick),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}