import 'dart:io';

import 'package:dog_care1/src/blocs/home_bloc.dart';
import 'package:dog_care1/src/components/list_item.dart';
import 'package:dog_care1/src/models/dog.dart';
import 'package:flutter/material.dart';

import 'detail_dog_screen.dart';
import 'new_dog_screen.dart';

class HomeScreen extends StatefulWidget {
  static final identifier = '/homeScreen';

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      child:
                          InkWell(child: Text("Salir"), onTap: () => exit(0)),
                      value: "salir",
                    ),
                    const PopupMenuItem(
                      child: Text("Cerrar Sesión"),
                      value: 'cerrar',
                    )
                  ])
        ],
        title: Text("Perritos"),
      ),
      body: _allDogs(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewDogScreen.identifier);
        },
        child: Icon(Icons.pets),
      ),
    );
  }

  Widget _allDogs() {
    return FutureBuilder(
      future: homeBloc.getAllDogs(),
      builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return data.length > 0
                ? _createList(snapshot.data)
                : Text("No existe perros en la base de datos");
          } else
            return Text("No existe perros en la base de datos");
        }
      },
    );
  }

  Widget _createList(List<Dog> dogs) {
    return ListView.builder(
        itemCount: dogs.length,
        itemBuilder: (BuildContext context, int index) {
          final dogOb = dogs[index];

          return Container(
            child: GestureDetector(
                onTap: () => _showDialog(dogs[index]),
                child: Dismissible(
                  key: Key(dogOb.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      homeBloc.removeDog(dogOb.id);
                    });

                    //mostrar snackbar
                  },
                  background: Container(
                    alignment: Alignment(0.9, 0.0),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            foregroundColor: Colors.black,
                            child: Text(dogOb.nombre.substring(0, 2)),
                          ),
                          Container(width: 20.0),
                          Text(
                            dogOb.nombre,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Container(width: 20.0),
                          Text(dogOb.raza),
                          Container(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  _showDialog(Dog dog) {
    Navigator.pushNamed(context, DetailDogScreen.identifier, arguments: dog);
  }
}
