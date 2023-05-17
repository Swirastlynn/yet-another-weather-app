import 'package:flutter/material.dart';
import 'package:yet_another_weather_app/weather/function/date_time_helper.dart';

class MainStatsView extends StatelessWidget {
  final String temperature;
  final String windSpeed;
  final String cloudiness;

  const MainStatsView({
    Key? key,
    required this.temperature,
    required this.windSpeed,
    required this.cloudiness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String formattedDateTime = getFormattedDateTime();
    return Container(
      height: 260,
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Los Angeles, CA, USA',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                temperature,
                style: const TextStyle(fontSize: 50),
              ),
              const Text(
                '\u00B0C',
                style: TextStyle(fontSize: 43),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 184, 244),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      windSpeed,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 88, 88, 229),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      cloudiness,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(formattedDateTime),
        ],
      ),
    );
  }
}
