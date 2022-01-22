const ltaDatamallApi = 'http://datamall2.mytransport.sg/ltaodataservice';

/// The key that is stored in the local storage for the favorite bus stops
const String favoriteBusStopsKey = 'favouriteBusStopsKey';

/// The key that is stored in the local storage for the favorite bus stops
const String favoriteServiceNoKey = 'favouriteServiceNoKey';

/// The delimiter that is used when favorite bus service no together
/// with bus stop code is saved (e.g. 01019~12)
const String busStopCodeServiceNoDelimiter = '~';

/// Used to read if the user's last selection in Bus section was either
/// "Nearby" or "Favorites"
const String bottomBarIndexKey = 'bottomBarIndex';

/// defines the interval of when the bus arrival information should
/// be refreshed
const busArrivalRefreshDuration = Duration(minutes: 1);
