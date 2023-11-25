import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> commpactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}

// void test() {
//   final values = [1, 2, null, 3];
//   final nonNullValues = values.commpactMap((e) {
//     if (e!= null && e > 10) {
//       return e;
//     } else {
//       return null;
//     }
//   });
// }

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

const url =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGvRdGiLBXC9-23P8lrAPQvOiIg-bR4E3pka7uv2Yosg&s';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final image = useFuture(
    //   //grab image
    //   NetworkAssetBundle(Uri.parse(url))
    //       .load(url)
    //       .then((data) => data.buffer.asUint8List())
    //       .then(
    //         (data) => Image.memory(data),
    //       ),
    // ); re-download
    final future = useMemoized(
      () =>
          //grab image
          NetworkAssetBundle(Uri.parse(url))
              .load(url)
              .then((data) => data.buffer.asUint8List())
              .then(
                (data) => Image.memory(data),
              ),
    );

    final snapshot = useFuture(future);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Home page'),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // image.hasData ? image.data! : null, //re-download
          snapshot.data
        ].commpactMap().toList(),
      ),
    );
  }
}
