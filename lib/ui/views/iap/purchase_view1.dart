import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lta_datamall_flutter/ui/views/app_drawer/app_drawer_view.dart';
import 'package:lta_datamall_flutter/ui/views/iap/purchase_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PurchaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PurchaseViewModel>.reactive(
      fireOnModelReadyOnce: true,
      builder: (context, model, child) {
        var stack = <Widget>[];
        if (model.queryProductError == null) {
          stack.add(
            ListView(
              children: [
                if (model.loading)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                _buildProductList(model)
              ],
            ),
          );
        } else {
          stack.add(
            Center(
              child: Text(model.queryProductError),
            ),
          );
        }

        if (model.purchasePending) {
          stack.add(
            Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: const ModalBarrier(
                      dismissible: false, color: Colors.grey),
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
      },
      viewModelBuilder: () => PurchaseViewModel(),
      onModelReady: (model) {
        model.initialise();
      },
    );
  }

  Card _buildProductList(PurchaseViewModel model) {
    if (!model.isAvailable) {
      return Card();
    }
    var productList = <ListTile>[];
    if (model.notFoundIds) {
      productList.add(
        ListTile(
          title: Text(
            'Items not found',
            style: TextStyle(color: ThemeData.light().errorColor),
          ),
          subtitle: Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.'),
        ),
      );
    }

    productList.addAll(
      model.products.map(
        (ProductDetails productDetails) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
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

                model.buyConsumable(purchaseParam);
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
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(children: <Widget>[productHeader, Divider()] + productList),
    );
  }
}
