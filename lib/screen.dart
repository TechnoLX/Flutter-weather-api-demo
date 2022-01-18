import 'package:flutter/material.dart';
import 'package:flutter_video/demo.dart';
import 'package:flutter_video/weatherModel.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _controller = TextEditingController();
  Weather? info;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Insert City Name'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          setState(() {
            text = _controller.text;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Demo(
                      text: text,
                    )));
          });
          _controller.clear();
        },
      ),
    );
  }
}
