class Utility {
  String getTimeToBusStop(String arrivalTime, [bool isSuffixShown]) {
    if (arrivalTime == '') {
      return 'n/a';
    }

    final String suffix = isSuffixShown != null && isSuffixShown ? 'min' : '';

    final int arrivalInMinutes =
        DateTime.parse(arrivalTime).difference(DateTime.now()).inMinutes;

    if (arrivalInMinutes <= 2) {
      return 'Arr';
    } else {
      return '${arrivalInMinutes.toString()}$suffix';
    }
  }
}
