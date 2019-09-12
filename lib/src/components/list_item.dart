import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListItemState();
  }
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              child: Text("DOG"),
            ),
            Text(
              "Nombre",
              style: TextStyle(fontSize: 20.0),
            ),
            Text("Vacunas")
          ],
        ),
      ),
    );
  }
}
