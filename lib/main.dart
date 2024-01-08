import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lesson_27_get_dogs/dio_settings.dart';
import 'package:lesson_27_get_dogs/dogs_model.dart';
import 'package:lesson_27_get_dogs/error_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dog API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String image = "https://images.dog.ceo/breeds/pembroke/n02113023_1912.jpg";
  String image = '';
  String errorText = '';
  @override
  void initState() {
    getRandomImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: errorText == ''
            ? image == ''
                ? const CircularProgressIndicator()
                : Image.network(image,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.error,
                          size: 100,
                          color: Colors.red,
                        ))
            : Text(
                textAlign: TextAlign.center,
                errorText,
                style: const TextStyle(fontSize: 30),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getRandomImage();
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Future<void> getRandomImage() async {
    Dio dio = DioSettings().dio;

    try {
      final Response response =
          await dio.get('https://dog.ceo/api/breeds/image/random');

      final DogsModel dogsModel = DogsModel.fromJson(response.data);

      image = dogsModel.message ?? '';
    } catch (e) {
      if (e is DioException) {
        final ErrorModel erroeModel = ErrorModel.fromJson(e.response?.data);
        errorText = erroeModel.message ?? 'Ошибка';
      } else {
        errorText = 'Error';
      }
    }
    setState(() {});
  }
}
