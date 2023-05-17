import 'package:flutter/material.dart';

class SmallTableStats extends StatelessWidget {
  final String pressure;
  final String humidity;
  final String windSpeed;
  const SmallTableStats({
    Key? key,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: const [
            Icon(Icons.pin_drop),
            SizedBox(
              height: 5,
            ),
            Icon(Icons.pin_drop),
            SizedBox(
              height: 5,
            ),
            Icon(Icons.pin_drop),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              ' Pressure ',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              ' Humidity ',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              ' Wind ',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              pressure.toString() ?? "empty", // todo TO CONTROLLER
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              humidity.toString() ?? "empty",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              windSpeed.toString() ?? "empty",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '  %',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '  %',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              ' m/s',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
