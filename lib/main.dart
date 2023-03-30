import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_state_management/provider/count.dart';
import 'package:learn_state_management/provider/posts.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int value = ref.watch(countProvider);
    AsyncValue posts = ref.watch(postProvider);

    return MaterialApp(
      title: 'Riverpod Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('State Management using Riverpod')),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value.toString()),
              TextButton(
                onPressed: () => ref.read(countProvider.notifier).decrement(),
                child: Text('Decrease value'),
              ),
              posts.when(
                data: (data) {
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final text = data[index]['title'];
                        return Card(
                          child: Text(text),
                        );
                      },
                      itemCount: data.length,
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => ref.read(countProvider.notifier).increment(),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
