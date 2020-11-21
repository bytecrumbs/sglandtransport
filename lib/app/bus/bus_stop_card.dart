import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'models/bus_stop_model.dart';

class BusStopCard extends StatelessWidget {
  const BusStopCard({
    Key key,
    @required this.busStopModel,
    this.searchTerm = '',
  }) : super(key: key);

  final BusStopModel busStopModel;
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 12),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: SubstringHighlight(
                        text: busStopModel.description,
                        term: searchTerm,
                        textStyle: Theme.of(context).textTheme.headline1,
                        textStyleHighlight: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                    ),
                    SubstringHighlight(
                      text: '${busStopModel.busStopCode} | '
                          '${busStopModel.roadName}',
                      term: searchTerm,
                      textStyle: Theme.of(context).textTheme.headline2,
                      textStyleHighlight: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
              ),
            ),
            busStopModel.distanceInMeters != null
                ? Center(
                    child: Text(
                      '${busStopModel.distanceInMeters.toString()} m',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : Text('')
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: Theme.of(context).primaryColor,
        ),
        onTap: () {
          print('moving to next page');
          // model.navigateToBusArrival(
          //   busStopModel.busStopCode,
          //   busStopModel.description,
          // );
        },
      ),
    );
  }
}
