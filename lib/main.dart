import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10),
    Product(name: 'Product 2', price: 20),
    Product(name: 'Product 3', price: 30),
    Product(name: 'Product 4', price: 30),
    Product(name: 'Product 5', price: 30),
    Product(name: 'Product 6', price: 30),
    Product(name: 'Product 7', price: 30),
    Product(name: 'Product 8', price: 30),
    Product(name: 'Product 9', price: 30),
    Product(name: 'Product 10', price: 30),
    Product(name: 'Product 11', price: 30),
    Product(name: 'Product 12', price: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Product List',style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: ProductCounter(
              onBuyPressed: () {
                setState(() {
                  products[index].incrementCounter();
                  if (products[index].counter == 5) {
                    _showCongratulationsDialog(products[index]);
                  }
                });
              },
              counter: products[index].counter,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(products: products),
            ),
          );
        },
        child: Icon(Icons.shopping_cart ,color: Colors.white,),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showCongratulationsDialog(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 ${product.name}!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter = 0;

  Product({required this.name, required this.price});

  void incrementCounter() {
    counter++;
  }
}

class ProductCounter extends StatelessWidget {
  final Function? onBuyPressed;
  final int counter;

  ProductCounter({required this.onBuyPressed, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Quantity: $counter'),

         Container(
           height: 30,
           child: ElevatedButton(
            child: Text("Buy Now",style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: onBuyPressed as void Function()?,
        ),
         ),


      ],
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalQuantity = products.fold(0, (sum, product) => sum + product.counter);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Cart',style: TextStyle(color: Colors.white)),

      ),
      body: Center(
        child: Text('Total Quantity: $totalQuantity'),
      ),
    );
  }
}
