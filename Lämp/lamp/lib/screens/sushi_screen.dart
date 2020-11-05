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

      child: Scaffold
      (
        body: SafeArea
        (
          child: Stack
          (
            children: 
            [
              Column
              (
                children: 
                [
                  Expanded(flex: 3, child: _BottomPreview()),
                ],
              ),

              Column
              (

                children: 
                [
                  Expanded(flex: 7, child: _MiddlePreview()),
                  Expanded(flex: 1, child: Container()),
                  
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children:
                    [
                      _Price(),
                      _AddToCart(),
                      //Expanded(flex: 3, child: _Price()),
                      //Expanded(flex: 4, child: _AddToCart()),
                    ],
                  ),
                  
                  Expanded(flex: 1, child: Container()),
              
                ],
              ),

              Column
              (
                
                children: 
                [
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
                  padding: const EdgeInsets.all(8.0),
                  child: _BackButton(),
                ),
              ),

              Align                                                           // Shopping Cart
              (
                alignment: Alignment.topRight,

                child: Padding
                (
                  padding: const EdgeInsets.all(8.0),
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
    return Container
    (
      decoration: BoxDecoration
      (
        color: Color.fromRGBO(24,29,45,1),
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30) ),
      ),

      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        
        children: 
        [
          Expanded(flex: 1 , child: Text("Sake Roll", style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 35))),
          Expanded(flex: 4, child: _Photo()),
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
      decoration: BoxDecoration
      (
        color: Color.fromRGBO(29,35,53,1),
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30) ),
      ),

      // child: Column
      // (
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
        
      //   children: 
      //   [
      //     Expanded(flex: 3, child: _Photo()),
      //   ],
      // ),
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
      decoration: BoxDecoration
      (
        color: Color.fromRGBO(24,29,45,1),
        //borderRadius: BorderRadius.only( bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30) ),
      ),

      // child: Column
      // (
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
        
      //   children: 
      //   [
      //     Expanded(flex: 3, child: _Photo()),
      //   ],
      // ),
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
      padding: EdgeInsets.fromLTRB(16, 24, 16, 16),

      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        
        children: 
        [
          _Features(),
          _Title(),
          SizedBox(height: 4),
          _Description(),
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
          ProductFeature (icon: f.icon, units: f.units, value: f.value, /* Add More */)
      ],
    );
  }
}

class _Title extends StatelessWidget                                                        // Data container for all the elements that conform the Sushi's title.
{
  @override
  Widget build(BuildContext context) 
  {
    final Sushi sushi = Provider.of<Sushi>(context);

    return Row
    (
      children: 
      [ 
        Text
        (
          'Description',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontWeight: FontWeight.w800, fontSize: 22, /* Add More */),
        ),

        // Text
        // (
        //   sushi.name,
        //   style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800, fontSize: 22, /* Add More */),
        // ),

        //SizedBox(width: 8),

        // Text
        // (
        //   'sushi',
        //   style: TextStyle(fontFamily: 'Poppins', fontSize: 22, /* Add More */),
        // ),

        // Spacer(),

        // FloatingActionButton
        // (
        //   mini: true,
        //   onPressed: () {},
        //   child: Icon(Icons.favorite, color: Colors.white, size: 20, /* Add More */),
        // ),
      ],
    );
  }
}

class _Description extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final Sushi sushi = Provider.of<Sushi>(context);

    // Text
    // (
    //   "Description",
    //   style: TextStyle(fontFamily: 'Poppins', fontSize: 24, color: Colors.white, /* Add More */),
    // );

    return Text
    (
      sushi.description,
      style: TextStyle( fontFamily: 'Poppins', fontSize: 12, color: Colors.grey, /* Add More */),
    );
  }
}

class _Price extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final Sushi sushi = Provider.of<Sushi>(context);
    
    return Text
    (
      '\$${sushi.price}',
      style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w800, /* Add More */),
    );
  }
}

//Buttons
class _LikeButton extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return FloatingActionButton
    (
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Color.fromRGBO(33,40,61, 1))
          ),
          backgroundColor: Color.fromRGBO(29,35,53, 1),
          mini: false,
          onPressed: () {},
          child: Icon(Icons.favorite_outline_sharp, color: Colors.white, size: 35,  /* Add More */),
    );
  }
}

class _BackButton extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return FloatingActionButton
    (
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color.fromRGBO(33,40,61, 1))
          ),
          backgroundColor: Color.fromRGBO(29,35,53, 1),
          mini: false,
          onPressed: () {},
          child: Icon(Icons.keyboard_arrow_left_sharp, color: Colors.white, size: 35, /* Add More */),
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
          //icon: Icon(Icons.save),

          isExtended: true,
          label: Text("Add To Cart"),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(15),
          ),
    );
  }


}
