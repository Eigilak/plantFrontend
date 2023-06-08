import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:developer';

class PlantScreen extends StatelessWidget {
  final String plantId;

  const PlantScreen({required this.plantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'min plante $plantId',
          ),
        ),
        body: Center(child: Text('Single plant screen')));
  }
}
