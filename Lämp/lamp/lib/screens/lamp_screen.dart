import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../widgets/color_sample.dart';
import '../widgets/product_feature.dart';

class LampScreen extends StatelessWidget {
  final Lamp lamp;
  LampScreen({@required this.lamp});

  @override
  Widget build(BuildContext context) {
    return Provider<Lamp>.value(
      value: lamp,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(flex: 5, child: _LampPreview()),
                  Expanded(flex: 6, child: _LampInformation()),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BackButton(),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: _ShoppingCart(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: _AddToCartButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(Icons.shopping_cart),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
                border: Border.all(width: 1, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          'Add to Cart',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _LampPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: _Photo()),
          Expanded(flex: 1, child: _ColorList()),
        ],
      ),
    );
  }
}

class _ColorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ColorSample(color: Colors.white, colorName: 'White'),
        SizedBox(width: 12),
        ColorSample(color: Colors.amber, colorName: 'Yellow', selected: true),
        SizedBox(width: 12),
        ColorSample(color: Colors.orange, colorName: 'orange'),
      ],
    );
  }
}

class _Photo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the lamp
    final Lamp lamp = Provider.of<Lamp>(context);
    return Image.asset(lamp.photo);
  }
}

class _LampInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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

class _Features extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Lamp lamp = Provider.of<Lamp>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var f in lamp.features)
          ProductFeature(
            icon: f.icon,
            units: f.units,
            value: f.value,
          )
      ],
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Lamp lamp = Provider.of<Lamp>(context);
    return Row(
      children: [
        Text(
          lamp.name,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        SizedBox(width: 8),
        Text(
          'lamp',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 22,
          ),
        ),
        Spacer(),
        FloatingActionButton(
          mini: true,
          onPressed: () {},
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Lamp lamp = Provider.of<Lamp>(context);
    return Text(
      lamp.description,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    );
  }
}

class _Price extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Lamp lamp = Provider.of<Lamp>(context);
    return Text(
      '\$${lamp.price}',
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
