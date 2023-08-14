import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:payumoney_sdk/payumoney_sdk.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final Dio dio = Dio();
  final payu = PayumoneySdk();

  void startPayment() async {
    await payu.buildPaymentParams(
        amount: "400.0",
        transactionId: "ORDER_123",
        phone: "9999999999",
        productInfo: "Nike shoes",
        firstName: "First name",
        email: "snooze@payu.in",
        hash: "yNXlIyCWd5PGDHEIOoTNDCby5hBLKj9SFBRjniXHDP8=",
        isProduction: false,
        userCredentials: "9999999999",
        merchantKey: "CZQ1BtoF",
        salt: "4uqq6XldSi",
        merchantName: "Ecfile Solution Pvt Ltd");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('_counter', style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(
                onPressed: () async {
                  try {
                    Response api =
                        await dio.post("https://reqres.in/api/users/23");
                    if (api.statusCode == 201) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${api.statusCode}")));
                      debugPrint(api.statusCode.toString());
                    } else {
                      debugPrint(api.statusCode.toString());
                    }
                  } catch (e) {
                    debugPrint("$e");
                  }
                },
                child: const Text("Click")),
            ElevatedButton(
                onPressed: () {
                  startPayment();
                },
                child: Text("Pay"))
          ],
        ),
      ),
    );
  }
}
