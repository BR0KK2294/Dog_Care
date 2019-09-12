import 'package:dog_care1/src/blocs/new_dog_bloc.dart';
import 'package:dog_care1/src/components/image_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewDogScreen extends StatefulWidget {
  static const identifier = '/newDogoScreen';

  @override
  State<StatefulWidget> createState() {
    return _NewDogState();
  }
}

class _NewDogState extends State<NewDogScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    newDogBloc.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Nuevo Perro"),
      ),
      body: Center(
        child: _formDog(),
      ),
    );
  }

  _formDog() {
    return Container(
      child: ListView(
        children: <Widget>[
          ImageBtn(),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(child: _nombreInput()),
                      Container(width: 50),
                      Flexible(child: _edadInput())
                    ],
                  ),
                  _dropdown(),
                  _descripcionInput(),
                  _duenoInput(),
                  _duenoFonoInput(),
                  submitButton()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nombreInput() {
    return TextField(
      controller: newDogBloc.nombreCtrl,
      decoration: InputDecoration(hintText: "Nombre"),
    );
  }

  Widget _descripcionInput() {
    return TextField(
      maxLength: 255,
      controller: newDogBloc.descCtrl,
      decoration: InputDecoration(hintText: "Descripcion"),
    );
  }

  Widget _edadInput() {
    return TextField(
      maxLength: 2,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      controller: newDogBloc.edadCtrl,
      decoration: InputDecoration(hintText: "Edad"),
    );
  }

  Widget _duenoInput() {
    return TextFormField(
      controller: newDogBloc.duenoCtrl,
      decoration: InputDecoration(hintText: "Nombre del dueño"),
    );
  }

  Widget _duenoFonoInput() {
    return TextField(
      maxLength: 12,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      controller: newDogBloc.fonoCtrl,
      decoration: InputDecoration(hintText: "fono del deño"),
    );
  }

  Widget _dropdown() {
    return DropdownButton(
      onChanged: (newVal) {
        setState(() {
          newDogBloc.raza = newVal;
        });
      },
      value: newDogBloc.raza,
      hint: Text("Selecciona la raza del perro"),
      isExpanded: true,
      items: <DropdownMenuItem>[
        DropdownMenuItem<String>(
          value: "Beagle",
          child: Text("Beagle"),
        ),
        DropdownMenuItem<String>(
          value: "Pug",
          child: Text("Pug"),
        ),
        DropdownMenuItem<String>(
          value: "Galgo",
          child: Text("Galgo"),
        ),
        DropdownMenuItem<String>(
          value: "Pastor Aleman",
          child: Text("Pastor Aleman"),
        ),
        DropdownMenuItem<String>(
          value: "Husky",
          child: Text("Husky"),
        ),
        DropdownMenuItem<String>(
          value: "Bulldog",
          child: Text("Bulldog"),
        )
      ],
    );
  }

  RaisedButton submitButton() {
    return RaisedButton(
      onPressed: _submitAction,
      color: Colors.green,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text("Ingresar Perro",
            style: TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
    );
  }

  _submitAction() async {
    final response = await newDogBloc.saveDog();
  }
}
