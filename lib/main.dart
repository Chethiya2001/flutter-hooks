import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final text = useState('');
    useEffect(() {
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller] //as a key
        );
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Home page'),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(controller: controller),
          const SizedBox(
            height: 20,
          ),
          Text('You types:${text.value}')
        ],
      ),
    );
  }
}
