import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/about/about_view.dart';
import 'package:lta_datamall_flutter/ui/views/app_drawer/app_drawer_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppDrawerViewModel>.nonReactive(
      builder: (context, model, child) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            for (var item in model.getActiveFeatures())
              ListTile(
                leading: item.icon,
                title: Text(item.title),
                onTap: () {
                  // only navigate to a new page if a new section is tapped
                  if (ModalRoute.of(context).settings.name == item.routeName) {
                    Navigator.pop(context);
                  } else {
                    model.navigateTo(item.routeName);
                  }
                },
              ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text('Support Us'),
              onTap: () async {
                const url = 'https://ko-fi.com/sglandtransport';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            AboutListTile(
              icon: Icon(Icons.info_outline),
              applicationName: 'SG Land Transport',
              applicationVersion: model.version,
              applicationLegalese: 'free | ad-free | open-source',
              applicationIcon: Icon(Icons.info_outline),
              aboutBoxChildren: <Widget>[AboutView()],
            ),
          ],
        ),
      ),
      viewModelBuilder: () => AppDrawerViewModel(),
    );
  }
}
