import 'package:flutter/material.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';

class SmallTableStats extends StatelessWidget {
  CurrentWeatherModel item;
  SmallTableStats({
    Key? key,
    required this.item,
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
              ' Precipitation ',
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
              item.humidity?.toString() ?? "empty",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              item.humidity?.toString() ?? "empty",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              item.windSpeed?.toString() ?? "empty",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              '  %',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '  %',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '  %',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ],
        ),
      ],
    );
  }
}
