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
            AboutHeader(
              headerText: 'SG Land Transport',
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'An open-source project using ',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  TextSpan(
                    text: 'LTA Data Mall',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        const url =
                            'https://www.mytransport.sg/content/mytransport/home/dataMall.html';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                  TextSpan(
                    text:
                        ' to facilitate usage of public and private transport in Singapore.',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            Text('- 100% free'),
            Text('- 100% add free'),
            Text('- 100% open-source'),
            AboutHeader(
              headerText: 'Support us',
            ),
            Text('- Review on App Store'),
            Text('- Tweet about @sglandtransport'),
            Text('- Like our Facebook page'),
            Text('- Star our public GitHub repo'),
            Text('- Buy us a coffee'),
            AboutHeader(
              headerText: 'Privacy Policy',
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

class AboutHeader extends StatelessWidget {
  AboutHeader({@required this.headerText});

  final headerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 5.0),
      child: Text(
        headerText,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
