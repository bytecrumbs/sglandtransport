import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class BusViewModel extends BaseViewModel {
  static final _log = Logger('DatabaseProvider');

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void onItemTapped(int index) {
    _currentIndex = index;
    _sendCurrentTabToAnalytics();
    notifyListeners();
  }

  void _sendCurrentTabToAnalytics() {
    _log.info('Implement _sendCurrentTabToAnalytics');
  }
}
