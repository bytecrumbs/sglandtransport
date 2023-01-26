import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'header.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyText22 = Theme.of(context).textTheme.bodyMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'An open-source project using ',
                style: bodyText22,
              ),
              _buildTextSpanWithTapGesture(
                'LTA Data Mall',
                'https://datamall.lta.gov.sg/content/datamall/en.html',
              ),
              TextSpan(
                text: ' to facilitate usage of public and private transport in '
                    'Singapore.',
                style: bodyText22,
              ),
            ],
          ),
        ),
        const AboutHeader(
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
                'bytecrumbs/sglandtransport',
                'https://github.com/bytecrumbs/sglandtransport',
              ),
            ],
          ),
        ),
        const AboutHeader(
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
      style: const TextStyle(color: Colors.blue),
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          if (await canLaunchUrlString(url)) {
            await launchUrlString(url);
          } else {
            throw Exception('Could not launch $url');
          }
        },
    );
  }
}
