import 'package:flutter/material.dart';
import 'package:yet_another_weather_app/weather/presentation/current_weather_page_components/date_time_helper.dart';

class MainStatsView extends StatelessWidget {
  final double? temperature;
  final double? windSpeed;
  final int? cloudiness;
  final DateTimeHelper dateTimeHelper = DateTimeHelper();

  MainStatsView({
    Key? key,
    required this.temperature,
    required this.windSpeed,
    required this.cloudiness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String formattedDateTime = dateTimeHelper.getFormattedDateTime();
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
                width: 30,
              ),
              Text(
                temperature.toString(),
                style: const TextStyle(fontSize: 50),
              ),
              const SizedBox(
                width: 60,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 184, 244),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      windSpeed?.toString() ?? "empty",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 88, 88, 229),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      cloudiness?.toString() ?? "empty",
                      style: const TextStyle(color: Colors.white),
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
