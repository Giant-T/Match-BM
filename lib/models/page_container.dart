import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  final Widget body;

  const PageContainer({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(
              Icons.home,
              size: 50,
            ),
            Icon(
              Icons.account_circle,
              size: 50,
            ),
            Icon(
              Icons.menu,
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
