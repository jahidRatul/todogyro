import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class SensorHomePage extends StatefulWidget {
  @override
  _SensorHomePageState createState() => _SensorHomePageState();
}

class _SensorHomePageState extends State<SensorHomePage> {

  List<double> _gyroscopeValues = [0.0, 0.0, 0.0];
  List<double> _accelerometerValues = [0.0, 0.0, 0.0];
  List<_SensorData> gyroData = [];
  List<_SensorData> accelData = [];
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  final int _maxDataPoints = 100; // Number of data points to show
  bool _alertTriggered = false;


  List<_SensorData> walkingGyroData = [];
  List<_SensorData> meetingGyroData = [];
// Number of data points to show
  GyroscopeEvent? lastGyroEvent;



// Start listening to the gyroscope sensor data stream
  // Start listening to the gyroscope sensor data stream
  void _startGyroscopeStream() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (mounted){setState(() {
        lastGyroEvent = event;

        // Add live gyro data for walking
        _addGyroDataToChart(event, walkingGyroData);

        // Simulate a condition for meeting data (you can change this)
        if (event.x.abs() < 0.2 && event.y.abs() < 0.2 && event.z.abs() < 0.2) {
          _addGyroDataToChart(event, meetingGyroData);
        }

        // Keep the data list size within the _maxDataPoints for both walking and meeting
        if (walkingGyroData.length > _maxDataPoints) {
          walkingGyroData.removeAt(0); // Remove the oldest data point
        }
        if (meetingGyroData.length > _maxDataPoints) {
          meetingGyroData.removeAt(0); // Remove the oldest data point
        }
      });}

    });
  }
  void _addGyroDataToChart(GyroscopeEvent event, List<_SensorData> dataList) {
    dataList.add(_SensorData(event.x, event.y, event.z));
  }


  @override
  void initState() {
    super.initState();
    _startGyroscopeStream();
    _startListening();
  }

  void _startListening() {
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = [event.x, event.y, event.z];
        gyroData.add(_SensorData(event.x, event.y, event.z));
        if (gyroData.length > _maxDataPoints) gyroData.removeAt(0);
        _checkAlert();
      });
    });

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = [event.x, event.y, event.z];
            accelData.add(_SensorData(event.x, event.y, event.z));
            if (accelData.length > _maxDataPoints) accelData.removeAt(0);
            _checkAlert();
          });
        });
  }

  void _checkAlert() {
    // Threshold for high movement, adjust as needed
    double threshold = 1.5;

    bool highAccel = _accelerometerValues.any((v) => v.abs() > threshold);
    bool highGyro = _gyroscopeValues.any((v) => v.abs() > threshold);

    if (highAccel && highGyro && !_alertTriggered) {
      _alertTriggered = true;
      _showAlert();
    } else if (!highAccel && !highGyro) {
      _alertTriggered = false;
    }
  }

  void _showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ALERT"),
          content: Text("High movement detected on two axes!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _alertTriggered = false;
                });
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sensor Tracking'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
      
                  // Meeting Gyro Data Chart
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Gyro Data - Meeting',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 200,
                          child: SfCartesianChart(
                            primaryXAxis: NumericAxis(
                              title: AxisTitle(text: 'Samples'),
                            ),
                            primaryYAxis: NumericAxis(
                              title: AxisTitle(text: 'Gyroscope sensor data (rad/s)'),
                            ),
                            series: <LineSeries<_SensorData, int>>[
                              LineSeries<_SensorData, int>(
                                dataSource: meetingGyroData,
                                xValueMapper: (_SensorData data, int index) => index,
                                yValueMapper: (_SensorData data, _) => data.x,
                                name: 'X Axis',
                                color: Colors.red,
                              ),
                              LineSeries<_SensorData, int>(
                                dataSource: meetingGyroData,
                                xValueMapper: (_SensorData data, int index) => index,
                                yValueMapper: (_SensorData data, _) => data.y,
                                name: 'Y Axis',
                                color: Colors.green,
                              ),
                              LineSeries<_SensorData, int>(
                                dataSource: meetingGyroData,
                                xValueMapper: (_SensorData data, int index) => index,
                                yValueMapper: (_SensorData data, _) => data.z,
                                name: 'Z Axis',
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  // Walking Gyro Data Chart
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Gyro Data - Walking',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 200,
                          child: SfCartesianChart(
                            primaryXAxis: NumericAxis(
                              title: AxisTitle(text: 'Samples'),
                            ),
                            primaryYAxis: NumericAxis(
                              title: AxisTitle(text: 'Gyroscope sensor data (rad/s)'),
                            ),
                            series: <LineSeries<_SensorData, int>>[
                              LineSeries<_SensorData, int>(
                                dataSource: walkingGyroData,
                                xValueMapper: (_SensorData data, int index) => index,
                                yValueMapper: (_SensorData data, _) => data.x,
                                name: 'X Axis',
                                color: Colors.red,
                              ),
                              LineSeries<_SensorData, int>(
                                dataSource: walkingGyroData,
                                xValueMapper: (_SensorData data, int index) => index,
                                yValueMapper: (_SensorData data, _) => data.y,
                                name: 'Y Axis',
                                color: Colors.green,
                              ),
                              LineSeries<_SensorData, int>(
                                dataSource: walkingGyroData,
                                xValueMapper: (_SensorData data, int index) => index,
                                yValueMapper: (_SensorData data, _) => data.z,
                                name: 'Z Axis',
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      
                ],
              ),
      
              // Accelerometer Data Chart
              Column(
                children: [
                  Text(
                    'Accelerometer Sensor Data',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SfCartesianChart(
                    primaryXAxis: NumericAxis(
                      title: AxisTitle(text: 'Samples'),
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Acceleration (m/s²)'),
                    ),
                    series: <LineSeries<_SensorData, int>>[
                      LineSeries<_SensorData, int>(
                        dataSource: accelData,
                        xValueMapper: (_SensorData data, int index) => index,
                        yValueMapper: (_SensorData data, _) => data.x,
                        name: 'X Axis',
                        color: Colors.red,
                      ),
                      LineSeries<_SensorData, int>(
                        dataSource: accelData,
                        xValueMapper: (_SensorData data, int index) => index,
                        yValueMapper: (_SensorData data, _) => data.y,
                        name: 'Y Axis',
                        color: Colors.green,
                      ),
                      LineSeries<_SensorData, int>(
                        dataSource: accelData,
                        xValueMapper: (_SensorData data, int index) => index,
                        yValueMapper: (_SensorData data, _) => data.z,
                        name: 'Z Axis',
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SensorData {
  final double x;
  final double y;
  final double z;

  _SensorData(this.x, this.y, this.z);
}