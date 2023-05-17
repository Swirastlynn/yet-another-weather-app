import 'package:flutter/material.dart';

class MainStatsView extends StatelessWidget {
  final String temperature;
  final String windSpeed;
  final String cloudiness;
  final String formattedDateTime;

  const MainStatsView({
    Key? key,
    required this.temperature,
    required this.windSpeed,
    required this.cloudiness,
    required this.formattedDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      temperature,
                      style: const TextStyle(fontSize: 40),
                    ),
                    const Text(
                      '\u00B0C',
                      style: TextStyle(fontSize: 35),
                    ),
                  ],
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
                        cloudiness,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                )
              ],
            ),
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
