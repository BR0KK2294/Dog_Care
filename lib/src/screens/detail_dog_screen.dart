import 'package:dog_care1/src/models/dog.dart';
import 'package:flutter/material.dart';

class DetailDogScreen extends StatefulWidget {
  static const identifier = '/detailDogoScreen';

  @override
  State<StatefulWidget> createState() {
    return _DetailDogState();
  }
}

class _DetailDogState extends State<DetailDogScreen> {
  @override
  Widget build(BuildContext context) {
    final Dog dogo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("Detalle"),
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            Container(
              height: 250.0,
              color: Colors.green,
              child: Center(
                child: ClipOval(
                    child: Image.network(
                        "https://nutricionistadeperros.com/wp-content/uploads/2012/01/perro-cachorro.jpg",
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              dogo.nombre,
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                            Text(dogo.raza),
                          ],
                        ),
                        Text(
                          dogo.edad.toString() + " Años",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Text(dogo.desc, style: TextStyle(fontSize: 18.0)),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(),
                          Text("Datos del dueño"),
                          Container(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                dogo.dueno,
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Text(
                                dogo.fonoDueno.toString(),
                                style: TextStyle(fontSize: 20.0),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
