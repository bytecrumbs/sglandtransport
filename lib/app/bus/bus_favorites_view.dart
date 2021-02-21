import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/error_view.dart';
import '../../common_widgets/staggered_animation.dart';
import '../failure.dart';
import 'bus_favorites_viewmodel.dart';
import 'bus_stop_card.dart';
import 'models/bus_stop_model.dart';

/// Provides the list of favorite bus stops
final favoriteBusStopsFutureProvider =
    FutureProvider<List<BusStopModel>>((ref) async {
  final vm = ref.read(busFavoritesViewModelProvider);
  return vm.getFavoriteBusStops();
});

/// The main view that shows favorite Bus Stops
class BusFavoritesView extends HookWidget {
  /// The default constructor
  const BusFavoritesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteBusStops = useProvider(favoriteBusStopsFutureProvider);
    final busFavVMProvider = useProvider(busFavoritesViewModelProvider);
    return favoriteBusStops.when(
      data: (favoriteBusStops) {
        return favoriteBusStops.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    'No favorite bus stops found...',
                    key: ValueKey('noFavouriteBusStopsFound'),
                  ),
                ),
              )
            : AnimationLimiter(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: favoriteBusStops.length,
                    itemBuilder: (context, index) {
                      return StaggeredAnimation(
                        index: index,
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: Dismissible(
                            key: Key(
                              favoriteBusStops[index].toString(),
                            ),
                            background: _slideBackgroundWidget(),
                            direction: DismissDirection.endToStart,
                            // ignore: missing_return
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: const Text(
                                          'Are you sure you want to delete?'),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () async {
                                            final removedItem = favoriteBusStops
                                                .removeAt(index);
                                            await busFavVMProvider
                                                .removeBusStopFromFavorites(
                                                    removedItem);
                                            context.refresh(
                                                busFavoritesViewModelProvider);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {}
                            },
                            child: BusStopCard(
                              busStopModel: favoriteBusStops[index],
                              key: ValueKey<String>('busStopCard-$index'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
      },
      loading: () => Container(),
      error: (err, stack) {
        if (err is Failure) {
          return ErrorView(message: err.message);
        }
        return const ErrorView(
          message: 'Something unexpected happened!',
        );
      },
    );
  }

  Widget _slideBackgroundWidget() => Container(
        color: Colors.red,
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              ' Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      );
}
