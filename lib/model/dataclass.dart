import 'package:flutter/material.dart';

class Lipstick {
  String brand;
  String name;
  //String price;
  //String price_sign;
  String image_link;
  //String product_link;
  String description;
  String product_type;
  // List<Colours> product_colors;

  Lipstick ({
    required this.brand,
    required this.name,
    //required this.price,
    //required this.price_sign,
    required this.image_link,
    // required this.product_link,
    required this.description,
    required this.product_type,
    // required this.product_colors,
  });

  factory Lipstick.fromJson(Map<String, dynamic> json) {
    return Lipstick (
      brand: json['brand'],
      name: json['name'],
      //price: json['price'],
      //price_sign: json['price_sign'],
      image_link: json['image_link'],
      //product_link: json['product_link'],
      description: json['description'],
      product_type: json['product_type'],
      // product_colors: (json['product_colors'] as List<dynamic>?)
      //     ?.map((product_colorsJson) => Colours.fromJson(product_colorsJson))
      //     .toList() ?? [],
    ); //Lipstick
  }
}

class Detail_Page extends StatelessWidget {
  final Lipstick lipstick;

  Detail_Page({required this.lipstick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lipstick.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(lipstick.image_link),
            ),
            SizedBox(height: 20),
            Text(
              'Product Type: ${lipstick.product_type}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Brand: ${lipstick.brand}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '${lipstick.description}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}



