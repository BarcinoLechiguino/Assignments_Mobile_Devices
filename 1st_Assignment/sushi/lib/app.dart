import 'package:flutter/material.dart';

import 'screens/sushi_screen.dart';

// View
class App extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,

      title: '1st Assignment',
      
      theme: ThemeData(primarySwatch: Colors.red, ),
      
      home: SushiScreen(sushi: sake_roll)
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

class Sushi 
{
  final String        name;                           // Name of the Sushi.
  final Color         color;                          // Color of the background behind the Sushi.
  final String        price;                          // Price of the Sushi.
  final String        description;                    // Description of the features of the Sushi.
  final String        photo;                          // Path to the image of the Sushi in the directory.
  final List<Feature> features;                       // A list containing the features of the Sushi.
  
  Sushi({ this.name, this.color, this.photo, this.price, this.description, this.features });
}

// Sushi container
final sake_roll = Sushi
(
  name: 'Sake Roll',
  color: Color.fromARGB(255, 24, 29, 45),
  price: "14,50",

  description: 'Sake is produced by a leavening process and converting starch into sugar. It may sound simple, but the entire process can take a few months.',
  
  features: 
  [
    Feature(icon: 'fire', value: 130, units: 'cal'),
    Feature(icon: 'alarm_clock', value: 15, units: '- 20 min'),
    Feature(icon: 'starry_eyes', value: 4.9, units: 'vote'),
    Feature(icon: 'weighting_machine', value: 350, units: 'g'),
  ],
  
  photo: 'assets/sushi_photo_nearest.png',
);