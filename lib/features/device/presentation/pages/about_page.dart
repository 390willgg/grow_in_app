import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        key: const Key("AboutAppBar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Soil Humidity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Soil humidity is a measure of the amount of water present in the soil. "
              "It is crucial for plant growth and health. Monitoring soil humidity helps "
              "in efficient water usage and ensures that plants receive the right amount of water.",
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}
