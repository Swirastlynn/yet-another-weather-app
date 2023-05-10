class WindCalculator {

  String windRating(double windSpeed) {
    if (windSpeed >= 0 && windSpeed <= 5) {
      return 'Light winds';
    } else if (windSpeed > 5 && windSpeed <= 10) {
      return 'Medium winds';
    } else if (windSpeed > 10 && windSpeed <= 15) {
      return 'Strong winds';
    } else if (windSpeed > 15) {
      return 'Tornadoooo';
    } else {
      return 'Incorrect data';
    }
  }
}
