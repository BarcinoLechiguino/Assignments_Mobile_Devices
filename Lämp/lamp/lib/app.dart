import 'package:flutter/material.dart';

import 'screens/lamp_screen.dart';

// View
class App extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      
      theme: ThemeData
      (
        primarySwatch: Colors.amber,
      ),
      
      home: LampScreen(lamp: melodiLamp),
    );
  }
}

// Model
class Feature 
{
  final String  icon;
  final num     value;
  final String  units;
  
  Feature ({ this.icon, this.value, this.units });
}

class Lamp 
{
  final String        name;                           // Name of the lamp.
  final Color         color;                          // Color of the background behind the lamp.
  final double        price;                          // Price of the lamp.
  final String        description;                    // Description of the features of the lamp.
  final String        photo;                          // Path to the image of the lamp in the directory.
  final List<Feature> features;                       // A list containing the features of the lamp.
  
  Lamp({ this.name, this.color, this.photo, this.price, this.description, this.features });
}

// Lamp example I
final melodiLamp = Lamp
(
  name: 'Melodi',
  color: Colors.amber,
  price: 15.99,

  description: 'Cupidatat quis deserunt amet aliquip ut ex in tempor. Culpa dolor elit mollit irure occaecat ea mollit anim.',
  
  features: 
  [
    Feature(icon: 'lamp', value: 26, units: 'W'),
    Feature(icon: 'vruler', value: 28, units: 'cm'),
    Feature(icon: 'hruler', value: 26, units: 'cm'),
    Feature(icon: 'plug', value: 1.6, units: 'm'),
  ],
  
  photo: 'assets/sushi_photo.png',
);

// Lamp example II
final blablaLamp = Lamp
( 
  name: 'Bla bla',
  color: Colors.amber,
  price: 1.99,
  
  description: 'Consectetur voluptate incididunt cillum dolor ut non proident dolore. Mollit tempor adipisicing minim ad adipisicing culpa elit.',
  
  features: 
  [
    Feature(icon: 'hruler', value: 26, units: 'cm'),
    Feature(icon: 'plug', value: 1.6, units: 'm'),
  ],

  photo: '',
);