import 'package:flutter/material.dart';
import 'package:your_project_name/widgets/switch_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Automation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SwitchWidget(
              label: 'Switch 1',
              onStateChanged: (value) {
                // Send control command for Switch 1 to NodeMCU8266
              },
            ),
            SwitchWidget(
              label: 'Switch 2',
              onStateChanged: (value) {
                // Send control command for Switch 2 to NodeMCU8266
              },
            ),
            // Add more SwitchWidget instances for other switches
          ],
        ),
      ),
    );
  }
}
