import 'dart:io';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:mime/mime.dart';

class GridViewAttachments extends StatelessWidget {
  final List<String> files;
  //final int length;
  const GridViewAttachments({
    required this.files,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.amber.shade100,
      // height: screenheight,
      width: MediaQuery.of(context).size.width * 0.70,
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(5.0),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutGrid(
            // set some flexible track sizes based on the crossAxisCount
            columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
            // set all the row sizes to auto (self-sizing height)
            rowSizes: getRowSize(),
            rowGap: 5, // equivalent to mainAxisSpacing
            columnGap: 10, // equivalent to crossAxisSpacing
            // note: there's no childAspectRatio
            children: [
              // render all the cards with *automatic child placement*
              for (var i = 0; i < files.length; i++) widget_builder(files[i])
            ],
          )),
    );
  }

  Future openFile(String filepath) async {
    await OpenFile.open(filepath);
  }

  Widget widget_builder(String file) {
    if (isWord(file)) {
      return Column(
        children: [
          const Image(
              image: AssetImage('assets/word.png'),
              width: 75,
              height: 75,
              fit: BoxFit.contain),
          Text(getFileExtension(file))
        ],
      );
    } else if (isPdf(file)) {
      return Column(
        children: [
          const Image(
              image: AssetImage('assets/pdf.png'),
              width: 75,
              height: 75,
              fit: BoxFit.contain),
          Text(getFileExtension(file))
        ],
      );
    } else if (isImage(file)) {
      print(file);
      return GestureDetector(
        child: Column(
          children: [
            Container(
              child: Image.file(File(file),
                  width: 75, height: 75, fit: BoxFit.contain),
            ),
            Text(getFileExtension(file))
          ],
        ),
        onTap: () {
          openFile(file);
        },
      );
    } else {
      return Column(
        children: [
          const Image(
              image: AssetImage('assets/unknown.png'),
              width: 75,
              height: 75,
              fit: BoxFit.contain),
          Text(getFileExtension(file))
        ],
      );
    }
  }

  String getFileExtension(String fileName) {
    print(fileName);
    return "." + fileName.split('/').last;
  }

  bool isWord(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType == 'application/msword';
  }

  bool isPdf(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType == 'application/pdf';
  }

  bool isPPT(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType == 'application/mspowerpoint';
  }

  bool isImage(String path) {
    final mimeType = lookupMimeType(path);

    return mimeType!.startsWith('image/');
    ;
  }

  List<TrackSize> getRowSize() {
    var iter = files.length ~/ 3;
    if (iter == 0) {
      iter = 1;
    }
    List<TrackSize> lst = [];
    for (var i = 0; i < iter; i++) {
      lst.add(auto);
    }
    print(lst);
    return lst;
  }
}
