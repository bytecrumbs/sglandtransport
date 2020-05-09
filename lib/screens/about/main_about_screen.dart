import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class MainAboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'LTA Datamall App',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
                'The best app on the market, to consume and display information/data made available by the "LTA Datamall".'),
            Text('- 100% free'),
            Text('- 100% add free'),
            Text('- 100% open-source'),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Support us',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text('- Review on App Store'),
            Text('- Tweet about @sglandtransport'),
            Text('- Like our Facebook page'),
            Text('- Star our public GitHub repo'),
            Text('- Buy us a coffee'),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headline6,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Please refer to ',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  TextSpan(
                    text: 'https://sglandtransport.app/privacy-policy',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        const url =
                            'https://sglandtransport.app/privacy-policy';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
