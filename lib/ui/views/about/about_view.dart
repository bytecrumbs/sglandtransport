import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bodyText22 = Theme.of(context).textTheme.bodyText2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 24),
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
        AboutHeader(
          headerText: 'Official Links',
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '- Website: ',
                style: bodyText22,
              ),
              _buildTextSpanWithTapGesture(
                'sglandtransport.app',
                'https://sglandtransport.app',
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '- Twitter: ',
                style: bodyText22,
              ),
              _buildTextSpanWithTapGesture(
                '@sgltapp',
                'https://twitter.com/sgltapp',
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '- Facebook: ',
                style: bodyText22,
              ),
              _buildTextSpanWithTapGesture(
                'sglandtransportapp',
                'https://www.facebook.com/sglandtransportapp',
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '- GitHub: ',
                style: bodyText22,
              ),
              _buildTextSpanWithTapGesture(
                'sderungs99/sglandtransport',
                'https://github.com/sderungs99/sglandtransport',
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
              _buildTextSpanWithTapGesture(
                'https://sglandtransport.app/about',
                'https://sglandtransport.app/about',
              ),
            ],
          ),
        ),
      ],
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
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
      child: Text(
        headerText,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
