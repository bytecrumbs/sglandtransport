import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class AppRater {
  RateMyApp _rateMyApp;
  static final AppRater _singleton = AppRater._internal();

  factory AppRater() {
    return _singleton;
  }

  AppRater._internal() {
    _rateMyApp = RateMyApp(
      minDays: 3,
      preferencesPrefix: 'rateMySGLandTransportApp_',
      minLaunches: 10,
      remindDays: 5,
      remindLaunches: 10,
    );
  }

  void showRateMyApp(BuildContext context) {
    _rateMyApp.init().then(
          (_) => {
            if (_rateMyApp.shouldOpenDialog)
              {
                _rateMyApp.showStarRateDialog(
                  context,
                  title: 'Enjoying SG Land Transport?',
                  message: 'Let us know what you think',
                  actionsBuilder: (context, stars) {
                    return [
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () async {
                          (stars == null ? '0' : _rateMyApp.launchStore());
                          await _rateMyApp
                              .callEvent(RateMyAppEventType.rateButtonPressed);
                          Navigator.pop<RateMyAppDialogButton>(
                              context, RateMyAppDialogButton.rate);
                        },
                      )
                    ];
                  },
                  ignoreIOS: false,
                  dialogStyle: DialogStyle(
                    titleAlign: TextAlign.center,
                    messageAlign: TextAlign.center,
                    messagePadding: EdgeInsets.only(bottom: 20),
                  ),
                  starRatingOptions: StarRatingOptions(),
                  onDismissed: () => _rateMyApp.callEvent(
                    RateMyAppEventType.laterButtonPressed,
                  ),
                )
              }
          },
        );
  }
}
