import 'package:doubble_demo/Screens/plantScreen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/BottomSheetContainer.dart';

const String GET_PLANTS = '''
{
  getPlants{
    id
    name
    picture
  }
}
''';

class PlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mine planter",
        ),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(GET_PLANTS),
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (result.data == null) {
              return const Center(
                child: Text('No plants found!'),
              );
            }
            final plants = result.data!['getPlants'];

            return ListView.builder(
              itemCount: plants?.length,
              itemBuilder: (context, index) {
                final plant = plants![index];
                final name = plant['name'];
                final photo = plant['picture'] ??
                    'https://networkofnature.org/species/images/image-coming-soon.png';
                return Column(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlantScreen(plantId: plant['id'])),
                          );
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.95,
                            margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(photo))),
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))))),
                  ],
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return CreateUpdateModalContainer();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
