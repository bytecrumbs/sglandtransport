class Utility {
  String getTimeToBusStop(String arrivalTime) {
    if (arrivalTime == '') {
      return 'No timing found';
    }

    final int arrivalInMinutes =
        DateTime.parse(arrivalTime).difference(DateTime.now()).inMinutes;

    if (arrivalInMinutes <= 2) {
      return 'Bus arriving soon';
    } else {
      return 'Bus arriving in ${arrivalInMinutes.toString()} minutes';
    }
  }
}
