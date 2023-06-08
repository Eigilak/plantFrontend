import 'package:flutter/material.dart';


class CreatePlantScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Opret en ny planten",
        ),
      ),
      body: Center(
          child: Text('Create plant screen')
      )
    );
  }
}