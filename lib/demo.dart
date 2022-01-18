import 'package:flutter/material.dart';
import 'package:flutter_video/error_page.dart';
import 'package:flutter_video/weatherModel.dart';
import 'package:dio/dio.dart';

class Demo extends StatefulWidget {
  Demo({Key? key, required this.text}) : super(key: key);
  final text;

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Integration'),
      ),
      body: FutureBuilder<Weather>(
        future: httpRequest(widget.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                children: <Widget>[
                  _buildText(widget.text, 60, Colors.black, true),
                  _buildText('Today', 40, Colors.grey, false),
                  _buildText(snapshot.data!.desc, 20, Colors.black, false),
                  SizedBox(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildDisplayCard(
                            Icons.thermostat, snapshot.data!.temp, Colors.red),
                        _buildDisplayCard(
                            Icons.air, snapshot.data!.wind, Colors.blue),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Card(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            FittedBox(
                              child: Text(
                                'Forecast for Tomorrow',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.thermostat,
                                    size: 30,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    snapshot.data!.forecast!.first.temp
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.air,
                                    size: 30,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    snapshot.data!.forecast!.first.wind
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorPage();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Container _buildDisplayCard(IconData icon, String? result, Color iconColor) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: Colors.blue[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
              SizedBox(
                height: 10,
              ),
              FittedBox(
                child: Text(
                  result!,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildText(String? text, double size, Color color, bool bold) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text!,
        style: TextStyle(
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : null,
          color: color,
        ),
      ),
    );
  }

  //build request method
  //this method is async operation
  Future<Weather> httpRequest(String text) async {
    var dio = Dio();
    var response =
        await dio.get('https://goweather.herokuapp.com/weather/$text');

    var _weather = Weather.fromJson(response.data);
    return _weather;
  }
}
