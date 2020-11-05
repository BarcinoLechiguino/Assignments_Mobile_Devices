import 'package:flutter/material.dart';

class ProductFeature extends StatelessWidget 
{
  final String  icon;
  final num     value;
  final String  units;
  
  ProductFeature({ @required this.icon, @required this.value, @required this.units });

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      width: 80,
      height: 60,
      
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: 
        [
          Image.asset('assets/icons/$icon.png'),
          
          Text
          (
            '$value $units',
            style: TextStyle
            (
              color: Color.fromARGB(255, 250, 250, 250),
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w300,
              
            ),
          ), 
        ],
      ),
    );
  }
}
