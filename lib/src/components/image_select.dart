import 'dart:io' show File;

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'loading_screen.dart';

const gallery_type = 1;
const camera_type = 2;

class ImageBtn extends StatefulWidget {
  final ValueChanged<File> onResult;

  ImageBtn({this.onResult});

  @override
  State<StatefulWidget> createState() {
    return _ImageBtnState();
  }
}

class _ImageBtnState extends State<ImageBtn> {
  File image;

  @override
  Widget build(BuildContext context) {
    return Container(child: _imageBtn());
  }

  Widget _imageBtn() {
    if (image != null) {
      return Container(
          child: GestureDetector(
        onTap: () async {
          final imageResponse = await selectImageSourceAlert();
          if (imageResponse != null) {
            setState(() {
              image = imageResponse;
            });
            if (widget.onResult != null) {
              widget?.onResult(image);
            }
          }
        },
        child: Container(
          height: 250,
          color: Colors.green,
          child: Center(
            child: ClipOval(
              child:
                  Image.file(image, width: 200, height: 200, fit: BoxFit.cover),
            ),
          ),
        ),
      ));
    } else {
      return Container(
          child: GestureDetector(
              onTap: () async {
                final imageResponse = await selectImageSourceAlert();
                if (imageResponse != null) {
                  setState(() {
                    image = imageResponse;
                  });

                  if (widget.onResult != null) {
                    widget?.onResult(image);
                  }
                }
              },
              child: Container(
                child: Center(
                    child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.add_a_photo, size: 75.0))),
                height: 250,
                color: Colors.green,
              )));
    }
  }

  Future<File> selectImageSourceAlert() async {
    final int selectedType = await showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: Text("Imagen"),
            content: Text("Seleccione fuente de la imagen."),
            actions: <Widget>[
              FlatButton(
                child: Text("Cámara"),
                onPressed: () async {
                  Navigator.pop(context, camera_type);
                },
              ),
              FlatButton(
                child: Text("Galería"),
                onPressed: () async {
                  Navigator.pop(context, gallery_type);
                },
              )
            ],
          );
        });

    File imageResponse;
    if (selectedType != null) {
      loadingScreen(context);
      imageResponse = await _getImage(selectedType);
      Navigator.of(context).pop();
    }

    return imageResponse;
  }

  Future<File> _getImage(int from) async {
    print("image picker init");
    File image;

    final permissions = await _askPermissions();
    if (permissions) {
      image = await ImagePicker.pickImage(
          source:
              from == gallery_type ? ImageSource.gallery : ImageSource.camera);
    }
    return image;
  }

  Future<bool> _askPermissions() async {
    //se revisa si tiene permisos de camara
    PermissionStatus cameraPermission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (cameraPermission.value == 0) {
      //si no tiene se le pregunta
      await PermissionHandler().requestPermissions([PermissionGroup.camera]);
      cameraPermission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.camera);
    }

    if (cameraPermission.value == 0) return false;

    //se revisa si tiene permiso para la galería
    PermissionStatus galleryPermission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (galleryPermission.value == 0) {
      //si no tiene se le pregunta
      PermissionHandler().requestPermissions([PermissionGroup.storage]);
      galleryPermission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
    if (galleryPermission.value == 0) {
      return false;
    }

    return true;
  }
}
