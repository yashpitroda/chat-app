import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onselectImage;

  const ImageInput({super.key, required this.onselectImage});
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? finalImage;

  Future<void> _takeImage(ImageSource source_) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source_, maxWidth: 600);
      if (image == null) {
        return;
      }
      print("path is");
      print(image.path);
      final imageTemperaly = File(image.path);
      setState(() {
        finalImage = imageTemperaly;
      });
      widget.onselectImage(finalImage);
    } on PlatformException catch (e) {
      print('fail to pick image form gallery $e');
    }
  }

  void _emptyIMGBox() {
    setState(() {
      finalImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.image,
                                ),
                                // label: Text('from Gallery'),
                                onPressed: () =>
                                    _takeImage(ImageSource.gallery),
                              ),
                              Text('gallery'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.camera,
                                ),
                                // label: Text('from Gallery'),
                                onPressed: () => _takeImage(ImageSource.camera),
                              ),
                              Text('camara'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                ),
                                // label: Text('from Gallery'),
                                onPressed: () => _emptyIMGBox(),
                              ),
                              Text('delete'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          // child: Container(
          //   width: 160,
          //   height: 120,
          //   decoration: BoxDecoration(
          //     border: Border.all(width: 1, color: Colors.grey),
          //   ),
          //   child: finalImage != null
          //       ? Image.file(
          //           finalImage!,
          //           fit: BoxFit.cover,
          //           width: double.infinity,
          //         )
          //       : Text(
          //           'No Image Taken',
          //           textAlign: TextAlign.center,
          //         ),
          //   alignment: Alignment.center,
          // ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: finalImage != null ? FileImage(finalImage!) : null,
          ),
        ),
        TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Container(
                      height: 100,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.image,
                                  ),
                                  // label: Text('from Gallery'),
                                  onPressed: () =>
                                      _takeImage(ImageSource.gallery),
                                ),
                                Text('gallery'),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.camera,
                                  ),
                                  // label: Text('from Gallery'),
                                  onPressed: () =>
                                      _takeImage(ImageSource.camera),
                                ),
                                Text('camara'),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                  // label: Text('from Gallery'),
                                  onPressed: () => _emptyIMGBox(),
                                ),
                                Text('delete'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            icon: Icon(Icons.image),
            label: Text('add image')),
        // SizedBox(
        //   width: 20,
        // ),
        // Expanded(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       ElevatedButton.icon(
        //         icon: Icon(Icons.image),
        //         label: Text('from Gallery'),
        //         onPressed: () => _takeImage(ImageSource.gallery),
        //       ),
        //       ElevatedButton.icon(
        //         icon: Icon(Icons.camera),
        //         label: Text('from camara'),
        //         onPressed: () => _takeImage(ImageSource.camera),
        //       ),
        //       ElevatedButton.icon(
        //         icon: Icon(Icons.delete),
        //         label: Text('remove'),
        //         onPressed: () => _emptyIMGBox(),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
