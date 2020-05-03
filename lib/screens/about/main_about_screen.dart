import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';

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
          children: const <Widget>[
            Text(
              'LTA Datamall App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text('- 100% free'),
            Text('- 100% add free'),
            Text('- 100% open-source'),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Vision',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
                'The best app on the market, to consume and display information/data made available by the "LTA Datamall"'),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Support',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text('- Review on App Store'),
            Text('- Tweet @lta-datamall-app'),
            Text('- Share on Facebook'),
            Text('- Github stars'),
            Text('- Donate'),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text('I think we need a privacy policy?'),
          ],
        ),
      ),
    );
  }
}
