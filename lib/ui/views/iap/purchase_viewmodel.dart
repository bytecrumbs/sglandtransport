import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:stacked/stacked.dart';

const bool kAutoConsume = true;
const List<String> _kProductIds = <String>[
  'big_appreciation',
  'huge_appreciation',
  'gigantic_appreciation',
];

class PurchaseViewModel extends BaseViewModel {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  bool _purchasePending = false;
  String _queryProductError;
  bool _loading = true;
  bool _isAvailable = false;

  bool get purchasePending => _purchasePending;
  List<ProductDetails> get products => _products;
  String get queryProductError => _queryProductError;
  bool get loading => _loading;
  bool get isAvailable => _isAvailable;

  bool get notFoundIds => _notFoundIds.isNotEmpty ? true : false;

  void initialise() {
    Stream purchaseUpdated = _connection.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });

    initStoreInfo();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _purchasePending = true;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _purchasePending = false;
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          _purchasePending = false;
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

  void buyConsumable(PurchaseParam purchaseParam) {
    _connection.buyConsumable(
        purchaseParam: purchaseParam,
        autoConsume: kAutoConsume || Platform.isIOS);
  }

  Future<void> initStoreInfo() async {
    _isAvailable = await _connection.isAvailable();
    if (!_isAvailable) {
      _products = [];
      _notFoundIds = [];
      _purchasePending = false;
      _loading = false;
      return;
    }
    print('querying products');
    var productDetailResponse =
        await _connection.queryProductDetails(_kProductIds.toSet());

    if (productDetailResponse.error != null) {
      _queryProductError = productDetailResponse.error.message;
      updateProductDetails(productDetailResponse);
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      _queryProductError = null;
      updateProductDetails(productDetailResponse);
      return;
    }

    updateProductDetails(productDetailResponse);
    notifyListeners();
  }

  void updateProductDetails(
    var productDetails,
  ) {
    _products = productDetails.productDetails;
    _notFoundIds = productDetails.notFoundIDs;
    _purchasePending = false;
    _loading = false;
  }
}
