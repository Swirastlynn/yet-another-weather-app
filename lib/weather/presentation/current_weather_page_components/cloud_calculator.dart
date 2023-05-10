class CloudCalculator {
  String cloudRating(int cloudiness) {
    if (cloudiness >= 0 && cloudiness <= 10) {
      return 'Clear sky';
    } else if (cloudiness > 10 && cloudiness <= 30) {
      return 'Partly cloudy';
    } else if (cloudiness > 30 && cloudiness <= 55) {
      return 'Moderate cloudy';
    } else if (cloudiness > 55 && cloudiness <= 80) {
      return 'Heavy cloudy';
    } else if (cloudiness > 80) {
      return 'Overcast';
    } else {
      return 'Incorrect data';
    }
  }
}
