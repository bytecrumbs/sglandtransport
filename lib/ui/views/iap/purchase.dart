import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

final String testID = 'another_token';

class MarketScreen extends StatefulWidget {
  @override
  MarketScreenState createState() => MarketScreenState();
}

class MarketScreenState extends State<MarketScreen> {
  bool _available = true;

  /// The In App Purchase plugin
  final InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  /// Products for sale
  List<ProductDetails> _products = [];

  /// Past purchases
  List<PurchaseDetails> _purchases = [];

  /// Updates to purchases
  StreamSubscription _subscription;

  /// Consumable credits the user can buy

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    // _subscription.cancel();
    super.dispose();
  }

  /// Initialize data
  void _initialize() async {
    // Check availability of In App Purchases
    _available = await _iap.isAvailable();

    if (_available) {
      await _getProducts();
      await _getPastPurchases();

      // Verify and deliver a purchase with your own business logic
      // _verifyPurchase();
    }

    _subscription = _iap.purchaseUpdatedStream.listen((data) => setState(() {
          print('NEW PURCHASE');
          _purchases.addAll(data);
          _iap.completePurchase(data[0]);
          // _verifyPurchase();
        }));
  }

  Future<void> _getProducts() async {
    var ids = <String>{testID};
    var response = await _iap.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
    });
  }

  /// Gets past purchases
  Future<void> _getPastPurchases() async {
    var response = await _iap.queryPastPurchases();

    for (var purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        await _iap.completePurchase(purchase);
      }
    }

    setState(() {
      _purchases = response.pastPurchases;
    });
  }

  /// Returns purchase of specific product ID
  // PurchaseDetails _hasPurchased(String productID) {
  //   return _purchases.firstWhere((purchase) => purchase.productID == productID,
  //       orElse: () => null);
  // }

  /// Your own business logic to setup a consumable
  // void _verifyPurchase() {
  //   var purchase = _hasPurchased(testID);

  //   if (purchase != null && purchase.status == PurchaseStatus.purchased) {
  //     credits = 10;
  //   }
  // }

  void _buyProduct(ProductDetails prod) async {
    var purchaseParam = PurchaseParam(productDetails: prod);
    await _iap.buyConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_available ? 'Open for Business' : 'Not Available'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var prod in _products) ...[
              // ignore: deprecated_member_use
              Text(prod.title, style: Theme.of(context).textTheme.headline),
              Text(prod.description),
              Text(prod.price,
                  style: TextStyle(color: Colors.greenAccent, fontSize: 60)),
              FlatButton(
                child: Text('Buy It'),
                color: Colors.green,
                onPressed: () => _buyProduct(prod),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
