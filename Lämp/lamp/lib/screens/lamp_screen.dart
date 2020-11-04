import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../widgets/color_sample.dart';
import '../widgets/product_feature.dart';

class LampScreen extends StatelessWidget            // LampScreen(), _ShoppingCart(), _AddToCartButton(), _LampPreview(), _ColorList(), _Photo(),
{                                                   // _LampInformation(), _Features(), _Title(), _Description(), _Price().
  final Lamp lamp;
  LampScreen({ @required this.lamp });

  @override
  Widget build(BuildContext context) 
  {
    return Provider<Lamp>.value( 
      value: lamp,

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
                  Expanded(flex: 7, child: _MidlePreview()),
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
          Expanded(flex: 3, child: _Photo()),
        ],
      ),
    );
  }
}

class _MidlePreview extends StatelessWidget 
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
    // Get the lamp
    final Lamp lamp = Provider.of<Lamp>(context);
    return Image.asset(lamp.photo);
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
          _Title(),
          SizedBox(height: 4),
          _Description(),
          SizedBox(height: 16),
          _Features(),
          Spacer(),
          _Price(),
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
    final Lamp lamp = Provider.of<Lamp>(context);

    return Row
    (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: 
      [
        for (var f in lamp.features)
          ProductFeature (icon: f.icon, units: "20"/*f.units*/, value: f.value, /* Add More */)
      ],
    );
  }
}

class _Title extends StatelessWidget                                                        // Data container for all the elements that conform the Lamp's title.
{
  @override
  Widget build(BuildContext context) 
  {
    final Lamp lamp = Provider.of<Lamp>(context);

    return Row
    (
      children: 
      [
        Text
        (
          lamp.name,
          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w800, fontSize: 22, /* Add More */),
        ),

        SizedBox(width: 8),

        Text
        (
          'lamp',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 22, /* Add More */),
        ),

        Spacer(),

        FloatingActionButton
        (
          mini: true,
          onPressed: () {},
          child: Icon(Icons.favorite, color: Colors.white, size: 20, /* Add More */),
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final Lamp lamp = Provider.of<Lamp>(context);
      
    return Text
    (
      
      lamp.description,
      style: TextStyle( fontSize: 12, color: Colors.grey, /* Add More */),
    );
  }
}

class _Price extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final Lamp lamp = Provider.of<Lamp>(context);
    
    return Text
    (
      '\$${lamp.price}',
      style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', fontWeight: FontWeight.w800, /* Add More */),
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
          mini: true,
          onPressed: () {},
          child: Icon(Icons.favorite, color: Colors.white, size: 20, /* Add More */),
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
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Color.fromRGBO(33,40,61, 1))
          ),
          backgroundColor: Color.fromRGBO(29,35,53, 1),
          mini: true,
          onPressed: () {},
          child: Icon(Icons.arrow_back, color: Colors.white, size: 20, /* Add More */),
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
          label: Text("Add To Cart"),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(15),
          ),
    );
  }


}
