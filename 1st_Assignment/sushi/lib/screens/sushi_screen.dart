import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../widgets/color_sample.dart';
import '../widgets/product_feature.dart';

class SushiScreen extends StatelessWidget            // SushiScreen(), _ShoppingCart(), _AddToCartButton(), _SushiPreview(), _ColorList(), _Photo(),
{                                                   // _SushiInformation(), _Features(), _Title(), _Description(), _Price().
  final Sushi sushi;
  SushiScreen({ @required this.sushi });

  @override
  Widget build(BuildContext context) 
  {
    return Provider<Sushi>.value( 
      value: sushi,

      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: 
            [
              Column(
                children: 
                [
                  Expanded(flex: 1, child: _BottomPreview()),
                ],
              ),

              Column(
                children: 
                [ 
                  Expanded(flex: 7, child: _MiddlePreview()),                  
                  Expanded(flex: 1, child: Container()),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children:
                    [
                      //_Price(),
                      //_AddToCart(),
                      
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: _Price(),
                      ),

                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: _AddToCart(),
                      ),
                    ],
                  ),
                ],
              ),

              Column
              (
                
                children: 
                [
                  Expanded(flex: 1, child: Container(color: Color.fromARGB(255, 24, 29, 45))),
                  Expanded(flex: 4, child: _SushiPreview()),
                  Expanded(flex: 5, child: _SushiInformation()),
                ],
              ),

              
              
              Align                                                           // Back Button
              (
                alignment: Alignment.topLeft,
                //back button
                child: Padding
                (
                  padding: const EdgeInsets.fromLTRB(35.0, 40.0, 20.0, 20.0),
                  child: _BackButton(),
                ),
              ),

              Align                                                           // Shopping Cart
              (
                alignment: Alignment.topRight,

                child: Padding
                (
                  padding: const EdgeInsets.fromLTRB(25.0, 40.0, 35.0, 20.0),
                  child: _LikeButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SushiPreview extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final Sushi sushi = Provider.of<Sushi>(context);

    return Container
    ( 
      //padding: EdgeInsets.only(top: 0),
      
      decoration: BoxDecoration
      (
        color: Color.fromARGB(255, 24, 29, 45),
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(55),bottomRight: Radius.circular(55) ),
      ),

      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: 
        [ 
          Expanded
          (
            flex: 1 , 
            child: Text(
              sushi.name, 
              style: TextStyle
              (
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400, 
                fontSize: 32
              ),

              textAlign: TextAlign.center,
            )
          ),
          
          Expanded
          (
            flex: 4, 
            child: _Photo()
          ),

          _AmountCounter(),
        ],
      ),
    );
  }
}

class _MiddlePreview extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 29, 35, 53),
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(55),bottomRight: Radius.circular(55), ),
      ),
    );
  }
}

class _BottomPreview extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Container
    ( 
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 24, 29, 45),
        //borderRadius: BorderRadius.only( bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30) ),
      ),
    );
  }
}

class _Photo extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    // Get the Sushi
    final Sushi sushi = Provider.of<Sushi>(context);
    return Image.asset(sushi.photo, scale: 1.35);
  }
}

class _SushiInformation extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  { 
    return Container
    (
      //padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
      padding: EdgeInsets.fromLTRB(25, 80, 25, 25),

      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        
        children: 
        [
          _Features(),

          Container(
            padding: EdgeInsets.only(top: 40.0),
            child: _Title(),
          ),

          SizedBox(height: 4),
          
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: _Description(),
          ),

          SizedBox(height: 16),

          Spacer(),
          //_Price(),
        ],
      ),
    );
  }
}

class _Features extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final Sushi sushi = Provider.of<Sushi>(context);

    return Row
    (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: 
      [
        for (var f in sushi.features)
          ProductFeature (icon: f.icon, units: f.units, value: f.value, )
      ],
    );
  }
}

class _Title extends StatelessWidget                                                        // Data container for all the elements that conform the Sushi's title.
{
  @override
  Widget build(BuildContext context) 
  { 
    return Text(
      'Description',
      style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22, /* Add More */),
      );
  }
}

class _Description extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final Sushi sushi = Provider.of<Sushi>(context);

    return Text(
        sushi.description,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color.fromARGB(255, 142, 156, 182), fontWeight: FontWeight.w300,)
    );
  }
}

class _Price extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final Sushi sushi = Provider.of<Sushi>(context);
    
    return Text(
      '\$${sushi.price}',
      style: TextStyle(fontSize: 30.0, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400, ),
    );
  }
}

//Buttons
class _BackButton extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return FloatingActionButton
    (
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color.fromARGB(255, 43, 50, 71))
          ),

          backgroundColor: Color.fromARGB(255, 29, 35, 53),
          mini: false,
          onPressed: () {},
          child: Icon(Icons.keyboard_arrow_left_sharp, color: Colors.white, size: 35, ),
    );
  }
}

class _LikeButton extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return FloatingActionButton
    (
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color.fromARGB(255, 43, 50, 71))
          ),

          backgroundColor: Color.fromARGB(255, 29, 35, 53),
          mini: false,
          onPressed: () {},
          child: Icon(Icons.favorite_outline_sharp, color: Colors.white, size: 35, ),
    );
  }
}

class _AmountCounter extends StatelessWidget
{
  int count = 1;

  @override
  Widget build(BuildContext context)
  {    
    return Row(
       mainAxisAlignment: MainAxisAlignment.center,

       children: 
       [
         FloatingActionButton(
           shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(color: Color.fromARGB(255, 43, 50, 71))
            ),

            backgroundColor: Color.fromARGB(255, 24, 29, 45),
            mini: false,
            child: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 35, ),

            onPressed: () {--count;},
         ),

         Container(
           color: Color.fromARGB(255, 24, 29, 45),
           margin: EdgeInsets.all(20.0),
           child: Text(
             '$count', 
             style: TextStyle(
               fontSize: 25.0,
               color: Colors.white,
               fontFamily: 'Poppins', 
               fontWeight: FontWeight.w500,
               ),

               textAlign: TextAlign.center,
            ),
         ),

         FloatingActionButton(
           shape: RoundedRectangleBorder( 
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(color: Color.fromARGB(255, 43, 50, 71))
            ),

            backgroundColor: Color.fromARGB(255, 24, 29, 45),
            mini: false,
            child: Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 35, ),

            onPressed: () {++count;},
         ),
       ],
    );
  }
}

class _AddToCart extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return FloatingActionButton.extended
    (
          onPressed: () {},

          backgroundColor: Color.fromARGB(255, 255, 59, 47),
          isExtended: true,
          label: Text("Add To Cart"),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(16),
          ),
    );
  }
}

class _PriceAndAddToCart extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {

  }
}