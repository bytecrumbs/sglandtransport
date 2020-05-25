import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class MainAboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bodyText22 = Theme.of(context).textTheme.bodyText2;
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
                    style: bodyText22,
                  ),
                  _buildTextSpanWithTapGesture(
                    'LTA Data Mall',
                    'https://www.mytransport.sg/content/mytransport/home/dataMall.html',
                  ),
                  TextSpan(
                    text:
                        ' to facilitate usage of public and private transport in Singapore.',
                    style: bodyText22,
                  ),
                ],
              ),
            ),
            Text('- 100% free'),
            Text('- 100% ad-free'),
            Text('- 100% open-source'),
            AboutHeader(
              headerText: 'Support us',
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '- ',
                    style: bodyText22,
                  ),
                  _buildTextSpanWithTapGesture(
                    'Tweet ',
                    'https://twitter.com/intent/tweet?screen_name=sgltapp&text=is+awesome!',
                  ),
                  TextSpan(
                    text: 'about us',
                    style: bodyText22,
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '- Like and Share our ',
                    style: bodyText22,
                  ),
                  _buildTextSpanWithTapGesture(
                    'Facebook page',
                    'https://www.facebook.com/sglandtransportapp',
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '- Star our public ',
                    style: bodyText22,
                  ),
                  _buildTextSpanWithTapGesture(
                    'GitHub repo',
                    'https://github.com/sderungs99/sglandtransport',
                  ),
                ],
              ),
            ),
            AboutHeader(
              headerText: 'Feedback',
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '- Create an ',
                    style: bodyText22,
                  ),
                  _buildTextSpanWithTapGesture(
                    'Issue on GitHub',
                    'https://github.com/sderungs99/sglandtransport/issues',
                  ),
                  TextSpan(
                    text: ' to report a Bug or raise a Feature request',
                    style: bodyText22,
                  ),
                ],
              ),
            ),
            AboutHeader(
              headerText: 'Privacy Policy',
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Please refer to ',
                    style: bodyText22,
                  ),
                  _buildTextSpanWithTapGesture(
                    'https://sglandtransport.app/about',
                    'https://sglandtransport.app/about',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan _buildTextSpanWithTapGesture(String title, String url) {
    return TextSpan(
      text: title,
      style: TextStyle(color: Colors.blue),
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
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
