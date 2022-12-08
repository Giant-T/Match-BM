import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/page_container.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageContainer(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
