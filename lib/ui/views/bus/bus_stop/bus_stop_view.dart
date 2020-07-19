import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_stop/bus_stop_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:substring_highlight/substring_highlight.dart';

class BusStopView extends StatelessWidget {
  const BusStopView({
    Key key,
    @required this.busStopModel,
    this.searchTerm = '',
  }) : super(key: key);

  final BusStopModel busStopModel;
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusStopViewModel>.nonReactive(
      builder: (context, model, child) => Card(
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
                        text:
                            '${busStopModel.busStopCode} | ${busStopModel.roadName}',
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
            model.navigateToBusArrival(
              busStopModel.busStopCode,
              busStopModel.description,
            );
          },
        ),
      ),
      viewModelBuilder: () => BusStopViewModel(),
    );
  }
}
