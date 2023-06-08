import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/EditPlantButton.dart';

const String GET_PLANT = '''
query getPlant(\$id: String!){
  getPlant(id: \$id){
    id
    name
    picture
  }
}
''';

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
        body: Query(
            options: QueryOptions(document: gql(GET_PLANT), variables: {
              'id': plantId,
            }),
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
              final plant = result.data!['getPlant'];

              final name = plant['name'];
              final photo = plant['picture'] ??
                  'https://networkofnature.org/species/images/image-coming-soon.png';
              return Column(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 1,
                      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(photo))),
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: EditPlantButton(),
                  ),
                ],
              );
            }));
  }
}
