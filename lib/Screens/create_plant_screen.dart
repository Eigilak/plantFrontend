import 'package:flutter/material.dart';

import '../components/create_modal.dart';

class CreatePlantScreen extends StatelessWidget {
  const CreatePlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.95,
      child: ElevatedButton(
        child: const Text('Edit Plant'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return CreateModal();
            },
          );
        },
      ),
    );
  }
}
