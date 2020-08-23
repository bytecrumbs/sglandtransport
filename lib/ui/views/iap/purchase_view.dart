import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lta_datamall_flutter/ui/views/app_drawer/app_drawer_view.dart';

const bool kAutoConsume = true;

const List<String> _kProductIds = <String>[
  'big_appreciation',
  'huge_appreciation',
  'gigantic_appreciation',
];

class MarketScreen extends StatefulWidget {
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String _queryProductError;

  @override
  void initState() {
    Stream purchaseUpdated = _connection.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  void updateProductDetails(
    bool isAvailable,
    var productDetails,
  ) {
    _isAvailable = isAvailable;
    _products = productDetails.productDetails;
    _notFoundIds = productDetails.notFoundIDs;
    _purchasePending = false;
    _loading = false;
  }

  Future<void> initStoreInfo() async {
    final isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _notFoundIds = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    print('querying products');
    var productDetailResponse =
        await _connection.queryProductDetails(_kProductIds.toSet());

    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error.message;
        updateProductDetails(isAvailable, productDetailResponse);
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        updateProductDetails(isAvailable, productDetailResponse);
      });
      return;
    }

    setState(() {
      updateProductDetails(isAvailable, productDetailResponse);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            if (_loading)
              Center(
                child: CircularProgressIndicator(),
              ),
            _buildProductList(),
          ],
        ),
      );
    } else {
      stack.add(
        Center(
          child: Text(_queryProductError),
        ),
      );
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text('Thank you!'),
      ),
      drawer: AppDrawerView(),
      body: Stack(
        children: stack,
      ),
    );
  }

  Card _buildProductList() {
    if (!_isAvailable) {
      return Card();
    }
    var productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(
        ListTile(
          title: Text(
            '[${_notFoundIds.join(", ")}] not found',
            style: TextStyle(color: ThemeData.light().errorColor),
          ),
          subtitle: Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.'),
        ),
      );
    }

    productList.addAll(
      _products.map(
        (ProductDetails productDetails) {
          return ListTile(
            title: Text(
              productDetails.title,
            ),
            subtitle: Text(
              productDetails.description,
            ),
            trailing: FlatButton(
              child: Text(productDetails.price),
              color: Colors.green[800],
              textColor: Colors.white,
              onPressed: () {
                var purchaseParam = PurchaseParam(
                  productDetails: productDetails,
                );

                _connection.buyConsumable(
                    purchaseParam: purchaseParam,
                    autoConsume: kAutoConsume || Platform.isIOS);
              },
            ),
          );
        },
      ),
    );

    final productHeader = ListTile(
      title: Text(
          'We dislike ads, and we dislike in-app purchases that will grant access to special features.\n\nTherefore, SG Land Transport is and always will be completely free and ad-free, and all the features will be available for everyone.\n\nHowever, if you appreciate the app and use it often, you can support us by buying a token of appreciation for us, which will allow us to buy some coffees to keep us awake when we work late in the night on the next feature of this app...'),
    );

    productList.sort((productA, productB) =>
        productA.title.toString().compareTo(productB.title.toString()));

    return Card(
      child: Column(children: <Widget>[productHeader, Divider()] + productList),
    );
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    setState(() {
      _purchasePending = false;
    });
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          deliverProduct(purchaseDetails);
        }
        if (Platform.isAndroid) {
          if (!kAutoConsume) {
            await _connection.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _connection.completePurchase(purchaseDetails);
        }
      }
    });
  }
}
