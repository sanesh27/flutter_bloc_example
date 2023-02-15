import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                return context.go('/timer');
              },
              child: const Center(
                child: Text("Timer App"),
              ),
          ),
          ElevatedButton(
              onPressed: () {
                return context.go('/album');
              },
              child: const Center(
                child: Text("Album App"),
              ),
          ),
        ],
      ),
    );
  }
}
